FROM node:10

WORKDIR /usr/src/app
COPY . .
RUN yarn install

EXPOSE 3000
CMD [ "node", "app.js" ]