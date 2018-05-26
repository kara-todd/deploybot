from php:7.0.14-cli

# Update apt repos for Nodejs and Yarn
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
	apt-get install -y build-essential bzip2 inotify-tools nodejs git zlib1g-dev libbz2-dev libpng12-dev libjpeg-dev && \
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
	docker-php-ext-install zip bz2 gd

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Composer and make it available in the PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
