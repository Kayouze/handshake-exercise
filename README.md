# handshake-exercise
The take home exercise was solved through the below actions.

To achieve the objectives of the given task, see steps below:

1. Creation of files:
   
   a. An app.py file for creating the microservice application source code with python.

   b. A Dockerfile which contain steps to build a docker container image from the app.py source code.

   c. A Docker-command.txt file providing the commands used to build and run the app, and test the service locally as requested in task instructions.

   d. A deployment.yaml and service.yaml file located in the k8s-manifest folder.

   e. A k8s-command.txt file containing the commands used to deploy the resources and test that the installations are successful.

   f. A build-and-deploy.sh script file containing commands to automate the building of a docker image, starting of a minikube cluster and applying of Kubernetes manifest.

2. app.py
-	Python programming language was used to develop a flask app because its light weight and easy to build.

-	The app has an endpoint, /student, which when accessed via a GET request, it responds with a JSON object: {"student_status": "hired"} and an HTTP status code of 200 (see line 5-7 in the app.py file). 

-	The service is exposed on port 5000.

3. Dockerfile
-	python:3.9-slim was used as the base image.

-	In line 3 of the file, A non-root user (appuser) associated with a newly greated group (groupadd) was created, to follow secuirity best practices, this also follows clearly given instructions stated in the task file.

-	A working directory was set as /app, and the application source code was copied into /app, after which flask was installed.

-	RUN chown -R appuser:appgroup /app was used to change ownership of the /app directory to appuser and appgroup, this was to ensure that the non-root user(appuser) has the necessary permissions to access and execute files in the /app directory.

-	USER was set to non-root-user (appuser), the app was EXPOSED on port 5000 as it is the default port that Flask uses to serve the application.

- CMD ["python", "app.py"] starts the Flask application when the container is launched, making the service available to handle requests.

4. k8s-manifest
- This folder contains files, deployment.yaml and service.yaml, which describes the deployment specifications for the student-testapp application, and the service that exposes the deployed application within the cluster.
  
- The folder is also made up of the k8s-command.txt file which contains the kubernetes commands responsible for applying the manifests and to check the kubernetes resources.
  
- The name of the deployment is student-testapp-deployment, and this will be setup in the default namespace with 2 replicas, to create 2 pods.The image was referenced using my dockerhub username kayuze and the image tag (student-testapp:latest), allowing for k8s to successfully pull the docker image from the docker hub repository. For additional secuirity, the container was set to run as a non-root. The application was set to listen on port 5000.
  
- The service name is student-test-app-service, and the selector was set as student-test app to match the pods as labelled in the deployment.yaml. The TCP protocol  was set at port 80, the default http port. The target port was set as 5000 just as specified in the deployment.yaml. 

6. build-and-deploy.sh
-	one of the most important properties of the created shell script is its abilty to handle error, hence the reason for "set -e" in the line 3 of the file. this command stops deployment immediately an error is encountered. 

- The script file runs the docker command to build a docker image called student-testapp.

- This script also ensures that a minkube cluster named handshake-exercise is setup and running successfully.

- This script file will also apply the kubernetes manifest (deployment.yaml and service.yaml) in the k8s-manifest folder and port forward the service using the command kubectl port-forward service/student-testapp-service 8080:80 to allow access to the application running in the Kubernetes cluster.

  Note: To test application after successful deployment run http://localhost:5000/student
  
  Further instructions for local and cluster development can be found in the docker-command and k8s-manifest-command text files.
  
  Thank you. 





 
