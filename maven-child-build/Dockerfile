FROM germaniumhq/jdk8-maven

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
ONBUILD RUN chown -R germanium:germanium /m2

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

