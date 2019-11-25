FROM openjdk:8-jdk-alpine

WORKDIR /app

RUN apk --update add bash nodejs npm maven git
RUN rm -rf /var/cache/apk/*ls
RUN git clone https://github.com/openapitools/openapi-generator /generator
RUN cd /generator && mvn clean package
RUN npm install -g swagger-cli