FROM docker.io/maven:3.9.8-eclipse-temurin-11

RUN apt update && apt install python3 curl gcc git -y \
  && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash \
  && apt install nodejs -y

