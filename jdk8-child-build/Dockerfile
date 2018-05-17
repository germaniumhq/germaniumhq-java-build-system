FROM germaniumhq/jdk8-base
COPY _gbs /_gbs/

RUN chmod +x _gbs/start.sh && \
    chmod +x _gbs/run/* && \
    chmod +x _gbs/build/*/*.sh _gbs/build/*.sh _gbs/*.sh && \
    mkdir /src && \
    chown -R germanium:germanium /src /_gbs

#======================================
# Install prerequisite software
#======================================
ONBUILD COPY --chown=germanium:germanium  _gbs/build/install-software /src/_gbs/build/install-software
ONBUILD RUN /_gbs/start.sh _gbs/build/install-software/install-software.sh

#======================================
# Prepare dependencies for download
#======================================
ONBUILD USER germanium

ONBUILD COPY --chown=germanium:germanium --from=child-image /m2 /m2

# build1
ONBUILD COPY --chown=germanium:germanium _gbs/build/prepare-build1 /src/_gbs/build/prepare-build1
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build1/prepare-build1.sh

# build2
ONBUILD COPY --chown=germanium:germanium _gbs/build/prepare-build2 /src/_gbs/build/prepare-build2
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build2/prepare-build2.sh

# build3
ONBUILD COPY --chown=germanium:germanium _gbs/build/prepare-build3 /src/_gbs/build/prepare-build3
ONBUILD RUN /_gbs/start.sh _gbs/build/prepare-build3/prepare-build3.sh

# sources are copied only after stage 3
ONBUILD COPY --chown=germanium:germanium . /src

#======================================
# Do the actual build.
#======================================
ONBUILD CMD /_gbs/start.sh _gbs/build/run-build.sh

