FROM node:4-alpine

RUN mkdir -p /apps/html2pdf

ADD package.json /apps/html2pdf/
ADD app.js /apps/html2pdf/
ADD static /apps/html2pdf/static

WORKDIR /apps/html2pdf

RUN npm install && npm install phantomjs-prebuilt --save

CMD ["node","app.js"]