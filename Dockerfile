FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

ENV LAST_UPDATE_SABNZBD 2015-01-14

# Add the Sabnzbd repository and install the application
RUN add-apt-repository -y ppa:jcfp/ppa && \
    apt-get -q update && \
    apt-get -qy install sabnzbdplus sabnzbdplus-theme-classic \
    sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
    par2 python-yenc unzip unrar

# We've got everything we need so clear out the apt data
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

VOLUME ["/config", "/download"]

EXPOSE 8080

# Copy the supervisord configuration files into the container
COPY sabnzbd.conf /etc/supervisor/conf.d/sabnzbd.conf

# No need to setup a CMD directive since that was handled in the FROM container.
