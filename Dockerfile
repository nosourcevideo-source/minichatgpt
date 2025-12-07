# Use Java 17 JDK + Maven installed for building
FROM maven:3.9.6-eclipse-temurin-17

# Set working directory inside container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Build the Spring Boot jar using Maven (skip tests for faster build)
RUN mvn clean package -DskipTests

# Use Java 21 runtime for running the app
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=0 /app/target/*.jar app.jar

# Expose port 8080 for the app
EXPOSE 8080

# Start the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
