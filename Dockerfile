FROM frolvlad/alpine-java:jdk8-slim
WORKDIR /
VOLUME /opt
ADD http://54.208.50.99:8081/nexus/service/local/repositories/MavenRepo/content/com/javainuse/spring-boot-aop/0.0.1/spring-boot-aop-0.0.1.jar /opt/.
EXPOSE 8080
CMD java -jar /opt/spring-boot-aop-0.0.1.jar
