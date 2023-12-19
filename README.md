# Certbot for Auto-Renewal of HTTPS Certificates

## Prerequisites

<details>
<summary>Install Docker on Ubuntu</summary>

- Update package index:
  ```bash
  sudo apt-get update
Install Docker:

bash
Copy code
sudo apt-get install docker.io -y
Start Docker service:

bash
Copy code
sudo systemctl start docker
Enable Docker on system startup:

bash
Copy code
sudo systemctl enable docker
Add the current user to the docker group:

bash
Copy code
sudo usermod -a -G docker $(whoami)
Activate the changes to groups:

bash
Copy code
newgrp docker
</details>
<details>
<summary>Install Make on Ubuntu</summary>
Install Make:
bash
Copy code
sudo apt-get install make
</details>
Usage
<details>
<summary>Clone Repo and Change Your Domain</summary>
Clone the repository:

bash
Copy code
git clone https://github.com/mrunal-modi/certbot.git
Available steps:

Build the Docker image:

bash
Copy code
make build
Run the Docker container:

bash
Copy code
make run
Stop and remove the Docker container:

bash
Copy code
make stop
Clean up the Docker image:

bash
Copy code
make clean
Obtain or renew SSL certificate using Certbot:

bash
Copy code
make certbot
Update Nginx container with SSL certificate:

bash
Copy code
make update-nginx-ssl
</details>
```