# we also use dev just because the normal image doesn't have sed but dev does so we will copy it over
FROM gridsuite/iodhi-httpd:2.4.68-debian13-dev@sha256:0e2f2508ac2cf10f8bfbcd5871f5d39e3d1f14536fe2d588603dea026aa4fd95 as dev
FROM gridsuite/iodhi-httpd:2.4.68-debian13@sha256:f8a042e7f71c9f2fc2b30519a9970b2b74b9e4b43a770d3f9144943a1e5c2cbd

RUN { \
    # Some best practice production settings, originally ideas from bitnami/apache \
    echo 'TraceEnable Off'; \
    echo 'ServerTokens Prod'; \
\
    # allow to inject just our conf, not replace the whole httpd.conf \
    echo 'Include "/usr/local/apache2/conf/app-httpd.conf"'; \
} >> /usr/local/apache2/conf/httpd.conf

