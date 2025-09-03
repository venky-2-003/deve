# Start with an official JDK base image
FROM openjdk:17-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy compiled jar from Jenkins workspace into container
COPY target/*.jar app.jar

# Run jar file
ENTRYPOINT ["java", "-jar", "app.jar"]

