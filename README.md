# Mycroft WebUI
A very simple WebUI for interacting with your Mycroft instance.

## Configuration
This project needs the following configuration:

### Environment variables
- `MYCROFT_HOST`: Set to the IP address or hostname of your Mycroft instance. Please ensure port 8181 is ONLY accessible to this container.
- `ADMIN_USERNAME`: The username for the authentication dialog
- `ADMIN_PASSWORD`: The password for the authentication dialog

If you wish, you could instead provide your own .htpasswd file. See Files below.

### Files
No files are necessary, but this container exposes a /config directory which supports the following files:
- `nginx.crt`: SSL certificate
- `nginx.key`: SSL key
- `.htpasswd`: [Authentication file](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/#creating-a-password-file)

If nginx.crt and nginx.key exist, the container will automatically start using SSL.

If .htpasswd exists, it will be used instead of the ADMIN_USERNAME and ADMIN_PASSWORD environment variables.

## Get image
This image is available on [Docker Hub](https://hub.docker.com/r/thelastproject/mycroft-webui).

Alternatively, you can build it yourself from the sources in this git repository:

```bash
docker build -t mycroft-webui .
```

## Run

```bash
docker run -d \
-e MYCROFT_HOST=127.0.0.1 \
-v /your/config/directory/location:/config \
-p 8080:8080 \
-p 8443:8443 \
-e ADMIN_USERNAME=admin \
-e ADMIN_PASSWORD=changeme \
--name mycroft-webui mycroft-webui
```

With the above configuration, the container will listen on port 8080 (HTTP) and, if you set up SSL, port 8443 (HTTPS). The username and password are visible in the command, but it is strongly recommended to change them.
