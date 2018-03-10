FROM germaniumhq/jdk8-maven

COPY settings.xml /m2/settings.xml

#======================================
# Prepare binary dependencies
#======================================
ONBUILD COPY bin/setup.sh /src/bin/
ONBUILD RUN chmod +x /src/bin/setup.sh && \
            /src/bin/setup.sh && \
            chown -R germanium:germanium /src /m2

ONBUILD ARG DISPLAY=vnc-server:0
ONBUILD ARG MAVEN_EXTRA_PARAMETERS=

ONBUILD ENV DISPLAY=${DISPLAY} \
            MAVEN_EXTRA_PARAMETERS=${MAVEN_EXTRA_PARAMETERS}

ONBUILD USER germanium

#======================================
# Prepare dependencies for download
#======================================
ONBUILD COPY /pom-dependency.xml /src/pom-dependency.xml
ONBUILD RUN cd /src && \
    mvn --settings /m2/settings.xml -f pom-dependency.xml dependency:go-offline clean install

#======================================
# Prepare the sources.
#======================================
ONBUILD COPY / /src/
ONBUILD USER root
ONBUILD RUN chown -R germanium:germanium /src /m2 && \
        chmod +x /src/bin/* && \
        /src/bin/build.sh
ONBUILD USER germanium
ONBUILD CMD cd /src && \
    env && \
    echo "RUNNING: mvn ${MAVEN_EXTRA_PARAMETERS} --settings /m2/settings.xml clean install" && \
    bash -c "mvn ${MAVEN_EXTRA_PARAMETERS} --settings /m2/settings.xml clean install"

