const readline = require("readline");

const ExpressionKind = {
  NUMBER: "NUMBER",
  VARIABLE: "VARIABLE",
  UNARY_OPERATION: "UNARY_OPERATION",
  BINARY_OPERATION: "BINARY_OPERATION",
  PARENTHESES: "PARENTHESES",
};
const BinaryOperatorsKinds = {
  PLUS: "PLUS",
  MINUS: "MINUS",
  MULT: "MULT",
  DIV: "DIV",
  POWER: "POWER",
};
const BinaryOperatorsDefs = [
  {
    kind: BinaryOperatorsKinds.PLUS,
    token: "+",
    precedence: 0,
  },
  {
    kind: BinaryOperatorsKinds.MINUS,
    token: "-",
    precedence: 0,
  },
  {
    kind: BinaryOperatorsKinds.MULT,
    token: "*",
    precedence: 1,
  },
  {
    kind: BinaryOperatorsKinds.DIV,
    token: "/",
    precedence: 1,
  },
  {
    kind: BinaryOperatorsKinds.POWER,
    token: "^",
    precedence: 2,
  },
];
const UnaryOperatorsKinds = {
  MINUS: "MINUS",
};
const UnaryOperatorsDefs = [
  {
    kind: UnaryOperatorsKinds.MINUS,
    token: "-",
  },
];

const UnaryOperatorsDefsByKind = Object.fromEntries(
  UnaryOperatorsDefs.map((def) => [def.kind, def])
);

const BinaryOperatorsDefsByKind = Object.fromEntries(
  BinaryOperatorsDefs.map((def) => [def.kind, def])
);
const BinaryOperatorsDefsByTokens = Object.fromEntries(
  BinaryOperatorsDefs.map((def) => [def.token, def])
);
const countPrecedence =
  Math.max(...BinaryOperatorsDefs.map((def) => def.precedence)) + 1;

class Lexer {
  constructor(content) {
    this.content = content.trimLeft();
  }

  peekToken() {
    if (this.content.length === 0) {
      return { text: "" };
    }

    if (this.content.match(/^[+-/*()\^]/)) {
      return { text: this.content[0] };
    }

    const match = this.content.match(/^[a-zA-Z0-9]+/);
    if (match) {
      return { text: match[0] };
    }

    throw new Error(
      `UnknownToken: unknown token starts with '${this.content[0]}'`
    );
  }

  nextToken() {
    const token = this.peekToken();
    this.content = this.content.slice(token.text.length).trimLeft();
    return token;
  }

  parsePrimaryExpr() {
    const token = this.nextToken();

    if (token.text.length == 0) {
      throw new Error(
        "EarlyEOF: expected primary expression, but got end of input"
      );
    }

    if (token.text.match(/^\d+$/)) {
      return {
        kind: ExpressionKind.NUMBER,
        value: Number(token.text),
      };
    } else if (token.text.match(/^\(/)) {
      const expr = this.parseInfixExpr();
      const tokenAhead = this.nextToken();
      if (tokenAhead.text != ")") {
        throw new Error(
          `UncloseParenthesis: expected token ')' but got '${tokenAhead.text}'`
        );
      }
      return {
        kind: ExpressionKind.PARENTHESES,
        expr,
      };
    } else if (token.text.match(/^-/)) {
      const expr = this.parsePrimaryExpr();
      return {
        kind: ExpressionKind.UNARY_OPERATION,
        unaryOperation: {
          kind: UnaryOperatorsKinds.MINUS,
          param: expr,
        },
      };
    } else {
      return {
        kind: ExpressionKind.VARIABLE,
        variable: token.text,
      };
    }
  }

  parseBinaryOperatorExpr(precedence) {
    if (precedence >= countPrecedence) {
      return this.parsePrimaryExpr();
    }

    const lhs = this.parseBinaryOperatorExpr(precedence + 1);

    const tokenAhead = this.peekToken();
    const def = BinaryOperatorsDefsByTokens[tokenAhead.text];

    if (def && def.precedence === precedence) {
      this.nextToken();
      const rhs = this.parseBinaryOperatorExpr(precedence);

      return {
        kind: ExpressionKind.BINARY_OPERATION,
        binaryOperation: {
          kind: def.kind,
          lhs,
          rhs,
        },
      };
    }

    return lhs;
  }

  parseInfixExpr() {
    return this.parseBinaryOperatorExpr(0);
  }
}

function prefixExpr(root) {
  function go(expr, lastOp, stack) {
    switch (expr.kind) {
      case ExpressionKind.NUMBER: {
        stack.push(expr.value.toString());
        if (lastOp) stack.push(lastOp.token);
        break;
      }
      case ExpressionKind.VARIABLE: {
        stack.push(expr.variable);
        if (lastOp) stack.push(lastOp.token);
        break;
      }
      case ExpressionKind.PARENTHESES: {
        go(expr.expr, null, stack);
        if (lastOp) stack.push(lastOp.token);
        break;
      }
      case ExpressionKind.UNARY_OPERATION: {
        const op = UnaryOperatorsDefsByKind[expr.unaryOperation.kind];
        go(expr.unaryOperation.param, null, stack);
        stack.push(op.token);
        break;
      }
      case ExpressionKind.BINARY_OPERATION: {
        const op = BinaryOperatorsDefsByKind[expr.binaryOperation.kind];
        if (
          expr.binaryOperation.lhs.kind === ExpressionKind.PARENTHESES &&
          expr.binaryOperation.rhs.kind === ExpressionKind.PARENTHESES
        ) {
          go(expr.binaryOperation.lhs, null, stack);
          go(expr.binaryOperation.rhs, null, stack);
          stack.push(op.token);
        } else if (lastOp) {
          if (op.precedence === lastOp.precedence) {
            go(expr.binaryOperation.lhs, null, stack);
            stack.push(lastOp.token);
            go(expr.binaryOperation.rhs, op, stack);
          } else {
            go(expr.binaryOperation.lhs, null, stack);
            go(expr.binaryOperation.rhs, op, stack);
            stack.push(lastOp.token);
          }
        } else {
          go(expr.binaryOperation.lhs, null, stack);
          go(expr.binaryOperation.rhs, op, stack);
        }
        break;
      }
    }
  }

  const stack = [];
  go(root, null, stack);
  return stack.join("");
}

async function run() {
  let i = 0;

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  for await (const line of rl) {
    if (i > 0) {
      const content = line.toString().trim();
      if (content.length > 0) {
        const lexer = new Lexer(content);
        const expr = lexer.parseInfixExpr();
        process.stdout.write(prefixExpr(expr) + "\n");
      }
    }
    i++;
  }
}

run();
