FROM docker:latest

MAINTAINER Antoine Benevaut <antoine@benevaut.fr>

RUN apk add --no-cache python python-dev build-base libffi-dev openssl-dev libgcc py-pip openssh-client sshpass
RUN pip install docker-compose
