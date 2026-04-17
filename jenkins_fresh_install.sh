#!/bin/bash

set -e

echo "======================================"
echo "🚀 Jenkins Fresh Installation"
echo "======================================"

# Update system
echo "🔄 Updating system..."
sudo apt update -y

# Install Java 21 (Required for latest Jenkins)
echo "☕ Installing Java 21..."
sudo apt install -y openjdk-21-jdk

# Install required packages
echo "📦 Installing dependencies..."
sudo apt install -y curl gnupg ca-certificates

# Add Jenkins repository (trusted workaround)
echo "📦 Adding Jenkins repository..."
echo "deb [trusted=yes] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update packages
sudo apt update -y

# Install Jenkins
echo "📥 Installing Jenkins..."
sudo apt install -y jenkins

# Set JAVA_HOME
echo "⚙️ Setting JAVA_HOME..."
JAVA_PATH=$(readlink -f $(which java) | sed "s:/bin/java::")
echo "JAVA_HOME=$JAVA_PATH" | sudo tee -a /etc/default/jenkins > /dev/null

# Start Jenkins service
echo "🚀 Starting Jenkins..."
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Open port 8080 (optional)
sudo ufw allow 8080 2>/dev/null || true

# Wait for Jenkins to initialize
sleep 10

echo ""
echo "======================================"
echo "📊 Jenkins Status"
echo "======================================"
sudo systemctl status jenkins --no-pager

echo ""
echo "🔐 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo ""
echo "======================================"
echo "✅ Jenkins Installed Successfully!"
echo "======================================"
echo "👉 Access: http://<your-ec2-ip>:8080"