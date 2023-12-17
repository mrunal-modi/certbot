# Set the name of the Docker image
IMAGE_NAME=static-website


# Set environment variable 
NGINX_CONTAINER_NAME=my-static-website-container # the name of the Nginx container
HOST_LETSENCRYPT_DIR=./letsencrypt # Set the relative directory on the host for Certbot

DOMAIN=fiscaltimeline.com # Set your domain for Certbot
CERT_PATH=/etc/letsencrypt/live/$(DOMAIN)/fullchain.pem
KEY_PATH=/etc/letsencrypt/live/$(DOMAIN)/privkey.pem

# Target to display environment variable values
show-env:
	@echo "DOMAIN: $(DOMAIN)"
	@echo "DIR: $(HOST_LETSENCRYPT_DIR)"
	@echo "Contents of $(HOST_LETSENCRYPT_DIR):"
	@ls -la $(HOST_LETSENCRYPT_DIR)
	@echo "CERT_PATH: $(CERT_PATH)"
	@echo "KEY_PATH: $(KEY_PATH)"

# Target to stop and remove the Docker container
stop:
	docker stop $(NGINX_CONTAINER_NAME) || true
	docker rm $(NGINX_CONTAINER_NAME) || true

# Target to clean up the Docker image
clean:
	docker rmi $(IMAGE_NAME)

# Default target: build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Target to run the Docker container without SSL support
run:
	docker run -d -p 80:80 --name my-static-website-container \
		-v "$(HOST_LETSENCRYPT_DIR):/etc/letsencrypt" \
		-v "$(HOST_LETSENCRYPT_DIR):/var/lib/letsencrypt" \
		-e "DOMAIN=$(DOMAIN)" \
		$(IMAGE_NAME)

# Target to run the Docker container with SSL support
run-ssl:
	@echo "DOMAIN: $(DOMAIN)"
	@echo "CERT_PATH: $(CERT_PATH)"
	@echo "KEY_PATH: $(KEY_PATH)"
	@docker stop $(NGINX_CONTAINER_NAME) || true
	@docker rm $(NGINX_CONTAINER_NAME) || true
	docker run -d -p 80:80 -p 443:443 --name $(NGINX_CONTAINER_NAME) \
		-v "$(HOST_LETSENCRYPT_DIR):/etc/letsencrypt" \
		-v "$(HOST_LETSENCRYPT_DIR):/var/lib/letsencrypt" \
		-e "DOMAIN=$(DOMAIN)" \
		-e "CERT_PATH=/etc/letsencrypt/live/$(DOMAIN)/fullchain.pem" \
		-e "KEY_PATH=/etc/letsencrypt/live/$(DOMAIN)/privkey.pem" \
		$(IMAGE_NAME)

# Target to obtain or renew SSL certificate using Certbot
certbot:
	docker run -it --rm \
		-p 80:80 \
		-v "$(shell pwd)/letsencrypt:/etc/letsencrypt" \
		-v "$(shell pwd)/letsencrypt:/var/lib/letsencrypt" \
		certbot/certbot certonly --standalone -d $(DOMAIN)

# Target to update Nginx container with SSL certificate
update-nginx-ssl: build
	@if [ $$(docker inspect -f '{{.State.Running}}' $(NGINX_CONTAINER_NAME)) = "true" ]; then \
		docker exec $(NGINX_CONTAINER_NAME) nginx -s reload; \
	else \
		echo "Nginx container is not running. Please ensure it is running."; \
	fi

# Display steps
steps:
	@echo "Available steps:"
	@echo "  1. make show-env       - Show Env variables"
	@echo "  2. make build          - Build the Docker image"
	@echo "  3. make certbot        - Obtain or renew SSL certificate using Certbot"
	@echo "  4. make update-nginx-ssl - Update Nginx container with SSL certificate"
	@echo "  5. make run-ssl        - Run the Docker container with SSL support (HTTPS)"
	@echo "  6. make stop           - Stop and remove the Docker container"
	@echo "  7. make clean          - Clean up the Docker image"
	@echo "  8. make steps          - Display these steps"
