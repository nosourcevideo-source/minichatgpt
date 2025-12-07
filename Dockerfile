# -----------------------------
# Stage 1: Build the JAR
# -----------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (offline)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the Spring Boot JAR (skip tests for faster build)
RUN mvn clean package -DskipTests

# -----------------------------
# Stage 2: Run the JAR
# -----------------------------
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the JAR built in previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]
