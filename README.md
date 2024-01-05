# Certbot for Auto-Renewal of HTTPS Certificates

<details>
<summary>Install Docker and Make on Ubuntu</summary>

  ```bash
  sudo apt-get update
  sudo apt-get install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -a -G docker $(whoami)
  newgrp docker
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


<details>
<summary>Setup Cron job</summary>
To set up a cron job for Certbot to automatically renew SSL certificates, you can add the following line to your crontab file. You can edit the crontab file by running the command crontab -e in your terminal.

  ```bash
    0 0 * * * cd /path/to/your/project && make update-nginx-ssl
  ```
</details>


