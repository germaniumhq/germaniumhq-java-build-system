stage('Build Base Java + Maven') {
    node {
        deleteDir()

        checkout scm

        dockerBuild file: './jdk8-maven/Dockerfile',
            tags: ['germaniumhq/jdk8-maven']
    }
}

stage('Build Java Image') {
    def buildJavaContainers = [:]

    buildJavaContainers."Maven+Java8" = {
        node {
            deleteDir()

            checkout scm

            dockerBuild file: './maven-build/Dockerfile',
                tags: ['germaniumhq/maven-build']
        }
    }

    buildJavaContainers."Maven Child + Java8" = {
        node {
            deleteDir()

            checkout scm

            dockerBuild file: './maven-child-build/Dockerfile',
                tags: ['germaniumhq/maven-child-build']
        }
    }

    parallel(buildJavaContainers)
}

