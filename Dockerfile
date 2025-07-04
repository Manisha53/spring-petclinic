# Base image with Java 17 runtime only
FROM eclipse-temurin:17-jre-jammy

# Set working directory inside container
WORKDIR /app

# Copy the built JAR from Jenkins workspace (sent during docker build)
COPY target/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
