# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine

# Add Maintainer Info
MAINTAINER Mohammad Tanveer Haider <tanveerhaider@gmail.com>

# Add a volume pointing to /tmp
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080

ENV JAR_FILE=helloworld-0.0.2.jar
# The application's jar file
ARG JAR_FILE_PATH=target/$JAR_FILE

# Add the application's jar to the container
ADD $JAR_FILE_PATH $JAR_FILE

# Run the jar file 
ENTRYPOINT ["java","-jar","/helloworld-0.0.2.jar"]