FROM debian:stretch

RUN apt-get update && apt-get install -y screen vlc livemedia-utils less curl 
RUN useradd -G users -m -s /bin/bash streamer

COPY files/start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME /opt

ENTRYPOINT /start.sh 

