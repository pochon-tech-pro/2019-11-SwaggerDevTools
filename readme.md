
# 公式リンク

[Web版SwaggerEditor](https://editor.swagger.io/)
[OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator)


**作業環境**

```
Windows 10 pro
Docker version 19.03.2
docker-compose version 1.24.1
```

# Dockerfile Sample

```Dockerfile
FROM openjdk:8-jdk-alpine

WORKDIR /app

RUN apk --update add bash nodejs npm maven git
RUN rm -rf /var/cache/apk/*ls
RUN git clone https://github.com/openapitools/openapi-generator /generator
RUN cd /generator && mvn clean package
RUN npm install -g swagger-cli
```

# docker-compose.yml Sample

```docker-compose.yml
version: '3'
services:
  tools:
    build: ./
    volumes:
      - .:/app
    tty: true
    command: sh
```

# Swagger Sample

```openapi.yml
openapi: 3.0.0
info:
  title: Sample API
  version: 0.0.1
servers:
  - url: http://localhost:3000/api
    description: SampleApiServer
tags:
  - name: Sample
paths:
  /getTest:
    get:
      tags: [ "Sample" ]
      summary: Get test.
      description: Get test.
      operationId: getTest
      parameters:
        - in: query
          name: name
          schema:
            type: string
      responses:
        '200':
          description: Sample
  /postTest:
    post:
      tags: [ "Sample" ]
      summary: Post test.
      description: Post test.
      operationId: postTest
      requestBody:
        content:
          application/x-www-form-urlencoded:
            schema:
              type: object
              properties:
                name:
                  type: string
      responses:
        '200':
          description: Sample
```

# 実践

Container Build & Up

```
PS C:\Users\user\Desktop\project> docker-compose up -d --build
```

In Container

```
PS C:\Users\user\Desktop\project> docker-compose exec tools bash
```

YAML2JSON

```
bash-4.4# swagger-cli bundle -o openapi.json openapi.yml
```

StabServer Generate

```
bash-4.4# java -jar /generator/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate \
   -i openapi.yml \
   -g nodejs-express-server \
   -o server
```

Client Generate

```
bash-4.4# java -jar /generator/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate \
   -i openapi.yml \
   -g javascript \
   -o client
```

# Swagger UI & Editor

```docker-compose.yml
  swagger-ui:
    image: swaggerapi/swagger-ui
    volumes:
      - ./openapi.yml:/usr/share/nginx/html/openapi.yml
    environment:
      API_URL: openapi.yml
    ports:
      - "9001:8080"

  swagger-editor:
    image: swaggerapi/swagger-editor
    ports:
      - "9002:8080"
```
```
PS C:\Users\user\Desktop\project> docker-compose up -d --build
```
