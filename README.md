# Mailman

All in one docker container for GNU
[Mailman](http://www.gnu.org/software/mailman/index.html).

## Example Usage

```
docker run --rm -ti --name mailman \
  -p 80:80 -p 25:25 \
  -e MAILMAN_URLHOST=www.example.com \
  -e MAILMAN_EMAILHOST=example.com \
  -e MAILMAN_ADMINMAIL=admin@example.com \
  -e MAILMAN_ADMINPASS=foo \
  docker.io/macropin/mailman
```

## Environment Configs

 - `MAILMAN_URLHOST` - Mailman url host eg `www.example.com`
 - `MAILMAN_EMAILHOST` - Mailman email host eg `example.com`
 - `MAILMAN_ADMINMAIL` - Mailman administrator email address eg `admin@example.com`
 - `MAILMAN_ADMINPASS` - Mailman administrator password

SSL options for opportunistic SMTP TLS:

 - `MAILMAN_SSL_CRT` - SSL Certificate (optional)
 - `MAILMAN_SSL_KEY` - SSL Key (optional)
 - `MAILMAN_SSL_CA` - SSL CA (optional)

## Status

Complete and working in production.
