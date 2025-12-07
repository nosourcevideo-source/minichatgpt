# Stage 1: Build JAR using Maven + Eclipse Temurin JDK
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR
FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
