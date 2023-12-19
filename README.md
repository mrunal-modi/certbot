# Certbot for auto-renewal of HTTPS certificates

<details>
<summary> Install Docker on Ubuntu </summary>
```
sudo apt-get update
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $(whoami)
newgrp docker
```
</details>

<details>
<summary> Install Make on Ubuntu </summary>
```
sudo apt-get install make
```
</details>

<details>
<summary> Clone Repo and change your Domain </summary>
```
git clone https://github.com/mrunal-modi/certbot.git
	@echo "Available steps:"
	@echo "  1. make build          - Build the Docker image"
	@echo "  2. make run            - Run the Docker container"
	@echo "  3. make stop           - Stop and remove the Docker container"
	@echo "  4. make clean          - Clean up the Docker image"
	@echo "  5. make certbot        - Obtain or renew SSL certificate using Certbot"
	@echo "  6. make update-nginx-ssl - Update Nginx container with SSL certificate"
```
</details>