# Use Maven + JDK 21
FROM maven:3.9.6-eclipse-temurin-21

WORKDIR /app

# Copy all project files
COPY . .

# Build JAR (skip tests for faster build)
RUN mvn clean package -DskipTests

# Runtime
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

# Copy the built JAR
COPY --from=0 /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
