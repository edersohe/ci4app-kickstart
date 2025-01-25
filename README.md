## Codeigniter 4 Kickstart (Docker Compose Development Environment)

### Components

* Codeigniter 4 App
    - PHP-FPM Server
    - PHP Extensions enabled for development with Codeigniter 4
* Mercure Server (Caddy + Mercure)
    - Proxy to PHP FPM (ci4app) and PHPMyAdmin
    - Handle static files
    - Enable Mercure Hub (Real-Time Pub/Sub over HTTP/SSE)
* MySQL
    - Database used by default for app development with Codeigniter 4
* PHPMyAdmin
    - Database administration tool

### Enable development enviroment

```
sudo bash -c 'echo "127.0.0.1 ci4app.local" >> /etc/hosts'
docker build -t edersohe/ci4app .
docker run --rm --user $(id -u):$(id -g) -v .:/var/www/html edersohe/ci4app sh -c "cd /mnt && composer create-project codeigniter4/appstarter ci4app"
chmod ugo+rw -R ci4app/writable
cp .env.example .env
docker compose up
```

### Install Certs for HTTPS

```
docker volume inspect $(basename $PWD)_mercure_data
sudo cp -r MOUNT_POINT_FROM_INSPECT/caddy/pki/authorities/local certs
sudo chown -R $USER:$USER certs
```

> Install root.crt and intermediate.crt from certs into certificate authorities in your browser

### Urls

* Codeigniter 4 App: https://ci4app.local
* Mercure Server: https://ci4app.local/.well-known/mercure/ui/
* PHPMyAdmin: https://ci4app.local/pma


### ToDo

* Add Redis
* Add Mailpit

