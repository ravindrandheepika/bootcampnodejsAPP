# 🚀 Automated DevSecOps CI/CD Pipeline for Node.js on AKS

## 📌 Project Overview

This project demonstrates a **production-grade DevSecOps CI/CD pipeline** that automates the entire application lifecycle—from code commit to secure deployment on **Azure Kubernetes Service (AKS)**.

It integrates **CI/CD with security (DevSecOps)** to ensure applications are:

* ✅ Secure  
* ✅ Scalable  
* ✅ Reliable  
* ✅ Production-ready  

---

## 🎯 Objectives

* Automate build, test, and deployment process  
* Implement **DevSecOps (Security at every stage)**  
* Ensure high-quality, vulnerability-free code  
* Deploy containerized applications to AKS  
* Achieve scalable and resilient architecture  

---

## 🧠 What This Project Does

This pipeline:

1. Detects code changes via Git push  
2. Triggers Jenkins pipeline automatically  
3. Performs **SAST (SonarQube)** for code quality  
4. Performs **SCA (Snyk)** for dependency vulnerabilities  
5. Builds Node.js application using npm  
6. Creates Docker image  
7. Scans image using **Trivy**  
8. Pushes image to Azure Container Registry (ACR)  
9. Deploys application to AKS using Helm  
10. Verify the APP  

---

## 🏗️ Architecture Flow

<p align="center">
  <img src="./images/Arch.jpeg" width="900"/>
</p>
