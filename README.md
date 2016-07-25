# Mailman

All in one docker container for GNU
[Mailman](http://www.gnu.org/software/mailman/index.html).

## Building

```
docker build -t mailman .
```

## Running

```
docker run --rm -ti --name mailman \
  -p 80:80 -p 25:25 \
  -e MAILMAN_URLHOST=www.example.com \
  -e MAILMAN_EMAILHOST=example.com \
  -e MAILMAN_ADMINMAIL=admin@example.com \
  -e MAILMAN_ADMINPASS=foo \
  mailman
```

# Configs

 - `MAILMAN_SSL_CRT`
 - `MAILMAN_SSL_KEY`
 - `MAILMAN_SSL_CA`

## Status

Complete and working. But not yet sufficiently tested.
