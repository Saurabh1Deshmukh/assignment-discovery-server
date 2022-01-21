FROM openjdk:8
EXPOSE 8761
ADD target/assignment-discovery-server-0.0.1-SNAPSHOT.jar assignment-discovery-server.jar
ENTRYPOINT ["java","-jar","assignment-discovery-server.jar"]