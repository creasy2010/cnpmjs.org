FROM registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode:5.13.0-alpine
MAINTAINER Bono Lv <lvscar  {aT} gmail.com>

# Working enviroment
ENV \
    CNPM_DIR="/var/app/cnpmjs.org" \
    APP_ID="83245" \
    APP_SECRET="18db43282562bae9d0a76fb29efcea39c5c71fae" \
    CNPM_DATA_DIR="/var/data/cnpm_data"

RUN mkdir  -p ${CNPM_DIR}

WORKDIR ${CNPM_DIR}

COPY package.json ${CNPM_DIR}

RUN npm set registry https://registry.npm.taobao.org

RUN npm install --production

COPY .  ${CNPM_DIR}
COPY docs/dockerize/config.js  ${CNPM_DIR}/config/

EXPOSE 7001/tcp 7002/tcp

VOLUME ["/var/data/cnpm_data"]

# Entrypoint
CMD ["node", "dispatch.js"]

