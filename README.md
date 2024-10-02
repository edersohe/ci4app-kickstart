## Codeigniter 4 Kickstart (Development Environment with Docker Compose)

### Components

* Codeigniter 4 App
    - PHP-FPM 8.3 Server
    - Enabled PHP Extensions for development with Codeigniter 4
* Mercure Server (Caddy + Mercure)
    - Proxy to PHP FPM (ci4app) and AdminerEvo
    - Handle static files
    - Enable Mercure Hub (Real-Time Pub/Sub over HTTP/SSE)
* MySQL 8.4
    - Database use by default for app development with Codeigniter 4
* AdminerEvo
    - Database Administration Tool

### Enable development Enviroment

```
sudo bash -c 'echo "127.0.0.1 ci4app.local" >> /etc/hosts'

composer create-project codeigniter4/appstarter ci4app
chmod ugo+rw -R ci4app/writable

cp .env.example .env

docker compose up
```

### Install Certs for HTTPS

```
docker volume inspect mercure_data
docker cp mercure_data:caddy/pki/authorities/local /certs
sudo chown -R $USER:$USER certs
```

> Install root.crt and intermediate.crt from certs into certificate authorities in your browser

### Urls

* Codeigniter 4 App: https://ciapp.local
* Mercure Server: https://ciapp.local/.well-known/mercure/ui/
* AdminerEvo: https://ciapp.local/adminer


### ToDo

* Add Redis
* Add Mailpit



