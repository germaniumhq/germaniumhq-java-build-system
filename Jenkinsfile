stage('Build Base Java + Maven') {
    node {
        deleteDir()

        checkout scm

        dockerBuild file: './jdk8-base/Dockerfile',
            tags: ['germaniumhq/jdk8-base']
    }
}

stage('Build Java Image') {
    def buildJavaContainers = [:]

    buildJavaContainers."Maven+Java8" = {
        node {
            deleteDir()

            checkout scm

            dockerBuild file: './jdk8-build/Dockerfile',
                tags: ['germaniumhq/jdk8-build']
        }
    }

    buildJavaContainers."Maven Child+Java8" = {
        node {
            deleteDir()

            checkout scm

            dockerBuild file: './jdk8-child-build/Dockerfile',
                tags: ['germaniumhq/jdk8-child-build']
        }
    }

    parallel(buildJavaContainers)
}

