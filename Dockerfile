FROM eclipse-temurin:17-jre
COPY target/jira-1.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]