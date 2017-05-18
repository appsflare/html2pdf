FROM ubuntu:16.04

RUN echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list.d/multiverse.list \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list.d/multiverse.list \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/multiverse.list \    
    && apt-get update \
    && apt-get install -y debconf-utils \
    && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN apt-get install -y apt-utils apt-transport-https curl libfontconfig ttf-mscorefonts-installer

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs build-essential

ENV DEBIAN_FRONTEND noninteractive
    
#RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN mkdir -p /apps/html2pdf

ADD package.json /apps/html2pdf/
ADD app.js /apps/html2pdf/
ADD static /apps/html2pdf/static


WORKDIR /apps/html2pdf

RUN npm install \    
    && npm rebuild

CMD ["node","app.js"]
