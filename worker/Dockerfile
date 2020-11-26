FROM slurm-base

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY worker/docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
