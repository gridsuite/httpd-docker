# httpd-docker

An apache httpd docker image with overridable conf

## Context

GridSuite is deployed on kubernetes with non root user enforcement so we need a non root image.
Historically we had been using bitnami/apache, which incidentally also allowed easy configuration overrides. After bitnami discontinued its images and at around the same time DockerHub making its hardened images (DHI) freely available, we switched to DHI.

## DHI setup
### Mirroring
As of 2026 the latest version of DHI is mirrored while preserving the SHA with skopeo copy to our namespace.

### Normal and Dev
We need both "normal" and "dev" versions of the image because the "normal" image doesn't have sed which we use at runtime so we copy it into the "normal" image.

### httpd.conf
Contrary to bitnami, DHI forces us to own the whole httpd.conf file (they didn't put any Include directive to allow have our custom configuration be added to the global server configuration). When using the httpd image in an app which bundles all its assets (html/javascript/css etc) in a derived image, this is not a problem, we can append to httpd.conf directly in the same Dockerfile that copies the assets. However when using the httpd image directly and supplying small assets at deployment time, using the DHI image directly would have forced us to copy paste httpd.conf (we can't modify it in an init container or in the entrypoint because we enforce a readonly filesystem for the image). So this image exists to add this flexibility to the DHI httpd image.
