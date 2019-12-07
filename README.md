# Mycroft WebUI
A very simple WebUI for interacting with your Mycroft instance.

## Configuration
This project needs the following configuration:

### Environment variables
`MYCROFT_HOST`: Set to the IP address or hostname of your Mycroft instance. Please ensure port 8181 is ONLY accessible to this container.

### Files
You will have to mount Docker's `/config` volume and put the following files in there:

#### .htpasswd
[See here on how to create this file](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/#creating-a-password-file).

#### SSL
If you place a nginx.crt and nginx.key file in the config directory, the container will automatically start using SSL.

## Build image
Git pull this repository.

```bash
git clone https://github.com/TheLastProject/mycroft-webui.git
```

Build the docker image in the directory that you have checked out.

```bash
docker build -t mycroft-webui .
```

## Run

```bash
docker run -d \
-e MYCROFT_HOST=127.0.0.1 \
-v /your/config/directory/location:/config \
-p 8080:8080 \
--name mycroft-webui mycroft-webui
```
