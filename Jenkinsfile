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

    buildJavaContainers."Java8 Runtime" = {
        node {
            deleteDir()

            checkout scm

            dockerBuild file: './java-run/Dockerfile',
                tags: ['germaniumhq/java8']
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

