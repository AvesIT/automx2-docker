FROM python:alpine
LABEL maintainer="n.vogels@aves-it.nl"

ENV AUTOMX2_VERSION 2021.0
ENV USER=automx2
ENV UID=1000
ENV GID=1000

RUN addgroup $USER
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/$USER" \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER"

RUN apk add --no-cache bash curl \
    && mkdir -p /srv/web/automx2 \
    && cd /srv/web/automx2 \
    && curl -o ./setupvenv.sh https://gitlab.com/automx/automx2/raw/$AUTOMX2_VERSION/contrib/setupvenv.sh\?inline=false \
    && chmod u+x ./setupvenv.sh  && ./setupvenv.sh \
    && . venv/bin/activate \
    && pip install automx2

USER automx2
WORKDIR /srv/web/automx2
CMD ./venv/scripts/flask.sh run --host=0.0.0.0 --port=5000
