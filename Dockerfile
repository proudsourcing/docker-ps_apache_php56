FROM eboraas/apache-php

MAINTAINER info@proudsourcing.de

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# timezone / date   
RUN echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# install packages
RUN apt-get update && \
	apt-get install -y --force-yes \
		less vim wget \
		php-pear php5-cli php5-cgi php5-common php5-curl php5-gd php5-imap php5-xmlrpc php5-dev php5-memcache php5-mcrypt \
		jpegoptim optipng \
		postfix && \
	apt-get clean && \
	echo "export TERM=xterm" >> /root/.bashrc

# install ioncube
RUN mkdir /tmp/ioncube && \
    cd /tmp/ioncube && \
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar xvf ioncube_loaders_lin_x86-64.tar.gz && \
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /tmp/ioncube/ioncube/ioncube_loader_lin_5.6.so . && \
    echo zend_extension=ioncube_loader_lin_5.6.so > /etc/php5/apache2/conf.d/00-ioncube.ini && \
    rm -rf /tmp/ioncube/

# install zend guard loader
RUN mkdir /tmp/zendguardloader && \
    cd /tmp/zendguardloader && \
    wget http://downloads.zend.com/guard/7.0.0/zend-loader-php5.6-linux-x86_64.tar.gz && \
    tar xvf zend-loader-php5.6-linux-x86_64.tar.gz && \
    cd `php -i | grep extension_dir | cut -d' ' -f 5` && \
    cp /tmp/zendguardloader/zend-loader-php5.6-linux-x86_64/ZendGuardLoader.so . && \
    cp /tmp/zendguardloader/zend-loader-php5.6-linux-x86_64/opcache.so . && \
    echo zend_extension=ZendGuardLoader.so > /etc/php5/apache2/conf.d/10-zendguardloader.ini && \
    echo zend_extension=opcache.so > /etc/php5/apache2/conf.d/20-zendopcache.ini && \
    rm -rf /tmp/zendguardloader/

COPY ./ps_entrypoint.sh /
CMD ["/bin/sh", "/ps_entrypoint.sh"]