#!/bin/sh

# dev mode - file storage backend, sqlite, no nginx, etc.
if [ $1 = "devmode" ]; then
	# start up internal pubsub server
	pipenv run python storestub.py &
	# start up react sidecar
	sh /maniwani-frontend/devmode-entrypoint.sh &
	pipenv run uwsgi --ini ./deploy-configs/uwsgi-devmode.ini
# attempting to bootstrap?
elif [ $1 = "bootstrap" ]; then
	pipenv run python bootstrap.py
# version upgrade?
elif [ $1 = "update" ]; then
	pipenv run python update.py
# running normal production mode startup
else
	pipenv run uwsgi --ini ./deploy-configs/uwsgi.ini
fi
