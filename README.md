bucklescript-tea with Melange (Nix workflow)

Execute the following steps to produce an executable output in `_build/default/src` dir, and a running server that serves the app from that dir.

1. `cd spiced-tea`
1. Configure flake to automatically load on `cd`: `direnv allow`
1. `yarn install`
1. Reload the flake so that melange runtime libs are symlinked to node_modules/melange (which node/js utilities need to run melange): `cd .. && cd spiced-tea`
1. `mel clean`
1. `mel build`
1. `cp ./src/{index.html,index.js} _build/default/src/`
1. `./node_modules/.bin/browserify _build/default/src/index.js -o _build/default/src/index.br.js`
1. `./node_modules/.bin/http-server _build/default/src`

There is a lot of scope to improve the workflow. But this is the bare minimum.
