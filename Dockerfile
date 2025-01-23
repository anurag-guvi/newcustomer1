# Use a base image with Java 17 for building the app
FROM openjdk:17-jdk-slim AS build

# Set working directory for the build stage
WORKDIR /app

# Copy Gradle wrapper files and build.gradle, settings.gradle
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

# Copy the source code
COPY src ./src

# Ensure gradlew is executable
RUN chmod +x gradlew

# Run Gradle build to create the JAR file
RUN ./gradlew clean build --no-daemon -x test

# Use a smaller image for the final app (slim JDK image)
FROM openjdk:17-jdk-slim

# Set working directory for the final image
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/newcustomer1-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080 for the Spring Boot application
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

#did few changes in the service account like adding roles related to artifact registry
#Added custom role in Google Cloud IAM that grants the "artifactregistry.repositories.uploadArtifacts" by name Artifact Registry Uploader
#again it is failing for this error: denied: Unauthenticated request. Unauthenticated requests do not have permission "artifactregistry.repositories.uploadArtifacts" on resource "projects/customerapp-448610/locations/us/repositories/gcr.io" (or it may not exist)

