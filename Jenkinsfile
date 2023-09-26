def imageName
pipeline {
    agent any
    environment {
        BRANCH_NAME = params.BRANCH_NAME
        DOCKER_REGISTRY = 'docker.io'
        STACK_NAME = 'my-app-stack_counter-service'
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                // Build and tag the Docker image
                script {
                    imageName = "${DOCKER_REGISTRY}/israelfrank/counter-service:${BRANCH_NAME}"
                    sh "docker build -t ${imageName} ."
                    sh "docker push ${imageName}"
                }
            }
        }

        stage('Deploy') {
            steps {
                // Update the Docker Compose file for Docker Swarm
                script {
                    sh "docker stack deploy -c docker-compose.yml ${STACK_NAME}"
                }
            }
            post {
                success {
                    // If deployment is successful, update the repository with the new Docker image tag
                    script {
                        sh "git checkout ${BRANCH_NAME}" // Switch to the target branch
                        sh "git pull origin ${BRANCH_NAME}" // Pull latest changes
                        sh "sed -i 's|image: israelfrank/counter-service:.*|image: israelfrank/counter-service:${imageName}|' docker-compose.yml" // Update image tag in the Docker Compose file
                        sh "git add docker-compose.yml"
                        sh "git commit -m 'Update Docker image tag'"
                        sh "git push origin ${BRANCH_NAME}" // Push the changes back to the repository
                    }
                }
            }
        }    
    } 
}
