# Use an official Maven image as a base
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project's POM file to the container
COPY pom.xml .

# Copy the entire project (except what's in .dockerignore) into the container
COPY . .

# Build the application using Maven
RUN mvn clean package

# Use an OpenJDK image as a base for the runtime environment
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage to the runtime container
COPY --from=build /app/target/livelo-0.0.1-SNAPSHOT.jar .

# Command to run the application
CMD ["java", "-jar", "livelo-0.0.1-SNAPSHOT.jar"]
