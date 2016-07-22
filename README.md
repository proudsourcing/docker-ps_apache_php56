# ps_apache_php56
Docker container, built on Debian, with latest PHP (atm PHP 5.6) with SSL support, zend guard loader, ioncube loader and postfix.

## How to use
Run `docker run -p 80:80 -p 443:443 -d proudsourcing/ps_apache_php56` and browse to the host's IP address using http or https

* /var/www/html for your site content (e.g. using "-v /home/jdoe/mysite/:/var/www/html/")
* /var/log/apache2, optionally, if you want to store logfiles visibly outside the container
* /etc/ssl, optionally, if you wish to use SSL with real keys

For more information please visit ebooras readme: https://hub.docker.com/r/eboraas/apache-php/

## Docker compose
```yaml
my_container_service:
  container_name: my_container_name
  hostname: my_hostname
  build: .
  volumes:
    - /my_wwwdata_on_host/:/var/www/html/
    - /my_logdir_on_host/:/var/log/apache2/
```

## Image dependency
```
ps_apache_php56
FROM eboraas/apache-php
FROM eboraas/apache
FROM eboraas/debian
FROM eboraas/debootstrap
```


---


Proud Sourcing GmbH | 2016 | www.proudsourcing.de | www.proudcommerce.com
