FROM python:3.8-slim-buster
ARG CONSUL_INSTALL_URL="https://releases.hashicorp.com/consul/1.11.2/consul_1.11.2_linux_amd64.zip"
ARG GOREMAN_INSTALL_URL="https://github.com/mattn/goreman/releases/download/v0.3.9/goreman_v0.3.9_linux_amd64.tar.gz"

RUN apt-get update && \
    apt-get install -y \
    bash curl nano net-tools zip unzip \
    jq dnsutils iputils-ping

# Consul install

ADD $CONSUL_INSTALL_URL /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD $GOREMAN_INSTALL_URL /tmp/goreman.tar.gz
RUN cd /bin && tar -xzf /tmp/goreman.tar.gz --strip-components 1 && chmod +x /bin/goreman && rm /tmp/goreman.tar.gz

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

#CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
RUN useradd -u 8877 webuser
USER webuser

COPY --chown=webuser . .

ENTRYPOINT [ "goreman" ]
CMD [ "-f", "Procfile", "start" ]
