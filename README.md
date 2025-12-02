## Codeigniter 4 Kickstart (Docker Compose Development Environment)

### Components

* Codeigniter 4 App
    - PHP-FPM Server
    - PHP Extensions enabled for development with Codeigniter 4
* Mercure Server (Caddy + Mercure)
    - Proxy to PHP FPM (ci4app) and Adminer
    - Handle static files
    - Enable Mercure Hub (Real-Time Pub/Sub over HTTP/SSE)
* MySQL
    - Database used by default for app development with Codeigniter 4
* PostgreSQL
    - Alternative database for app development with Codeigniter 4
* Adminer
    - Database administration tool

### Enable development enviroment

```
sudo bash -c 'echo "127.0.0.1 ci4app.local" >> /etc/hosts'
docker build -t edersohe/ci4app .
docker run --rm --user $(id -u):$(id -g) -v .:/var/www/html edersohe/ci4app composer create-project codeigniter4/appstarter ci4app
chmod ugo+rw -R ci4app/writable
cp .env.example .env
docker compose up
```

### Prepare PHP Extensions in debian trixie
```
apt install php8.4-curl php8.4-imagick php8.4-xml php8.4-redis php8.4-cli php8.4-mysql php8.4-pgsql php8.4-intl php8.4-mbstring
```

## Optional PHP Extensions
```
# optional for debugging and development environment
php8.4-xdebug
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
* Adminer: https://ci4app.local/adminer

### ToDo

* Add Redis
* Add Mailpit

