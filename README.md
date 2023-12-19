# Certbot for Auto-Renewal of HTTPS Certificates

<details>
<summary>Install Docker on Ubuntu</summary>

  ```bash
  sudo apt-get update
  sudo apt-get install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -a -G docker $(whoami)
  newgrp docker
</details>
<details>
<summary>Install Make on Ubuntu</summary>
  ```bash
  sudo apt-get install make
  ```
</details>

<details>
<summary>Clone Repo and Change Your Domain</summary>

  ```bash
  git clone https://github.com/mrunal-modi/certbot.git
  make build
  make certbot
  make run
  make update-nginx-ssl
  make stop
  make clean
  ```
</details>




