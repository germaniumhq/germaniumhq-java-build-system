FROM maven:3.5.2-jdk-8 AS source-image

# Second step of the build, start with an empty image
FROM scratch
# Copy the data from the original image
COPY --from=source-image / /

#======================================
# Prepare binary dependencies
#======================================
ONBUILD COPY bin/* /src/bin/
ONBUILD RUN chmod +x /src/bin/* && [ -f /src/bin/setup.sh ] && /src/bin/setup.sh

COPY settings.xml /m2/settings.xml

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
ONBUILD RUN cd /src && \
    mvn --settings /m2/settings.xml clean install ${MAVEN_EXTRA_PARAMETERS}

