# Changelog

## [8.8.0](https://github.com/snowdreamtech/redis/compare/alpine-v8.0.4...alpine-v8.8.0) (2026-08-11)


### 🐛 Bug Fixes

* remove static version defaults from OCI image labels to use variable injection exclusively ([da5645a](https://github.com/snowdreamtech/redis/commit/da5645ad4d48467290235abbbd9f31ba70bf690f))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/redis/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([ce77247](https://github.com/snowdreamtech/redis/commit/ce77247762becc1edf85ec7b57747d3f3127044a))
* merge upstream dev into redis dev ([1d21b91](https://github.com/snowdreamtech/redis/commit/1d21b91bd17863b4dfcf5a9c081e3c9fc1d60cec))
* release main ([5a92edb](https://github.com/snowdreamtech/redis/commit/5a92edb4ba76b04ee6de7369e9471f785849a7ae))
* release main ([afa286c](https://github.com/snowdreamtech/redis/commit/afa286c5b9c41908021b044f31fee3348f52c973))
* release main ([4011a21](https://github.com/snowdreamtech/redis/commit/4011a21a23395acc9545168c95ca0ec5c867e7d3))
* release main ([f66597a](https://github.com/snowdreamtech/redis/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/redis/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* **release:** deduplicate CHANGELOG headers ([c2bba24](https://github.com/snowdreamtech/redis/commit/c2bba247dca89a31accc6e70c5e48b16170b1ce5))
* **release:** deduplicate CHANGELOG headers ([4f07b71](https://github.com/snowdreamtech/redis/commit/4f07b71194f58ba214f1fb60ce0dc56d71c499e2))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/redis/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* update alpine base image to 3.24.1 ([3021ed3](https://github.com/snowdreamtech/redis/commit/3021ed3b4ffa5f8916f5fa46aa4325e8ebf84ba6))

## [8.0.4](https://github.com/snowdreamtech/redis/compare/alpine-v8.0.4...alpine-v8.0.4) (2026-06-23)


### 🐛 Bug Fixes

* **docker:** set default KEEPALIVE to 1 and override it in smoke tests ([04b2322](https://github.com/snowdreamtech/redis/commit/04b2322daf09e4caec7d7a25062a9be3fa3eabf8))

## [3.24.0](https://github.com/snowdreamtech/base/compare/alpine-v3.24.0...alpine-v3.24.0) (2026-06-20)


### 🐛 Bug Fixes

* **alpine:** add empty line to trigger release pipeline test ([6f32fb1](https://github.com/snowdreamtech/base/commit/6f32fb1c9fae9bcd4e86beb2e3013a0138784372))
