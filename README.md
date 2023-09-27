# assignment

1. I have installed Jenkins on an Amazon EC2 instance, and I've configured it to run on port 443.

2. I have developed an application that counts HTTP POST requests. To deploy this application consistently and reliably, I've created a Dockerfile to package the application into a container. Additionally, I've defined a `docker-compose.yml` file to deploy the app with Docker Swarm, ensuring the stability of my application.

3. As part of my continuous integration and continuous deployment (CI/CD) process, I've set up a Jenkins job that automatically performs the following steps when code changes are pushed to my Git repository:

   - I clone the Git repository to the Jenkins workspace.
   - I build a Docker image of my application using a Dockerfile.
   - I push the newly built Docker image to a Docker Hub repository, making it available for deployment.
   - I dynamically update the `docker-compose.yml` file to specify the new image version.
   - I execute a deployment command using Docker Swarm.

This CI/CD pipeline automates the process of building, packaging, and deploying my application whenever changes are made to the codebase, providing a reliable and efficient way to maintain and update the app.

(Due to resource limitations on the server, I explored the option of setting up a Kubernetes cluster using tools like Minikube and Kind. However, I encountered difficulties in attempting to install these Kubernetes-related components on the server, which led me to opt for Docker Swarm as the deployment solution instead).