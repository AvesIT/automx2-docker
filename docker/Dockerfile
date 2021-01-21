FROM python:3.9-alpine3.12
ARG BUILD_DATE
ARG VCS_REF

ENV AUTOMX2_VERSION 2021.0
ENV USER=automx2
ENV UID=1000
ENV GID=1000

LABEL maintainer="n.vogels@aves-it.nl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="AutoMX2" \
      org.label-schema.description="AutoMX2 docker container - Automx is a way to autoconfigure mailclients" \
      org.label-schema.url="https://www.automx.org/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/avesit/automx2-docker" \
      org.label-schema.vendor="automx" \
      org.label-schema.version=$AUTOMX2_VERSION \
      org.label-schema.schema-version="1.0"

RUN addgroup $USER
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/$USER" \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER"

RUN apk add --no-cache bash curl musl>1.1.24-r10 \
    && mkdir -p /srv/web/automx2 \
    && cd /srv/web/automx2 \
    && curl -o ./setupvenv.sh https://gitlab.com/automx/automx2/raw/$AUTOMX2_VERSION/contrib/setupvenv.sh\?inline=false \
    && chmod u+x ./setupvenv.sh  && ./setupvenv.sh \
    && . venv/bin/activate \
    && pip install automx2

USER automx2
WORKDIR /srv/web/automx2
COPY files/automx2.conf /etc/
VOLUME /srv/web/automx2/data
CMD ./venv/scripts/flask.sh run --host=0.0.0.0 --port=5000
