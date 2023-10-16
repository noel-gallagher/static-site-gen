#! /bin/bash
docker build -t static-site-gen .
docker run static-site-gen cabal test

