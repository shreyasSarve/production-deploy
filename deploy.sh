#!/bin/bash

docker-compose down
# Install openjdk-17
sudo apt install openjdk-17-jdk-headless
# Exposrt java-home for building 
export export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Dockerizing api-project
git clone git@github.com:shreyasSarve/photus.git
cd photus

./mvnw clean
./mvnw install
./mvnw package

docker build -t photus:lastest .

cd ..


# Dockerrise extractor-project
git clone git@github.com:shreyasSarve/extractor-microservice.git
cd extractor-microservice

./mvnw clean
./mvnw install
./mvnw package

docker build -t extractor-micro:latest

cd ..


# Create volumes (if not available)
docker volume create mysql_data_2

# Start applications
docker-compose up 




# Clean ups 

rm -rf extractor-microservice
rm -rf photus