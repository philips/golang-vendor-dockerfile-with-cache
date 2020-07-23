# Go + vendor/ + cache

This is an attempt at a Go Dockerfile that caches as much as possible for fast builds. This came out of frustration trying to use skaffold.io and sitting through buildtimes that felt like a C++ code base.

See the [Dockerfile](https://github.com/philips/golang-vendor-dockerfile-with-cache/blob/master/Dockerfile)!

**Prior Art**
- A [reddit thread](https://www.reddit.com/r/golang/comments/hj4n44/improved_docker_go_module_dependency_cache_for/) with a bunch of stuff but doesn't use vendor/
- [Go 1.10 discussion thread](https://stackoverflow.com/questions/50520103/speeding-up-go-builds-with-go-1-10-build-cache-in-docker-containers) that uses old style vendor hacks
- [Blog post](https://www.docker.com/blog/containerize-your-go-developer-environment-part-3/) on new `docker buildx` features that use the Go build cache as a volume but is experimental
