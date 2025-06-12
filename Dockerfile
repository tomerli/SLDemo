# Build stage
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY . .

# Update CA certificates and Download SeaLights agent
RUN apt-get update && apt-get install -y ca-certificates && \
    curl -s -o sealights-java-latest.zip https://agents.sealights.co/sealights-java/sealights-java-latest.zip && \
    unzip -oq sealights-java-latest.zip -d ./sealights && \
    rm sealights-java-latest.zip

# Build App with SeaLights
RUN gradle build --no-daemon

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built artifact and SeaLights agent from build stage
COPY --from=build /app/build/libs/*.jar app.jar
COPY --from=build /app/sealights ./sealights

# Set environment variables
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV SPRING_PROFILES_ACTIVE="prod"
ENV JAVA_TOOL_OPTIONS="-javaagent:/app/sealights/sl-test-listener.jar"

# Expose the port that your application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]