# Mycroft WebUI
A very simple WebUI for interacting with your Mycroft instance.

This project is configured through environment variables. Make sure to set MYCROFT_HOST to the hostname of your Mycroft instance.

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
-p 5000:5000 \
--name mycroft-webui mycroft-webui
```
