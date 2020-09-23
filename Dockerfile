FROM ruby:2.5.1
RUN apt update && apt install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt update && apt install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt update -qq && apt install -y build-essential libpq-dev nodejs

WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /myapp