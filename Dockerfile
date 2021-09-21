FROM node:14-alpine AS build

WORKDIR /

RUN apk update\
    && apk add git

RUN git clone  https://github.com/grafana/grafana.git\
    && cd grafana/packages/grafana-toolkit\
    && yarn install\
    && yarn build

WORKDIR /

RUN git clone https://github.com/intercloud/intercloud-grafana-plugin.git\
    && cd intercloud-grafana-plugin\
    && yarn install\
    && yarn build

FROM node:14-alpine
 COPY --from=build /intercloud-grafana-plugin/dist /intercloud-grafana-plugin

ENTRYPOINT ["/bin/sh"]
