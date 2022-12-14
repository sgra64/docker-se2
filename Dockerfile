# base image, https://hub.docker.com/r/adoptopenjdk/openjdk11
# Mac with M1-Chip use: FROM --platform=linux/amd64 adoptopenjdk/openjdk11:alpine
FROM adoptopenjdk/openjdk11:alpine

# create a new directory in the container: /opt/app
RUN mkdir /opt/app

# copy 'app.jar' from the project directory into container: /opt/app
COPY app.jar /opt/app

# define a command that executes when the container started
CMD ["java", "-jar", "/opt/app/app.jar"]
