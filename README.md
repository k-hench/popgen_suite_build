# README for `popgen_suite`

Github repository for the [podman](https://podman.io/) conatiner [`popgen_suite`](https://hub.docker.com/repository/docker/khench/popgen_suite).

## Documentation of the initial setup

Originally, the `popgen_suite` container was build using [buildah](https://buildah.io/), from the accompanying `Containerfile`:

```sh
buildah bud -t popgen_suite
```

To make the container publicly available, it is pushed to [dockerhub](https://hub.docker.com/r/khench/genotyping_suite) using [skopeo](https://github.com/containers/skopeo) and [podman](https://podman.io/):

```sh
skopeo login -u khench docker.io
podman push localhost/popgen_suite docker.io/khench/popgen_suite:v0.1
```

## Accessing the container

The bundled software can be accessed directly from [dockerhub](https://hub.docker.com/r/khench/popgen_suite) with `podman` (or `docker`, or `apptainer`/`singularity`):

```sh
podman run docker.io/khench/popgen_suite:v0.1 vcftools --version
```