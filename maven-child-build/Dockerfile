FROM maven:3.5.2-jdk-8

#======================================
# Prepare binary dependencies
#======================================
ONBUILD COPY bin/* /src/bin/
ONBUILD RUN chmod +x /src/bin/* && [ -f /src/bin/setup.sh ] && /src/bin/setup.sh

#======================================
# Copy the child things only after binaries are installed, since they are not
# shared.
#======================================
ONBUILD COPY --from=child-image /m2 /m2

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
ONBUILD RUN cd /src && /src/bin/build.sh
ONBUILD RUN cd /src && \
    mvn --settings /m2/settings.xml clean install ${MAVEN_EXTRA_PARAMETERS}

