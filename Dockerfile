FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    apache2 \
    wget \
    tar \
    unzip \
    php \
    php-cli \
    php-gd \
    php-mbstring \
    php-xml \
    php-curl \
    php-zip \
    libapache2-mod-php \
    libpq-dev \
    postgresql-client \
    php-pgsql \
    cron \
    nano \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /var/www/html

RUN wget https://download.moodle.org/download.php/direct/stable310/moodle-latest-310.tgz && \
    tar xzf moodle-latest-310.tgz && \
    rm moodle-latest-310.tgz


RUN chown -R www-data:www-data /var/www/html

COPY moodle.conf /etc/apache2/sites-available/moodle.conf
RUN a2ensite moodle

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]