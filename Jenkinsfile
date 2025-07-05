pipeline {
    agent any
    tools {
        maven 'Apache Maven 3.9.9'//exact names as mentioned in global tools configuration
        jdk 'JDK-17'
    }
    stages {
        stage('Fetch Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Manisha53/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install -DskipTests' //since we already ran tests
            }
            post {
                success {
                    echo 'Archive artifacts...'
                    archiveArtifacts artifacts: '**/target/*.jar'
                }
                failure {
                    echo 'Build failed.'
                }
            }
        }

        // stage('Get Commit Hash') {
        //     steps {
        //         script {
        //             COMMIT_HASH = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        //             env.GIT_COMMIT = COMMIT_HASH
        //         }
        //     }
        // }

        stage('Unit Tests') {
            steps {
                bat 'mvn test' // bat: since we are running jenkins on windows
            }
        }
       stage('Sonar Code Analysis') {
            steps {
                withSonarQubeEnv('sonarserver') { // 'sonarserver' is the name of the SonarQube server configured in Jenkins
                    echo 'Running SonarQube analysis...'
                    bat 'mvn clean verify sonar:sonar -Dsonar.projectKey=petclinic' //verify runs tests and generates the JaCoCo report and sonar:sonar uploads the report to SonarQube.
                }
            }
        }
        // stage('Quality Gate') {
        //     steps {
        //         echo 'Waiting for SonarQube Quality Gate...'
        //         timeout(time: 1, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }
        stage('Docker Build & Push') {
            steps {
                script {
                    def IMAGE_TAG = "${env.BUILD_NUMBER}"
                    def IMAGE_NAME = "manisha4/spring-petclinic:${IMAGE_TAG}"

                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat """
                            docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                            docker build -t ${IMAGE_NAME} .
                            docker push ${IMAGE_NAME}
                        """
                    }
                }
            }
        } 
        stage('Test kubectl') {
            steps {
                withEnv(["KUBECONFIG=C:\\Users\\manis\\.kube\\config"]) {
                    bat 'kubectl version'
                }
            }
        } 
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    def IMAGE_TAG = "${env.BUILD_NUMBER}" 
                    def DOCKER_IMAGE = "manisha4/spring-petclinic:${IMAGE_TAG}"

                    withEnv(["KUBECONFIG=C:\\Users\\manis\\.kube\\config"]) {
                        bat """
                            echo "##### Deploying image: ${DOCKER_IMAGE} #####"

                            REM Copy and patch YAML
                            copy k8s\\deployment.yml k8s\\deployment-patched.yml
                            powershell -Command "(Get-Content k8s\\deployment-patched.yml) -replace 'IMAGE_PLACEHOLDER', '${DOCKER_IMAGE}' | Set-Content k8s\\deployment-patched.yml"

                            REM Apply to Kubernetes
                            echo "##### Apply to Kubernetes #####"
                            kubectl apply -f k8s\\deployment-patched.yml
                            kubectl apply -f k8s\\service.yml

                            REM Verify status
                            echo "##### Verifying status #####"
                            kubectl get pods -o wide
                            kubectl get svc -o wide
                        """
                    }
                }
            }
        }

    }
}