FROM eclipse-temurin:21-jdk-alpine AS builder
LABEL authors="wallde"
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew clean build -x test

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/core-api-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]