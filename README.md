# handshake-exercise
Objective: 

The objective of this task was to create a containerized microservice that returns a JSON response ({"student_status": "hired"}) to GET requests on the /student endpoint and deploy it locally using Kubernetes.
Additionally, the task involved creating a single shell script that automates building, packaging, deploying the application, configuring the Minikube cluster, and ensuring the web server endpoint is accessible.

Action:

To achieve the objectives of the given task, the following actions were taken:

1. The creation of the following documents:
   
   a. An app.py file for creating the microservice application source code with python

   b. A Dockerfile to build and package the application’s source code into a Docker image for deployment.

   c. A Docker-command.txt file providing the commands used to build and run the app, and test the service, as requested in task instructions.

   d. A deployment.yaml and service.yaml file located in the k8s-manifest, to deploy the microservice and create a service to expose it.

   e. A k8s-command.txt file to showcase the commands used to deploy the resources and test that the installations are successful.

   f. A build-and-deploy.sh file containing commands to automate the building and deployment of the microservice into a Kubernetes cluster using shell script.

3. app.py
-	Python programming language was used to develop (a flask app) the source code for the microservice, a flask app was utilized because its light weight, easy to build, and docker, is docker and k8s friendly.

-	The app has an endpoint, /student, which when accessed via a GET request, it responds with a JSON object: {"student_status": "hired"} and an HTTP status code of 200 (see line 5-7 of app.py file). 

-	The service is exposed on port 5000 and is accessible on any IP address (0.0.0.0) to ensure the app can work inside a container.

3. Dockerfile
-	"python:3.9-slim" was used as the base image, to avoid unnecessary dependencies, and foster a fast build, deploy and run process.

-	In line 3 of the file, A non-root user (appuser) associated with a newly greated group (groupadd) was created, to follow secuirity best practices, as this limits the potential damage if the cluster is compromised, this is also follows clearly given instructions stated in the task file.

-	Working directory was set as "/app", and the application source code was copied into "/app", after which flask was installed, as it is required to run the app.py script, and the web server and routes.

-	"RUN chown -R appuser:appgroup /app" was used to change ownership of the /app directory to appuser and appgroup, this was to ensure that the non-root user(appuser) has the necessary permissions to access and execute files in the /app directory.

-	USER was set to non-root-user (appuser), the app was EXPOSED on port 5000 as it is the default port that Flask uses to serve the application.

-	and CMD ["python", "app.py"] was important because it starts the Flask application when the container is launched, making the service available to handle requests.

4. K8s-manifest
- This file contains commands that make up the deployment.yaml and service.yaml, which describes the deployment specifications for the student-testapp application, and the service that exposes the deployed application within the cluster to the internet.
  
- it is also made up of the k8s-command.txt file which contains the commands responsible for setting up installations and creating the cluster.
  
- in specifics, the name of the deployment was set to student-testapp-deployment, with namespace put as default, as there is no isolation requirement for this application.
  
- replicas were put at 1, due to the requirements of this task, the image was referenced using my dockerhub username kayuze and the image tag (student-testapp:latest), allowing for k8s to successfully pull the docker image from the docker hub repository.
  
- for additional secuirity, the container was set to run as a non-root, despite earlier specifications in the dockerfile. The application was set to listen on port 5000.
  
- The service was set with "student-test-app-service as name, and the selector was set as student-test app to match the pods as labelled in the deployment manifest.
  
- the communication protocol (TCP) was set exposed at port 80, the default http port, to enhance easy access and use by clients.
  
- the target port was set as 5000, where the containers run, just as specified in the deployment manifest. It will help maintain user-friendly access through service port 80, while the service handles routing to the correct container port (5000). 

6. build-and-deploy.sh
-	one of the most important properties of the created shell script is its abilty to handle error, hence the reason for "set -e" in the line 3 of the file. this command stops deployment immediately an error is encountered to prevent further deployment of a dysfunctional container. 

-	Line 6 of the K8s-manifest is used to build the image, and line 9 Ensures that the Minikube cluster is running, and If it's not running, kickstarts the Minikube cluster, setting the cluster name as handshake-exercise.

-	the deployment and service command deploys the application and its service to the Kubernetes cluster using manifests. it accessible within the cluster.

-	"kubectl port-forward service/student-testapp-service 8080:80" is to allow access to the application running in the Kubernetes cluster through http://localhost:8080.

  Note: To test application after successful deployment run http://localhost:8080/student or http://localhost:5000/student





 
