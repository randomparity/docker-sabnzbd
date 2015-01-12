FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

# Fetch/install latest updates and install "add-apt-repository"
RUN apt-get -qy install software-properties-common 

# Add a new repository for Transmission
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

# Add the Transmission repository and install the application
RUN add-apt-repository -y ppa:jcfp/ppa && \
    apt-get -qq update && \
    apt-get -qy install sabnzbdplus sabnzbdplus-theme-classic \
                       sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
                       par2 python-yenc unzip unrar

# Clean-up any unneeded files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/config"]
VOLUME ["/download"]

EXPOSE 8080

# Copy the supervisord configuration files into the container
COPY sabnzbd.conf /etc/supervisor/conf.d/sabnzbd.conf

# No need to setup a CMD directive since that was handled in the FROM container.
