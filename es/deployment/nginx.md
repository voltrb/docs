# Nginx

Si quieres correr volt directamente, te recomendamos correrla sobre Nginx. Puedes configurar Nginx para servir archivos
estáticos (usando [bundle exec volt precompile](deployment/README.md)). Puedes usar este archivo `nginx.conf`: (no
olvides también incluir un archivo mime.types, como el descrito a continuación)

# nginx.conf

```
# you generally only need one nginx worker unless you're serving
# large amounts of static files which require blocking disk reads
worker_processes 1;

# # drop privileges, root is needed on most systems for binding to port 80
# # (or anything < 1024).  Capability-based security may be available for
# # your system and worth checking out so you won't need to be root to
# # start nginx to bind on 80
# user nobody nogroup; # for systems with a "nogroup"
# user nobody nobody; # for systems with "nobody" as a group instead

# Feel free to change all paths to suite your needs here, of course
# pid /path/to/nginx.pid;

error_log /Users/ryanstout/Sites/volt/apps/demos/blog_demo8/logs/nginx-error.log warn;


events {
  worker_connections  4096;  ## Default: 1024, keep in mind that you may need
                             ## to increase your systems max open file
                             ## descriptors for this to go above 1024
}

http {
  include    mime.types;

  # serve static files when asked to
  sendfile on;

  tcp_nopush on; # off may be better for *some* Comet/long-poll stuff
  tcp_nodelay off; # on may be better for some Comet/long-poll stuff

  # gzip compress when available
  gzip on;
  gzip_http_version 1.0;
  gzip_proxied any;
  gzip_min_length 500;
  gzip_disable "MSIE [1-6]\.";
  gzip_types text/plain text/html text/xml text/css
             text/comma-separated-values
             text/javascript application/x-javascript
             application/atom+xml;

  upstream app_server {
    # fail_timeout=0 means we always retry an upstream even if it failed
    # to return a good HTTP response (in case the Unicorn master nukes a
    # single worker for timing out).

    # for UNIX domain socket setups:
    # server unix:/path/to/.unicorn.sock fail_timeout=0;

    # for TCP setups, point these to your backend servers
    server localhost:3000 fail_timeout=0;
    # server 192.168.0.8:8080 fail_timeout=0;
    # server 192.168.0.9:8080 fail_timeout=0;
  }

  server {
    listen 80;
    root /Users/ryanstout/Sites/volt/apps/demos/blog_demo8/public;

    client_max_body_size 4G;
    server_name localhost default deferred;


    # ~2 seconds is often enough for most folks to parse HTML/CSS and
    # retrieve needed images/icons/frames, connections are cheap in
    # nginx so increasing this is generally safe...
    keepalive_timeout 10;

    location ^~ /app/ {
      expires max;
      add_header Cache-Control public;
    }

    try_files $uri/index.html $uri.html $uri @app_server;

    access_log /Users/ryanstout/Sites/volt/apps/demos/blog_demo8/logs/nginx-access.log;

    location @app_server {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect off;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_pass http://app_server;
    }

    # Volt error pages
    error_page 500 502 503 504 /500.html;
    location = /500.html {
      root /Users/ryanstout/Sites/volt/apps/demos/blog_demo8/public;
    }
  }
}
```

## Mime.types

El siguiente archivo mime.types ha sido actualizado para soportar nuevos tipos de fuentes

```
types {
  text/html                             html htm shtml;
  font/ttf                              ttf;
  font/opentype                         otf;
  application/font-woff                 woff;
  application/vnd.ms-fontobject         eot;
  text/css                              css;
  text/xml                              xml rss;
  image/gif                             gif;
  image/jpeg                            jpeg jpg;
  application/x-javascript              js;
  text/plain                            txt;
  text/x-component                      htc;
  text/mathml                           mml;
  image/png                             png;
  image/x-icon                          ico;
  image/x-jng                           jng;
  image/vnd.wap.wbmp                    wbmp;
  application/java-archive              jar war ear;
  application/mac-binhex40              hqx;
  application/pdf                       pdf;
  application/x-cocoa                   cco;
  application/x-java-archive-diff       jardiff;
  application/x-java-jnlp-file          jnlp;
  application/x-makeself                run;
  application/x-perl                    pl pm;
  application/x-pilot                   prc pdb;
  application/x-rar-compressed          rar;
  application/x-redhat-package-manager  rpm;
  application/x-sea                     sea;
  application/x-shockwave-flash         swf;
  application/x-stuffit                 sit;
  application/x-tcl                     tcl tk;
  application/x-x509-ca-cert            der pem crt;
  application/x-xpinstall               xpi;
  application/zip                       zip;
  application/octet-stream              deb;
  application/octet-stream              bin exe dll;
  application/octet-stream              dmg;
  application/octet-stream              iso img;
  application/octet-stream              msi msp msm;
  audio/mpeg                            mp3;
  audio/x-realaudio                     ra;
  video/mpeg                            mpeg mpg;
  video/quicktime                       mov;
  video/x-flv                           flv;
  video/x-msvideo                       avi;
  video/x-ms-wmv                        wmv;
  video/x-ms-asf                        asx asf;
  video/x-mng                           mng;
}
```
