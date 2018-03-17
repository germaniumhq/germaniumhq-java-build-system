FROM germaniumhq/jdk8-maven

COPY settings.xml /m2/settings.xml
COPY _gbs /_gbs/

RUN chmod +x _gbs/start.sh && \
    chmod +x _gbs/run/* && \
    chmod +x _gbs/build/* && \
    mkdir /src && \
    chown -R germanium:germanium /m2 /src

#======================================
# Install prerequisite software
#======================================
ONBUILD COPY --chown=germanium:germanium  _gbs/build/install-software.sh /src/_gbs/build/install-software.sh
ONBUILD RUN /_gbs/start.sh _gbs/build/install-software.sh

#======================================
# Prepare dependencies for download
#======================================
ONBUILD USER germanium

ONBUILD COPY --chown=germanium:germanium pom-dependency.xml /src/pom-dependency.xml

# build1
ONBUILD COPY --chown=germanium:germanium _gbs/build/prepare-build1.sh /src/_gbs/build/prepare-build1.sh
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build1.sh

# build2
ONBUILD COPY --chown=germanium:germanium _gbs/build/prepare-build2.sh /src/_gbs/build/prepare-build2.sh
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build2.sh

# build3
# everything needed before the _gbs is copied before the 3rd stage
ONBUILD COPY --chown=germanium:germanium _gbs /src/_gbs
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build3.sh

# sources are copied only after stage 3
ONBUILD COPY --chown=germanium:germanium . /src

#======================================
# Do the actual build.
#======================================
ONBUILD CMD /_gbs/start.sh _gbs/build/run-build.sh

