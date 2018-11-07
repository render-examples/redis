FROM redis:alpine

COPY redis.conf .

ENTRYPOINT ["redis-server", "./redis.conf"]
