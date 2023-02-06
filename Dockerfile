FROM ubuntu:22.04
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN apt-get update

RUN apt install -y curl wget git file tree vim emacs

RUN apt-get install -y python3.10 python3-pip
RUN pip install pipenv

RUN mkdir -p /aas-docker
COPY scripts /aas-docker/
WORKDIR /aas-docker

RUN ./go-install
RUN ./terraform-install
RUN ./cdktf-install.sh
RUN ./gcloud-cli-install
RUN ./aliases
RUN ./verify_all
COPY README.md /aas-docker

# single quotes are important since $PATH should not expand
RUN echo 'export PS1="aas-cdktf ${PS1}"' >> /root/.bashrc
RUN echo 'export PATH=/root/go/bin:${PATH}' >> /root/.bashrc

WORKDIR /top

ENTRYPOINT [ "/aas-docker/entrypoint" ]
