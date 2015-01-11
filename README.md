docker-sabnzbd
==============

Sabnzbd daemon running in a container. The default paths have been altered to:

 * /config
 * /download

`sabnzbd` runs as `sysadmin`, with the HTTP RPC interface listening on TCP port `8080`. The HTTP RPC interface is configured to not use authentication.

Assumptions
-----------

I use a NAS with a "download" share with the following structure:

  Download
  Download\Usenet
  Download\Usenet\Complete  - Completed downloads
  Donwload\Usenet\Watch     - Watch directory for .nzb files
  Download\Usenet\Working   - Working directory where "in progress" files are located

I want to run sabnzbd as the same user, "sysadmin" in my case, used to mount the NAS share to enforce some level of security.

Quick-start
-----------

    docker run -d -v /<NAS mount point>:/download -v /etc/docker/transmission:/config -v /etc/passwd:/etc/passwd:ro --user sysadmin --port 9091:9091 --port 51413:51413 --port 51413:51413/udp -h transmission --name transmission randomparity/docker-transmission

Then open http://docker_host:9091/transmission/web/ in a browser.
