# A simple DokuWiki container

A simple starting point for hosting DokuWiki in a container. 

## Installation

Clone this repository, cd into the dokuwiki-container directory, and then run
the following commands:
```
	docker-compose build && docker-compose up
```

Then visit the following URL to configure the wiki:
	http://localhost:8080/install.php

To ssh into the container, use the following command:
```
	docker exec -it dokuwiki ash
```

## DokuWiki

For full details, visit https://www.dokuwiki.org/dokuwiki

>  DokuWiki is a simple to use and highly versatile Open Source wiki software that doesn't require a database. It is loved by users for its clean and readable syntax. The ease of maintenance, backup and integration makes it an administrator's favorite. Built in access controls and authentication connectors make DokuWiki especially useful in the enterprise context and the large number of plugins contributed by its vibrant community allow for a broad range of use cases beyond a traditional wiki. 

## Customizations

The base container starts with the Ubuntu distribution, adding nginx and all PHP
requirements along with DokuWiki.

### DokuWiki version

Edit the `DOKUWIKI_INSTALL` variable at the top of Dockerfile to install a
different version of DokuWiki.

### Extensions

You can comment out the line in Dockerfile that installs `php-curl` if you do not
want to install extensions through the DokuWiki administrative Extension Manager.
Extensions can still be installed manually.

### Listening port (default: 8080)

To change which port nginx listens on, edit `nginx/default` changing:
```
	listen 8080 default_server;
	listen [::]:8080 default_server;
```
from `8080` to your desired port. Then, also edit the `EXPOSE` toward the end of
Dockerfile, again changing `8080` to your new port.

## TODO
 - install/enable some plugins
 - configure email
