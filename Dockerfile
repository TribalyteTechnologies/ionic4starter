FROM node:10-slim

USER root
RUN npm install -g live-server

USER node

RUN mkdir -p /home/node/app /tmp/app
WORKDIR /tmp/app

COPY --chown=node . .
ENV NODE_OPTIONS=--max-old-space-size=500
RUN node --max-old-space-size=500 `which npm` i && node --max-old-space-size=500 `which npm` run build && mv www /home/node/app && rm -fr /tmp/app

WORKDIR /home/node/app

ENV IP=0.0.0.0 PORT=4200

EXPOSE ${PORT}

CMD ["live-server", "--no-browser", "www"]
