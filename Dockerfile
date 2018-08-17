FROM jboss/wildfly:11.0.0.Final
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
COPY --chown=jboss:jboss glowroot/ /glowroot/
COPY libyjpagent.so /opt/jboss/
ENV JAVA_OPTS="-Xms256m -Xmx2048m -XX:+UseG1GC -agentlib:jdwp=transport=dt_socket,address=0.0.0.0:20021,server=y,suspend=n -agentpath:/opt/jboss/libyjpagent.so=port=20022,delay=10000 -XX:-OmitStackTraceInFastThrow -Djava.net.preferIPv4Stack=true -javaagent:/glowroot/glowroot.jar"
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
