FROM node:10

RUN apt-get update \
    && apt-get install curl -y \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /usr/src/app
COPY . .
RUN yarn

EXPOSE 3000
CMD [ "node", "app.js" ]