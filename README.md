# Redis Cache

This is an example repo with a Dockerfile for running a Redis cache as a **private service** on Render.

Render private services are only visible to other Render services in your account. They have internal URLs (e.g. `redis:6379`), can speak any protocol (like [RESP](https://redis.io/topics/protocol)), and can listen on any port.

## Deployment instructions on Render
1. Select **New Private Service** on your Render dashboard and use your fork of this repo to create the service.

2. Enter a name for the service (this will be used to generate the private URL). Make sure the environment is set to `Docker` and click Save.

That's it! Once deployed, your private service will be available on a URL similar to `redis:10000`. You can start using your Redis URL from other services in your Render account.

If you need help, you can always chat with us at https://render.com/slack.
