
FROM wmarinho/ubuntu:oracle-jdk-7
MAINTAINER Wellington Marinho wpmarinho@globo.com

ENV JBPM_VERSION 6.1.0.Final
ENV JBPM_HOME /opt/jbpm 

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME $JAVA_HOME

RUN apt-get update \
        && apt-get install wget unzip git ant -y

RUN wget -nv http://ufpr.dl.sourceforge.net/project/jbpm/jBPM%206/jbpm-${JBPM_VERSION}/jbpm-${JBPM_VERSION}-installer-full.zip -O /tmp/jbpm-${JBPM_VERSION}-installer-full.zip

RUN  unzip -q /tmp/jbpm-${JBPM_VERSION}-installer-full.zip -d ${JBPM_HOME}
WORKDIR /opt/jbpm/jbpm-installer/
RUN ant install.demo
 
EXPOSE 8080 
CMD ["ant","start.demo]
