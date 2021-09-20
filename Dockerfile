FROM node:14-alpine AS build

RUN git clone  https://github.com/grafana/grafana.git \
    && cd grafana\packages\grafana-toolkit\
    && yarn install\
    && yarn build

WORKDIR /

RUN git clone https://github.com/intercloud/intercloud-grafana-plugin.git \
    && cd intercloud-grafana-plugin\
    && yarn install\
    && yarn build

FROM node:14-alpine
 COPY --from=build /intercloud-grafana-plugin/plugin /grafana/plugins

ENTRYPOINT ["/bin/sh"]
CMD [""]
