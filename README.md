# Mailman

Work in progress docker container for mailman.

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
  -e MAILMAN_ADMINPASS=foo mailman

````
