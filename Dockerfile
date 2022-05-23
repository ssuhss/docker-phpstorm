FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y install firefox software-properties-common wget git curl && \
    apt-get -y install php8.1-cli php8.1-common php8.1-mysql  php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-zip php8.1-bcmath && \
    apt-get -y install  openjdk-8-jre libxext-dev libxrender-dev libxtst-dev

RUN useradd -m -s /bin/bash user-unix \
    && mkdir /home/user-unix/.PhpStorm \
    && touch /home/user-unix/.PhpStorm/.keep \
    && chown -R user-unix.user-unix /home/user-unix \
    && mkdir /opt/phpstorm \
    #&& wget -O - https://download.jetbrains.com/webide/PhpStorm-2022.1.1.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"
    && wget -O - https://download.jetbrains.com/webide/PhpStorm-2020.1.4.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"
CMD ["/opt/phpstorm/bin/phpstorm.sh"]