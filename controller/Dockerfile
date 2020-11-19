FROM slurm-base:latest

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY controller/docker-entrypoint.sh .
COPY jobs /data

ENTRYPOINT ["./docker-entrypoint.sh"]
