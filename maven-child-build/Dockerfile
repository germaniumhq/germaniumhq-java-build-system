FROM maven:3.5.2-jdk-8 AS source-image

# Second step of the build, start with an empty image
FROM scratch
# Copy the data from the original image
COPY --from=source-image / /

ARG childImage

# only the maven repository is being copied
ONBUILD COPY --from=child-image /m2 /m2

ONBUILD COPY /pom-dependency.xml /src/pom-dependency.xml
ONBUILD RUN cd /src && \
    mvn --settings /m2/settings.xml -f pom-dependency.xml dependency:go-offline clean install

ONBUILD COPY / /src/
ONBUILD RUN chmod +x /src/bin/* || true
ONBUILD CMD cd /src && \
    mvn --settings /m2/settings.xml clean install ${MAVEN_EXTRA_PARAMETERS}

