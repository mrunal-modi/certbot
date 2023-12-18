# Set the name of the Docker image
IMAGE_NAME=static-website

# Target to display steps
steps:
	@echo "Available steps:"
	@echo "  1. make build          - Build the Docker image"
	@echo "  2. make run            - Run the Docker container"
	@echo "  3. make stop           - Stop and remove the Docker container"
	@echo "  4. make clean          - Clean up the Docker image"
	@echo "  5. make certbot        - Obtain or renew SSL certificate using Certbot"
	@echo "  6. make update-nginx-ssl - Update Nginx container with SSL certificate"

# Target to stop and remove the Docker container
stop:
	docker stop $(IMAGE_NAME) || true
	docker rm $(IMAGE_NAME) || true

# Target to clean up the Docker image
clean:
	docker rmi $(IMAGE_NAME)

# Default target: build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Target to run the Docker container
run:
		docker run -d -p 80:80 -p 443:443 --name $(IMAGE_NAME) -v "$(shell pwd)/letsencrypt:/etc/letsencrypt" $(IMAGE_NAME)

# Target to obtain or renew SSL certificate using Certbot
certbot:
	docker run -it --rm \
		-v "$(shell pwd)/letsencrypt:/etc/letsencrypt" \
		-v "$(shell pwd)/letsencrypt:/var/lib/letsencrypt" \
		-p 80:80 \
		certbot/certbot certonly --standalone -d fiscaltimeline.com

# Target to update Nginx container with SSL certificate
update-nginx-ssl:
	@if [ "$$(docker inspect -f '{{.State.Running}}' $(IMAGE_NAME))" = "true" ]; then \
		docker exec $(IMAGE_NAME) nginx -s reload; \
	else \
		echo "Nginx container is not running. Please ensure it is running."; \
	fi
