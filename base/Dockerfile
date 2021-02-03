FROM ubuntu:focal
ENV DEBIAN_FRONTEND="noninteractive"

# download utils
RUN apt-get update && apt-get install -y \
  sudo \
  make \
  wget \
  git \
  gcc \
  g++ \
  gnupg \
  python3 \
  python3-pip \
  vim \
  mailutils \
  default-mysql-client \
  default-libmysqlclient-dev \
  libssl-dev \
  libpam-dev \
  libncurses5-dev \
  libgtk2.0-dev \
  gawk \
  man2html \
  systemd \
  curl \
  cmake

# install json-c, required for Slurm's burst buffer plugin

RUN git clone --depth 1 --single-branch -b json-c-0.15-20200726 https://github.com/json-c/json-c.git json-c \
 && cd json-c \
 && cmake . \
 && make \
 && make install \
 && export

ENV PKG_CONFIG_PATH="/usr/local/lib/pkgconfig/:${PKG_CONFIG_PATH}"


# create Munge and Slurm users & groups
ENV MUNGEUSER="991"
RUN groupadd -r -g $MUNGEUSER munge \
 && useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /bin/bash munge

ENV SLURMUSER="992"
RUN groupadd -r -g $SLURMUSER slurm \
 && useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -G sudo,root -s /bin/bash slurm

# HACK: allow all sudoers use sudo without password
# It is required, because a slurm user instead of root is being used and Munge setup
# needs to be done, from munge user context without providing a password.
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# setup Munge
RUN apt-get install -y munge libmunge-dev libmunge2 \
 && /usr/sbin/create-munge-key

RUN mkdir /etc/slurm \
        /var/spool/slurmd \
        /var/run/slurmd \
        /var/run/slurmdbd \
        /var/lib/slurmd \
        /var/log/slurm \
        /data \
        /run/munge \
    && touch /var/lib/slurmd/node_state \
        /var/lib/slurmd/front_end_state \
        /var/lib/slurmd/job_state \
        /var/lib/slurmd/resv_state \
        /var/lib/slurmd/trigger_state \
        /var/lib/slurmd/assoc_mgr_state \
        /var/lib/slurmd/assoc_usage \
        /var/lib/slurmd/qos_usage \
        /var/lib/slurmd/fed_mgr_state \
    && chown -R slurm:slurm /var/*/slurm* /data \
    && chown -R munge:munge /run/munge

# Local burst buffer setup
# Based on: https://github.com/RSE-Cambridge/data-acc/blob/master/docker-slurm/Dockerfile

# Download and install etcd client
ARG ETCD_VERSION=3.3.13
ARG ETCD_DOWNLOAD_URL="https://github.com/etcd-io/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz"

RUN set -x \
    && wget -O etcd.tar.gz "$ETCD_DOWNLOAD_URL" \
    && mkdir /usr/local/src/etcd \
    && tar xf etcd.tar.gz -C /usr/local/src/etcd --strip-components=1 \
    && install -D -m755 /usr/local/src/etcd/etcdctl /usr/local/bin/etcdctl \
    && rm etcd.tar.gz \
    && rm -rf /usr/local/src/etcd

RUN curl -s https://api.github.com/repos/RSE-Cambridge/data-acc/releases/latest |\
    grep "browser_download_url.*tgz" |\
    cut -d '"' -f 4 |\
    wget -O /usr/local/bin/data-acc.tgz -i -

RUN set -x \
    && mkdir /usr/local/bin/data-acc \
    && tar xf /usr/local/bin/data-acc.tgz -C /usr/local/bin/data-acc \
    && install -D -m755 /usr/local/bin/data-acc/bin/dacd /usr/local/bin/dacd \
    && install -D -m755 /usr/local/bin/data-acc/bin/dacctl /usr/local/bin/dacctl \
    && install -D -m755 /usr/local/bin/dacctl /opt/cray/dw_wlm/default/bin/dw_wlm_cli \
    && install -D -m755 /usr/local/bin/dacctl /opt/cray/dws/default/bin/dwstat \
    && ln -s /usr/local/bin/dacctl /usr/local/bin/dw_wlm_cli \
    && ln -s /usr/local/bin/dacctl /usr/local/bin/dwstat

RUN touch /var/log/dacctl.log \
    && chown -R slurm:slurm /var/log/dacctl.log

ADD slurm /slurm
RUN cd /slurm && make install

CMD tail -f /dev/null
# ENTRYPOINT ["slurmctld"]
