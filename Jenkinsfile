pipeline {
    environment {
        IMAGEN = "juanantpineda/django_tutorial"
        USUARIO = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("test the project") {
            agent {
                docker {
                image "python:3"
                args '-u root:root'
                }
            }
            stages {
                stage('Clonando el repositorio') {
                    steps {
                        git branch:'master',url:'https://github.com/JuanantPineda/django_tutorial.git'
                    }
                }
                stage('Instalacion del requirements.txt') {
                    steps {
                        sh 'pip install -r django_tutorial/requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'cd django_tutorial && python3 manage.py test --settings=django_tutorial.settings_desarrollo'
                    }
                }
            }
        }
        stage('Creación de la imagen') {
            agent any
            stages {
                stage('Creando la imagen') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:$BUILD_NUMBER"
                        }
                    }
                }
                stage('Deploy') {
                    steps {
                        script {
                            docker.withRegistry( '', USUARIO ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Clean Up') {
                    steps {
                        sh "docker rmi $IMAGEN:$BUILD_NUMBER"
                        }
                }
            }
        }
    }
    post {
        always {
        mail to: 'juanantpiama@gmail.com',
        subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
        body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}