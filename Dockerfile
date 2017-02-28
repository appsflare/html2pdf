FROM node:4-wheezy

RUN mkdir -p /apps/html2pdf

ADD package.json /apps/html2pdf/
ADD app.js /apps/html2pdf/
ADD static /apps/html2pdf/static
RUN deb http://ftp.debian.org/debian/ etch main non-free contrib deb-src http://ftp.debian.org/debian/ etch main non-free contrib \
    && deb http://security.debian.org/ etch/updates main contrib deb-src http://security.debian.org/ etch/updates main contrib
    && apt-get update

WORKDIR /apps/html2pdf

RUN apt-get install libfontconfig \
    && apt-get install msttcorefonts \
    && apt-get install ttf-mscorefonts-installer

RUN npm install \    
    && npm rebuild

CMD ["node","app.js"]