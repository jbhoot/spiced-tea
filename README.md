bucklescript-tea with Melange

Execute the following steps to produce an executable output in `_build/default/src` dir, and a running server that serves the app from that dir.

```
1. npm install
1. ./node_modules/.bin/esy
1. ./node_modules/.bin/esy build
1. cp ./src/{index.html,index.js} _build/default/src/
1. ./node_modules/.bin/browserify _build/default/src/index.js -o _build/default/src/index.br.js
1. ./node_modules/.bin/http-server _build/default/src
```

There is a lot of scope to improve the workflow. But this is the bare minimum.
