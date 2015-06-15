
FROM  java:7
MAINTAINER Monami-ya LLC, Japan "support@monami-ya.com"

ENV JBPM_VERSION 6.1.0.Final
ENV JBPM_HOME /opt/jbpm 

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME $JAVA_HOME

RUN apt-get update \
        && apt-get install wget unzip git ant -y

RUN wget -nv http://ufpr.dl.sourceforge.net/project/jbpm/jBPM%206/jbpm-${JBPM_VERSION}/jbpm-${JBPM_VERSION}-installer-full.zip -O /tmp/jbpm-${JBPM_VERSION}-installer-full.zip

RUN  unzip -q /tmp/jbpm-${JBPM_VERSION}-installer-full.zip -d ${JBPM_HOME}

ADD scripts /scripts
RUN cp /scripts/start.jboss.sh /
RUN chmod +x /start.jboss.sh
RUN cp /scripts/standalone-full-as-7.1.1.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-as-7.1.1.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-full-wildfly-8.1.0.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-wildfly-8.1.0.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/build.properties /opt/jbpm/jbpm-installer/
RUN cp /scripts/jbpm-persistence-JPA2.xml /opt/jbpm/jbpm-installer/db/

WORKDIR /opt/jbpm/jbpm-installer/
RUN ant install.demo.noeclipse
 
EXPOSE 8080 
CMD ["/start.jboss.sh"]
