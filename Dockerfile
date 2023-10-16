FROM haskell:8.10-slim
WORKDIR /app
COPY . .
RUN cabal update && cabal build

