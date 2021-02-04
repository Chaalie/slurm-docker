FROM slurm-base:latest

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY config/slurmdbd.conf /etc/slurm/slurmdbd.conf
COPY database/docker-entrypoint.sh .

RUN chmod 600 /etc/slurm/slurmdbd.conf \
 && chown slurm:slurm /etc/slurm/slurmdbd.conf

USER slurm
ENTRYPOINT ["./docker-entrypoint.sh"]
