FROM ubuntu:trusty

MAINTAINER David Christensen <randomparity@gmail.com>

# Remove error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

# Fetch/install latest updates and install "add-apt-repository"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common 

# Add the Transmission repository and install the application
RUN add-apt-repository -y ppa:jcfp/ppa && \
    apt-get update && \
    apt-get install -y sabnzbdplus sabnzbdplus-theme-classic \
                       sabnzbdplus-theme-mobile sabnzbdplus-theme-plush \
                       par2 python-yenc unzip unrar

# Clean-up any unneeded files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/config"]
VOLUME ["/download"]

EXPOSE 8080

USER sysadmin

# Run Transmission in the foreground, as "sysadmin", with the following defaults
CMD [ "--config-file", "/config", "--server", ":8080", "--browser", "0" ]
ENTRYPOINT ["/usr/bin/transmission-daemon"]
