FROM node:14
ARG SRC_DIR=/opt/i27
RUN mkdir $SRC_DIR
WORKDIR $SRC_DIR
ENV ENVIRONMENT=dev
COPY . $SRC_DIR
RUN npm install
EXPOSE 3000
COPY entrypoint.sh /entrypoin.sh
RUN chmod +x /entrypoin.sh
ENTRYPOINT ["/entrypoin.sh"]




