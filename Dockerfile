FROM ruby:2.7.6

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client

RUN mkdir /var/www

WORKDIR /var/www

COPY . /var/www

RUN gem uninstall nokogiri

RUN bundle config set force_ruby_platform true

RUN bundle install

EXPOSE 3000

CMD [ "bash" ]