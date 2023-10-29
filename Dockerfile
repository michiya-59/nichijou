FROM ruby:3.2.1

RUN apt update -qq && apt install -y postgresql-client

RUN apt-get update
RUN apt-get install -y vim

RUN mkdir /nichijou
WORKDIR /nichijou
COPY Gemfile /nichijou/Gemfile
COPY Gemfile.lock /nichijou/Gemfile.lock
RUN bundle install
RUN gem install foreman
COPY . /nichijou
ENV TZ Asia/Tokyo

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

