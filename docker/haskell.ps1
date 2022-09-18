$Directory = split-path -parent $PSScriptRoot

docker run `
    --rm `
    --detach `
    --interactive `
    --tty `
    --workdir "/home/haskell" `
    --volume "${Directory}:/home/haskell/" `
    --name haskell `
    haskell:8-slim
