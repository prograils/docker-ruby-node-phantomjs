FROM ubuntu:16.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>
ENV RUBY_VERSION 2.3.3
ENV NODE_VERSION 6.9.4
ENV PHANTOMJS_VERSION 2.1.1
RUN apt-get -qq update
RUN apt-get install -y curl git-core build-essential openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libpq-dev libmysqlclient-dev libffi-dev libyaml-dev libtool bison automake fontconfig gawk libgmp-dev libgdbm-dev libncurses5-dev pkg-config wget

## RUBY via RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install $RUBY_VERSION && rvm use $RUBY_VERSION --default"
RUN /bin/bash -l -c "gem instal bundler --no-ri --no-rdoc"
WORKDIR /root
RUN echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc

## NODEJS
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

RUN /bin/bash -l -c "source /root/.nvm/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default"

## PHANTOMJS
RUN wget -O /tmp/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN tar -xjf /tmp/phantomjs.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/

