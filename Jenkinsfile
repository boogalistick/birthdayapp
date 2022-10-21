node {
    def app
    def reportsAbsPath = "${env.WORKSPACE}/tests"
    // host directory should be /root/jenkins_home
    def hostReportsAbsPath = reportsAbsPath.replace("/root/", "/var/")
    def versionTag = "0.1.${env.BUILD_NUMBER}"

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("apirjol/birthdayapp-server", "-f ./server/Dockerfile ./server")
    }

    stage('Test image') {
        sh "docker run  -v ${hostReportsAbsPath}:/tests apirjol/birthdayapp-server pytest -q --junitxml=/tests/report.xml"
    }

    stage('Push image') {
        docker.withRegistry('https://hub.docker.com', 'e6416be2-1865-42df-bae1-4172dd398822') {
            app.push("${versionTag}")
            app.push("latest")
        }
    }

    stage('Publish test result') {
        sh "touch tests/*.xml"
        junit 'tests/*.xml'
    }

    stage('Deploy') {
        sh 'docker container stop birthdayapp-server || true'
        sh 'docker container rm birthdayapp-server || true'
        sh "docker run -d -p 8080:8080 --name birthdayapp-server apirjol/birthdayapp-server:${versionTag}"
    }

}

