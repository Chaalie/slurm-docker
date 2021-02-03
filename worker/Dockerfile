FROM slurm-base:latest

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY worker/docker-entrypoint.sh .

USER slurm
ENTRYPOINT ["./docker-entrypoint.sh"]
