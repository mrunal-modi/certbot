# Set the name of the Docker image
IMAGE_NAME=static-website

# Target to display steps
steps:
	@echo "Available steps:"
	@echo "  1. make build          - Build the Docker image"
	@echo "  2. make run            - Run the Docker container"
	@echo "  3. make stop           - Stop and remove the Docker container"
	@echo "  4. make clean          - Clean up the Docker image"

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
	docker run -d -p 80:80 --name $(IMAGE_NAME) $(IMAGE_NAME)
