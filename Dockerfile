FROM ruby:3.2.2

ENV NODE_VERSION=18 \
    INSTALL_PATH=/opt/app \
    LC_ALL=en_US.utf8 \
    LANG=en_US.utf8 \
    LANGUAGE=en_US.utf8

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    curl nano nodejs postgresql-client locales yarn && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/appuser -s /bin/bash appuser && \
    mkdir -p $INSTALL_PATH && \
    chown -R appuser:appuser $INSTALL_PATH

WORKDIR $INSTALL_PATH

USER appuser

COPY --chown=appuser:appuser Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY --chown=appuser:appuser . .

CMD ["rails", "server", "-b", "0.0.0.0"]
