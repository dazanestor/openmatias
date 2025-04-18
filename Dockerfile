FROM python:3.11-slim

# Instalar solo lo necesario y limpiar al final
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    pip install --no-cache-dir pillow && \
    git clone https://gitlab.com/rastersoft/opendonita.git /tmp/opendonita && \
    mkdir -p /opt/congaserver && \
    cp /tmp/opendonita/congaserver.py /opt/congaserver/ && \
    cp /tmp/opendonita/configconga.py /opt/congaserver/ && \
    cp -r /tmp/opendonita/congaModules /opt/congaserver/congaModules && \
    cp -r /tmp/opendonita/html /opt/congaserver/html && \
    rm -rf /tmp/opendonita && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/congaserver

EXPOSE 80
EXPOSE 20008

ENV PYTHONUNBUFFERED=1

CMD ["python3", "congaserver.py"]
