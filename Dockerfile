FROM voidlock/erlang:18.1
MAINTAINER Mathieu Lajugie <mathieul@gmail.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


ENV ELIXIR_VERSION=1.1.1 \
    ELIXIR_DOWNLOAD_SHA=3b7d6e4fdbcc82d19fa76f4e384f8a87535abcd00ef04528dc6b6706f32a106a

RUN set -xe \
      && curl -SL "https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz" -o elixir.tar.gz \
      && echo "${ELIXIR_DOWNLOAD_SHA} elixir.tar.gz" | sha256sum -c - \
      && mkdir -p /usr/src/elixir \
      && tar -xzC /usr/src/elixir --strip-components=1 -f elixir.tar.gz \
      && rm elixir.tar.gz \
      && cd /usr/src/elixir \
      && make -j$(nproc) clean install \
      && rm -rf /usr/src/elixir

ENV PHOENIX_VERSION 1.1.0

RUN mix local.hex --force \
      && mix local.rebar --force \
      && mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v$PHOENIX_VERSION/phoenix_new-$PHOENIX_VERSION.ez --force

# install Node.js and NPM in order to satisfy brunch.io dependencies
# the snippet below is borrowed from the official nodejs Dockerfile
# https://hub.docker.com/_/node/

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 5.3.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

WORKDIR /code

CMD [ "mix" ]