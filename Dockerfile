FROM haskell:8.10
WORKDIR /app
COPY . .
RUN cabal update && cabal build

