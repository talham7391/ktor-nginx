FROM openjdk:8

COPY /build/libs/example-all.jar /home/app.jar
WORKDIR /home

CMD ["java", "-jar", "app.jar"]
