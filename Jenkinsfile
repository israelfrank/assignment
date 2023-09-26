def imageName
pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'docker.io'
        STACK_NAME = 'my-app-stack_counter-service'
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                // Build and tag the Docker image
                script {
                    withCredentials([usernamePassword(credentialsId: 'Docker_Hub', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                        imageName = "israelfrank/counter-service:${env.BRANCH_NAME}"
                        sh "docker build -t ${imageName} ."
                        sh "docker push ${DOCKER_REGISTRY}/${imageName}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Update the Docker Compose file for Docker Swarm
                script {
                    sh "sed -i 's|image: israelfrank/counter-service:.*|image: ${imageName}|' docker-compose.yml" // Update image tag in the Docker Compose file
                    sh "docker stack deploy -c docker-compose.yml ${STACK_NAME}"
                }
            }

            post {
                success {
                    // If deployment is successful, update the repository with the new Docker image tag
                    script {
                        sh "git checkout ${BRANCH_NAME}" // Switch to the target branch
                        sh "git pull origin ${BRANCH_NAME}" // Pull latest changes
                        sh "git add docker-compose.yml"
                        sh "git commit -m 'Update Docker image tag'"
                        sh "git push origin ${BRANCH_NAME}" // Push the changes back to the repository
                    }
                }
            }
        }    
    } 
}
