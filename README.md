# 🏥 Spring Petclinic CI/CD Pipeline with Jenkins, Docker, Kubernetes, and Monitoring

This project demonstrates an end-to-end CI/CD pipeline for the popular **Spring Petclinic** application using Jenkins, Docker, Kubernetes, and SonarQube for static code analysis.

---

## 🚀 Technologies Used

- 🔧 Jenkins (Pipeline as Code)
- ☕ Java 17 (via JDK)
- 🐘 Maven (for build & test)
- 🐳 Docker (build & push images)
- ☁️ Kubernetes (for deployment)
- 🔍 SonarQube (code quality analysis)

---

## ✅ Jenkins Pipeline Stages

| Stage                     | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `Tool Install`           | Initializes required tools: Maven and JDK 17                                |
| `Fetch Code`             | Clones the GitHub repository from `main` branch                             |
| `Build`                  | Builds the project using `mvn clean install -DskipTests`                    |
| `Unit Tests`             | Runs automated tests using `mvn test`                                       |
| `Sonar Code Analysis`    | Integrates with SonarQube for static code analysis                          |
| `Docker Build & Push`    | Builds the Docker image and pushes it to Docker Hub                         |
| `Test kubectl`           | Verifies connectivity to the Kubernetes cluster via `kubectl version`       |
| `Deploy to Kubernetes`   | Applies Kubernetes manifests to deploy the application using `NodePort`     |

---

## 🧪 Application Access

Once deployed, the application is accessible at: http://<Node-IP>:<NodePort>
Port forwarding must be configured in your Vagrantfile or Kubernetes cluster setup.

## 📂 Folder Structure

spring-petclinic/
├── Dockerfile
├── Jenkinsfile
├── k8s/
│ ├── deployment.yml
│ └── service.yml
├── src/
├── target/
└── README.md

## 📷 Screenshots
Jenkins Pipeline-
![image](https://github.com/user-attachments/assets/a6bc7e82-cfd6-4193-91fb-c381174d24c4)

Deployed application is runniing on nodeport - http://10.0.0.10:31090/
![image](https://github.com/user-attachments/assets/110bfc4e-6c11-49d3-874d-ceef552a9b5d)

SonarQube code quality on http://localhost:9000/dashboard?id=petclinic
![image](https://github.com/user-attachments/assets/f3d9294a-54c1-4863-ae88-7b8bdf8b5723)

Docker images on Docker Desktop. Connected DockerHub to Docker Desktop-
![image](https://github.com/user-attachments/assets/87f5c484-798f-4436-9dd7-71f83a53282a)

Builds on Docker Desktop-
![image](https://github.com/user-attachments/assets/89bae0b3-fbe3-47ca-af7f-2cb3b073896a)

Containers on Docker Desktop-
![image](https://github.com/user-attachments/assets/f5441c0f-de15-46cb-8ae5-e77404edeaa5)

Kubernetes cluster has been setup on 3 Vagrant VM(s) - 1 Master and 2 Worker Nodes. And to allow Jenkins(running on my local machine) to connect to K8s(running on Vagrant VM) had to forward Kubernetes API server port by adding this line of code in our Vagrantfile "controlplane.vm.network "forwarded_port", guest: 6443, host: 6443, auto_correct: true" then create a "C:\Users\<my-username>\.kube\config" file from config file of Master Node (cat ~/.kube/config).

![image](https://github.com/user-attachments/assets/bbd620b8-6271-492f-8f0c-d956ef68d673)

## 🙌 Acknowledgements

- [Spring Petclinic](https://github.com/spring-projects/spring-petclinic)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [SonarQube](https://www.sonarqube.org/)
- [Docker Hub](https://hub.docker.com/)
- [Kubernetes](https://kubernetes.io/)



