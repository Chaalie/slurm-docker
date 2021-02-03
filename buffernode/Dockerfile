FROM slurm-base:latest

COPY config/slurm.conf /etc/slurm/slurm.conf
COPY config/burst_buffer.conf /etc/slurm/burst_buffer.conf
COPY buffernode/docker-entrypoint.sh .

USER slurm
ENTRYPOINT ["./docker-entrypoint.sh"]
