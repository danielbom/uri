$Directory = split-path -parent $PSScriptRoot

docker run `
    --rm `
    --detach `
    --name haskell `
    --volume "${Directory}:/home/haskell/" `
    --interactive `
    haskell:8-slim
