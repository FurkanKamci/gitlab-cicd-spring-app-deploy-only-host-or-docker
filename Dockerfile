# AS <NAME> to name this stage as maven
FROM maven:3-openjdk-18-slim AS maven

WORKDIR /usr/src/app
COPY . /usr/src/app

# Compile and package the application to an executable JAR
RUN mvn package

# For Java 17
FROM openjdk:17-alpine

ARG JAR_FILE=spring-app-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","spring-app-0.0.1-SNAPSHOT.jar"]