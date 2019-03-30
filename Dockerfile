FROM openjdk:8

RUN set -eux \
  && apt update \
  && apt install -y \
    gettext-base \
    postgresql-client \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSL https://get.docker.com -o get-docker.sh \
  && sh get-docker.sh \
  && groupadd -r digdag \
  && useradd --no-log-init -d /opt/digdag -g digdag -G docker digdag \
  && mkdir -p /opt/digdag/logs \
  && mkdir -p /opt/digdag/logs/accesslogs \
  && mkdir -p /opt/digdag/logs/tasklogs \
  && mkdir -p /opt/digdag/database \
  && chown -R digdag:digdag /opt/digdag \
  && curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x /usr/local/bin/digdag

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER digdag

EXPOSE 65432 65433

ENTRYPOINT ["/entrypoint.sh"]

CMD ["digdag", "server", "--task-log", "/opt/digdag/logs/tasklogs", "--access-log", "/opt/digdag/logs/accesslogs", "-b", "0.0.0.0", "-o", "/opt/digdag/database"]
