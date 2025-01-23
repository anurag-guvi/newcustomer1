# Use a base image with Java 17
FROM openjdk:17-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy Gradle wrapper files and build.gradle, settings.gradle
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

# Copy all source files
COPY src ./src

# Ensure gradlew is executable
RUN chmod +x gradlew

# Run Gradle build to create the JAR file
RUN ./gradlew clean build --no-daemon -x test

# Copy the JAR file from the build stage (you may need to run Gradle build first)
#COPY build/libs/newcustomer1-0.0.1-SNAPSHOT.jar app.jar
COPY --from=build /app/build/libs/newcustomer1-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
