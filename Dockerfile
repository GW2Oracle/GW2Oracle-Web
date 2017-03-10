FROM ruby:2.3.3-slim
RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential nodejs libpq-dev
ENV INSTALL_PATH /gw2oracle
# Create install path and PIDs directory in one command
RUN mkdir -p $INSTALL_PATH/tmp/pids
WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install --binstubs
COPY . .
CMD puma -C config/puma.rb
