FROM slurm-base:latest

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY config/slurmdbd.conf /etc/slurm/slurmdbd.conf
COPY database/docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
