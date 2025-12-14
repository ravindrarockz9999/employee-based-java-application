# single stage file here prerequesities is install java and maven before build
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the JAR you built locally
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]

################ Multi stage distroless java image #######################
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Final stage
# FROM eclipse-temurin:17-jdk                          # standared version image 670+mb
# FROM eclipse-temurin:17-jdk-alpine                   #light weight image 540+mb

FROM gcr.io/distroless/java17-debian12:nonroot         # distroless image 360+mb and it provide extra security as well

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
