# docker-dokuwiki-onphp
Dokuwiki on nginx + php5 for Docker

Webサーバーとしてnginxを使ったDokuwikiのdebian:jessieコンテナです。

# Install

```
$ git clone https://github.com/mizunashi-mana/docker-dokuwiki-onphp.git
$ cd docker-dokuwiki-onphp
$ docker build -t mizunashi/dokuwiki-onphp .
```

# How to use

```
$ docker run -d -p 80 --name my_wiki mizunashi/dokuwiki-onphp
```

Going to http://127.0.0.1/install.php
