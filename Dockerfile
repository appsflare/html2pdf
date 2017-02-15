FROM node:4-wheezy

RUN mkdir -p /apps/html2pdf

ADD package.json /apps/html2pdf/
ADD app.js /apps/html2pdf/
ADD static /apps/html2pdf/static

WORKDIR /apps/html2pdf

RUN apt-get install libfontconfig
RUN npm install \    
    && npm rebuild

CMD ["node","app.js"]