FROM openjdk:8

RUN set -eux \
  && curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x /usr/local/bin/digdag

RUN set -eux \
  && groupadd -r digdag \
  && useradd --no-log-init -r -g digdag digdag

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
  && sh get-docker.sh \
  && usermod -aG docker digdag

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER digdag

EXPOSE 65432 65433

ENTRYPOINT ["/entrypoint.sh"]

CMD ["digdag", "server", "-b", "0.0.0.0", "-o", "/tmp"]
