FROM germaniumhq/jdk8-base:8

USER root

COPY _gbs /_gbs/

RUN chmod +x _gbs/start.sh && \
    chmod +x _gbs/run/* && \
    chmod +x _gbs/build/*/*.sh _gbs/build/*.sh _gbs/*.sh && \
    mkdir /src && \
    chown -R germanium:germanium /src /_gbs

#======================================
# Allow sub-folder GBSs
#======================================

# Must end, and start with slash.
ONBUILD ARG GBS_PREFIX="/"

#======================================
# Install prerequisite software
#======================================
ONBUILD COPY --chown=germanium:germanium ${GBS_PREFIX}_gbs/build/install-software /src${GBS_PREFIX}_gbs/build/install-software
ONBUILD RUN /_gbs/start.sh /src${GBS_PREFIX}_gbs/build/install-software/install-software.sh

#======================================
# Prepare dependencies for download
#======================================
ONBUILD USER germanium

# build1
ONBUILD COPY --chown=germanium:germanium ${GBS_PREFIX}_gbs/build/prepare-build1 /src${GBS_PREFIX}_gbs/build/prepare-build1
ONBUILD RUN /_gbs/start.sh /src${GBS_PREFIX}_gbs/build/prepare-build1/prepare-build1.sh

# build2
ONBUILD COPY --chown=germanium:germanium ${GBS_PREFIX}_gbs/build/prepare-build2 /src${GBS_PREFIX}_gbs/build/prepare-build2
ONBUILD RUN /_gbs/start.sh /src${GBS_PREFIX}_gbs/build/prepare-build2/prepare-build2.sh

# build3
ONBUILD COPY --chown=germanium:germanium ${GBS_PREFIX}_gbs/build/prepare-build3 /src/_gbs/build/prepare-build3
ONBUILD RUN /_gbs/start.sh /src${GBS_PREFIX}_gbs/build/prepare-build3/prepare-build3.sh

# sources are copied only after stage 3
ONBUILD COPY --chown=germanium:germanium . /src

#======================================
# Do the actual build.
#======================================
ONBUILD RUN /_gbs/start.sh /src${GBS_PREFIX}_gbs/build/run-build.sh
