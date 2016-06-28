#15.04
FROM ubuntu:vivid
MAINTAINER Michel Ilson da Silva "michel_silva_04@hotmail.com"

RUN apt-get update && \
    apt-get install -y software-properties-common wget git curl && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get update && \
    apt-get install -y graphviz phpunit nodejs \
        php5-cli php5-mcrypt php5-mysql php5-xdebug php5-curl php5-memcached php5-memcache php-pear php5-gd php5-apcu php5-imagick php5-imap php5-intl php5-sasl php5-xdebug \
        openjdk-8-jre libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN useradd -m -s /bin/bash michel \
    && mkdir /home/michel/.PhpStorm2016.1.2 \
    && touch /home/michel/.PhpStorm2016.1.2/.keep \
    && chown -R michel.michel /home/michel \
    && mkdir /opt/phpstorm \
    && wget -O - https://download.jetbrains.com/webide/PhpStorm-2016.1.2.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin
RUN php5enmod mcrypt mysql xdebug curl memcached memcache gd apcu imagick imap intl sasl
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar -O /usr/bin/phpmd.phar
RUN pear install PHP_CodeSniffer
RUN npm install -g bower
RUN mkdir /var/www/

USER michel
VOLUME /home/michel/.PhpStorm2016.1.2
CMD /opt/phpstorm/bin/phpstorm.sh

