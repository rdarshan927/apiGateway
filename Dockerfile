FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the Maven wrapper and pom.xml first for better caching
COPY .mvn .mvn
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .

# Make Maven wrapper executable
RUN chmod +x ./mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests -B

# Run the application with proper JVM settings for Cloud Run
EXPOSE 8080
CMD ["java", "-server", "-Djava.security.egd=file:/dev/./urandom", "-jar", "target/api-gateway-0.0.1-SNAPSHOT.jar"]