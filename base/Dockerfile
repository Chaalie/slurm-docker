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
  systemd

# create Munge and Slurm users & groups
RUN export MUNGEUSER=991 \
 && groupadd -r -g $MUNGEUSER munge \
 && useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /bin/bash munge \
 && export SLURMUSER=992 \
 && groupadd -r -g $SLURMUSER slurm \
 && useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -G 0  -s /bin/bash slurm  

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

ADD slurm /slurm
RUN cd /slurm && make install

CMD tail -f /dev/null
# ENTRYPOINT ["slurmctld"]
