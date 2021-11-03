import Text.ParserCombinators.ReadP
import Control.Applicative hiding (many)
import Data.Char
import Data.Maybe
import qualified Data.ByteString.Char8 as C

data Op = Add | Sub | Mul | Div | Pow
    deriving (Show, Eq, Ord)

opDefs op = case op of
    Add -> (0, '+')
    Sub -> (0, '-')
    Mul -> (1, '*')
    Div -> (1, '/')
    Pow -> (2, '^')

opPrecedence :: Op -> Int
opPrecedence = fst . opDefs

opSymbol :: Op -> Char
opSymbol = snd . opDefs

data ExprTree
    = Expr2 ExprTree Op ExprTree
    | Expr1 Op ExprTree
    | Parem ExprTree
    | Var String
    deriving (Show)

readInfixExpr :: String -> Maybe ExprTree
readInfixExpr line = 
    case readP_to_S exprP line of
        [] -> Nothing
        xs -> Just (fst $ last xs)
    where expr2P lhsP opP rhsP = (Expr2 <$> lhsP <*> opP <*> rhsP) <++ lhsP
          varP   = Var <$> munch1 (\ch -> isLetter ch || isDigit ch)
          opP op = op <$ char (opSymbol op)
          opsP   = choice . map opP
          paremP   = Parem <$> between (char '(') (char ')') exprP
          primaryP = varP <++ paremP
          factorP  = expr2P primaryP (opP Pow) factorP
          termP    = expr2P factorP (opsP [Mul, Div]) termP
          exprP    = expr2P termP (opsP [Add, Sub]) exprP

exprTreeShow (Var v) = "Var(" ++ v ++ ")"
exprTreeShow (Parem expr) = "Parem(" ++ exprTreeShow expr ++ ")"
exprTreeShow (Expr1 op expr) = 
    "[(" ++ show op ++ ") " ++ exprTreeShow expr ++ ")"
exprTreeShow (Expr2 lhs op rhs) = 
    "[" ++ exprTreeShow lhs ++ " (" ++ show op ++ ") " ++ exprTreeShow rhs ++ "]"

showPosfixExpr :: ExprTree -> String
showPosfixExpr = go Nothing
    where opString op = [opSymbol op]
          maybeOp = maybe "" opString
          go lastOp (Var v) = v ++ maybeOp lastOp
          go lastOp (Parem expr) = go Nothing expr ++ maybeOp lastOp
          go lastOp (Expr1 op expr) = 
            go Nothing expr ++ maybeOp lastOp ++ opString op
          go lastOp (Expr2 (Parem lhs) op (Parem rhs)) =
            go Nothing lhs ++ go Nothing rhs ++ opString op ++ maybeOp lastOp
          go Nothing (Expr2 lhs op rhs) =
            go Nothing lhs ++ go (Just op) rhs
          go (Just lastOp) (Expr2 lhs op rhs)
            | precsEq   = go Nothing lhs ++ opString lastOp ++ go (Just op) rhs
            | otherwise = go Nothing lhs ++ go (Just op) rhs ++ opString lastOp
            where precsEq = opPrecedence lastOp == opPrecedence op

main = C.interact
    $ C.unlines
    . map (C.pack . maybe "" showPosfixExpr . readInfixExpr . C.unpack)
    . tail
    . C.lines
