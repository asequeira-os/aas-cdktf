FROM python:3.12.1-slim-bookworm
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN apt-get update

RUN apt install -y gcc g++ make curl wget git file tree vim emacs
RUN apt install -y postgresql-client lsof

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

# TODO 0 AAS pick arch from build
RUN curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.11.4/cloud-sql-proxy.linux.arm64
RUN chmod +x cloud-sql-proxy


# single quotes are important since $PATH should not expand
RUN echo 'export PS1="aas-cdktf ${PS1}"' >> /root/.bashrc
RUN echo 'export PATH=/root/go/bin:${PATH}' >> /root/.bashrc

WORKDIR /top

ENTRYPOINT [ "/aas-docker/entrypoint" ]
