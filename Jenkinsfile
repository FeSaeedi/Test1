pipeline {
  environment {
    registry = "fesaeedi/my-first-repo"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/FeSaeedi/Test1.git'
            }
        }
        stage('Build') {
            steps {
                bat "dotnet build --configuration Release"
            }
        }
        stage('Test') {
            steps {}
        }
        stage('Building image') {
            steps{
                script { dockerImage = docker.build registry + ":$BUILD_NUMBER"}
            }
        }
        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps{  bat "docker rmi $registry:$BUILD_NUMBER"}
        }
        stage('Pull Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.pull()
                    }
                }
            }
        }
        stage('run Image'){
            steps{
                bat "docker run --rm --name aspnetcore_sample $registry"
            }
        }
    }
}