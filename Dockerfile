FROM elixir:1.9.2

# NOTE the WORKDIR should not be the users home dir as the will copy container cookie into host machine
WORKDIR /opt/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Add tools needed for development
# inotify-tools: gives filesystem events that are used to trigger recompilation
RUN apt-get update && apt-get install -y inotify-tools nodejs yarn

ENV MIX_ARTIFACTS_DIRECTORY=../mix_artifacts

RUN mix local.hex --force && mix local.rebar --force && \
    mkdir -p ${MIX_ARTIFACTS_DIRECTORY}/deps && mkdir -p ${MIX_ARTIFACTS_DIRECTORY}/_build && \
    mkdir config

# Build all dependencies separately to the application code
COPY mix.* ./
RUN mix do deps.get
COPY config/* config/
RUN mix deps.compile \
    && MIX_ENV=test mix deps.compile

# Add application code as final layer
# This will skip the _build and deps directories as per .dockerignore
COPY . .

# Make sure the Docker image can be started without waiting for the project to compile
# NOTE: mix deps.get is needed to update the freshly copied mix.lock file
RUN mix do deps.get, compile

WORKDIR /opt/app/apps/acolyte_trials_web/assets

RUN yarn install -D

WORKDIR /opt/app

CMD ["sh", "./bin/start.sh"]

