APP_NAME ?= hotel-frontend
APP_PLATFORM ?= NodeJS
BUILD_ID ?= $(shell git rev-parse --short HEAD)
SSH_HOST ?= mars.cs.qc.cuny.edu
SSH_USERNAME ?= specify_in_travis_repo_settings
SSH_PASSPHRASE ?= specify_in_travis_repo_settings

ssh-ok:
	sudo sed -i "20i\ForwardAgent yes" /etc/ssh/ssh_config && \
	sudo sed -i "35i\StrictHostKeyChecking no" /etc/ssh/ssh_config

get-code:
	@sshpass -p ${SSH_PASS} ssh ${SSH_USER}@${SSH_HOST} "cd public_html/cs370/project2/hotel-frontend; git pull"

update-frontend:
	sudo locale-gen en_US.UTF-8
	@sshpass -p ${SSH_PASS} ssh ${SSH_USER}@${SSH_HOST} "rm -rf public_html/cs370/project2/frontend"
	@sshpass -p ${SSH_PASS} ssh ${SSH_USER}@${SSH_HOST} "mkdir public_html/cs370/project2/frontend"
	@sshpass -p ${SSH_PASS} ssh ${SSH_USER}@${SSH_HOST} "cp -r public_html/cs370/project2/hotel-frontend/* public_html/cs370/project2/frontend/"

repair-permissions:
	@sshpass -p ${SSH_PASS} ssh ${SSH_USER}@${SSH_HOST} "chmod -R 755 public_html/cs370/project2/frontend"
