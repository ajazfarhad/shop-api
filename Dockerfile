ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION} AS builder

RUN apk update && apk upgrade
# Install dependencies:
# - build-base: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - postgresql-dev postgresql-client: Communicate with postgres through the postgres gem
# - libxslt-dev libxml2-dev: Nokogiri native dependencies

RUN apk --update add alpine-sdk build-base  \
nodejs tzdata postgresql-client \
postgresql-dev libxslt-dev \
libxml2-dev

ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT
COPY Gemfile* $RAILS_ROOT/

COPY . $RAILS_ROOT
RUN bundle install

FROM ruby:${RUBY_VERSION}

ENV RAILS_ROOT /app
RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV RAILS_ENV staging
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/lib /usr/lib
COPY --from=builder  /usr/share/ /usr/share
COPY --from=builder /usr/bin /usr/bin

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app $RAILS_ROOT

# Add a script to be executed every time the container starts.
COPY start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
ENTRYPOINT ["start.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
