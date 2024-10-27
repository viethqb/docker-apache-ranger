FROM docker.io/trinodb/trino:462

ARG REVISION
ARG VERSION

USER root
COPY trino/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY build-src/ranger/target/ranger-${VERSION}-${REVISION}-trino-plugin.tar.gz /tmp
RUN microdnf install gzip -y && mkdir -p /opt/ranger \
  && tar -xf /tmp/ranger-${VERSION}-${REVISION}-trino-plugin.tar.gz -C /opt/ranger --strip-components=1 \
  && chown -R  trino:trino /opt/ranger \
  && rm -f /tmp/ranger-${VERSION}-${REVISION}-trino-plugin.tar.gz

CMD ["/entrypoint.sh"]
