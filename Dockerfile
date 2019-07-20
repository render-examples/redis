FROM redis:5-alpine

COPY redis.conf .

ENTRYPOINT ["redis-server", "./redis.conf"]
