FROM elixir:1.10.0-alpine

WORKDIR "/root"

VOLUME ["/root", "/data"]

RUN mix local.rebar --force
RUN mix local.hex --force

# Phoenix default port
EXPOSE 4000

ENTRYPOINT ["elixir"]

