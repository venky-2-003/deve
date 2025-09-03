FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy compiled jar from target folder
COPY target/*.jar app.jar

# Run jar
ENTRYPOINT ["java", "-jar", "app.jar"]
