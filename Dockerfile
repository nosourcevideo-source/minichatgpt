# Stage 1: Build the Spring Boot JAR using Maven + JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy project files
COPY . .

# Build the jar (skip tests)
RUN mvn clean package -DskipTests

# Stage 2: Runtime using JDK 21
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the jar built from previous stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
