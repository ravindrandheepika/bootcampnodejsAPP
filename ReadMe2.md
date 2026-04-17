# 🚀 DevSecOps Pipeline using Jenkins, SonarQube, Snyk & Docker

## 📌 Project Overview

This project demonstrates a **complete DevSecOps CI/CD pipeline**:

```
GitHub → Jenkins → SonarQube → Snyk → Docker → Docker Hub
```

It covers:

* Continuous Integration (CI)
* Static Code Analysis (SAST)
* Dependency Vulnerability Scanning (SCA)
* Containerization & Deployment

---

## 🏗️ Architecture

```
Developer → GitHub → Jenkins Pipeline
                          ↓
                 SonarQube Analysis (SAST)
                          ↓
                     Snyk Scan (SCA)
                          ↓
                  Docker Build & Push
```

---

## ⚙️ Prerequisites

### 🔹 Infrastructure

* Ubuntu 22.04 EC2 Instance (Min: 4GB RAM, Recommended: 8GB)
* Open ports:

  * 8080 → Jenkins
  * 9000 → SonarQube

---

## 🔧 Step 1: Install Jenkins(FOllow .sh file)

```bash
sudo apt update -y
sudo apt install -y openjdk-21-jdk

echo "deb [trusted=yes] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

sudo apt update -y
sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
```

👉 Access: `http://<EC2-IP>:8080`

---

## 🔧 Step 2: Install SonarQube

Use your script or:

```bash
sudo ./sonar.sh
```

👉 Access: `http://<EC2-IP>:9000`
👉 Default Login: `admin/admin`

---

## 🔧 Step 3: Install Required Tools

```bash
sudo apt install -y nodejs npm docker.io unzip

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

---

## 🔧 Step 4: Install Sonar Scanner

```bash
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.0.0.4432-linux.zip
sudo unzip sonar-scanner-cli-*.zip
sudo mv sonar-scanner-* sonar-scanner
sudo chmod -R 755 sonar-scanner
```

---

## 🔧 Step 5: Install Snyk

```bash
sudo npm install -g snyk
```

---

## 🔑 Step 6: Generate Tokens

### 🔹 SonarQube Token

* Go to: SonarQube → My Account → Security → Generate Token

### 🔹 Snyk Token

* Login to Snyk → Account Settings → API Token

---

## 📦 Step 7: Jenkins Pipeline Setup

1. Open Jenkins
2. Create New Item → Pipeline
3. Paste below Jenkinsfile

---

## 📜 Jenkinsfile

```groovy
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your-dockerhub-username/app"
        DOCKER_TAG = "latest"
        SONAR_HOST_URL = "http://<EC2-IP>:9000"
        SONAR_AUTH_TOKEN = "your-sonar-token"
        SNYK_TOKEN = "your-snyk-token"
        DOCKER_CREDS_USR = "your-dockerhub-username"
        DOCKER_CREDS_PSW = "your-dockerhub-password"
    }

    stages {

        stage('Check Tools') {
            steps {
                sh '''
                node -v
                npm -v
                docker -v
                '''
            }
        }

        stage('Checkout') {
            steps {
                git 'https://github.com/rajcocvs/bootcampnodejsAPP.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Sonar Scan') {
            steps {
                sh '''
                export PATH=$PATH:/opt/sonar-scanner/bin

                sonar-scanner \
                  -Dsonar.projectKey=my-node-app \
                  -Dsonar.sources=. \
                  -Dsonar.host.url=$SONAR_HOST_URL \
                  -Dsonar.login=$SONAR_AUTH_TOKEN
                '''
            }
        }

        stage('Snyk Scan') {
            steps {
                sh '''
                snyk auth $SNYK_TOKEN
                snyk test || true
                '''
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
                docker push $DOCKER_IMAGE:$DOCKER_TAG
                '''
            }
        }
    }
}
```

---

## ▶️ Step 8: Run Pipeline

* Click **Build Now**
* Monitor Console Output

---

## ✅ Expected Output

* SonarQube Analysis Successful
* Snyk Vulnerability Report
* Docker Image Pushed to DockerHub

---

## 📊 Results

| Tool      | Purpose               |
| --------- | --------------------- |
| Jenkins   | CI/CD                 |
| SonarQube | Code Quality (SAST)   |
| Snyk      | Dependency Scan (SCA) |
| Docker    | Containerization      |

---

## ⚠️ Best Practices

* Use Jenkins Credentials (avoid hardcoding secrets)
* Use NodeJS ≥ 18
* Use DockerHub tokens instead of passwords
* Enable Webhooks for automation

---

## 🚀 Future Enhancements

* ArgoCD Deployment
* Kubernetes Integration
* Helm Charts
* Blue-Green Deployment

---

## 👨‍💻 Author

Rajco DevSecOps Pipeline Project

```
```
