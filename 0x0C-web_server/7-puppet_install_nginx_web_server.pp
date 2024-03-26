#!/usr/bin/env bash
# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location /redirect_me {
        return 301 http://$host/new_location;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
",
  notify  => Service['nginx'],
}

# Create index.html with Hello World! in /var/www/html
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

# Enable and start Nginx service
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}

