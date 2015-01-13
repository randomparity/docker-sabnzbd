docker-sabnzbd
==============

Sabnzbd daemon running in a container. The default paths have been altered to:

 * `/config`
 * `/download`

`sabnzbd` runs with the HTTP RPC interface listening on TCP port `8080`. The HTTP RPC interface is configured to not use authentication.

Assumptions
-----------

I use a NAS with a "download" share with the following structure:

  - Download                - Completed downloads
  - Download\Usenet         - Watch directory for .nzb files
  - Download\Usenet\Working - Working directory where "in progress" files are located

The `download` directory is mounted at `/mnt/download`, the `config` directory is located at `/etc/docker/sabnzbd`.

Quick-start
-----------
`docker run -d --restart always -h sabnzbd --name sabnzbd -v /mnt/download:/download -v /etc/docker/sabnzbd:/config -v /etc/localtime:/etc/localtime:ro -p 8080:8080 randomparity/docker-sabnzbd:latest`

Then open `http://docker_host:8080` in a browser.
