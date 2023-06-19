FROM ruby:3.1
ARG RUBYGEMS_VERSION=3.3.20
RUN mkdir /real-world
WORKDIR /real-world
COPY Gemfile /real-world/Gemfile
COPY Gemfile.lock /real-world/Gemfile.lock
RUN bundle install
COPY . /real-world

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
