#!/bin/sudo bash

# Define VM IPs
master_ip="54.88.178.250"
slave_ip="3.90.26.121"
sonarqube_ip="18.206.236.239"
dev_vm_ip="34.229.148.106"

# Define PEM key file path
PEM_KEY_PATH="/home/venkat/pem/test.pem"

# Jenkins_Master
echo "Copying and executing scripts on Jenkins Master..."
scp -i "$PEM_KEY_PATH" mastersoftware.sh ubuntu@"${master_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" rm_master_software.sh ubuntu@"${master_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" aws_config.json ubuntu@"${master_ip}":/home/ubuntu/

# Set permissions and execute scripts on Jenkins Master
ssh -i "$PEM_KEY_PATH" ubuntu@"${master_ip}" 'sudo chmod +x /home/ubuntu/mastersoftware.sh /home/ubuntu/rm_master_software.sh && sudo bash /home/ubuntu/mastersoftware.sh'
# ssh -i "$PEM_KEY_PATH" ubuntu@"${master_ip}" 'sudo bash /home/ubuntu/rm_master_software.sh'
# Change hostname of the master VM
ssh -i "$PEM_KEY_PATH" ubuntu@"${master_ip}" 'sudo hostnamectl set-hostname jenkins-master'
ssh -i "$PEM_KEY_PATH" ubuntu@"${master_ip}" 'hostname'
ssh -i "$PEM_KEY_PATH" ubuntu@"${master_ip}" 'hostname -f'

# Jenkins_Slave
echo "Copying and executing scripts on Jenkins Slave..."
scp -i "$PEM_KEY_PATH" slavesoftware.sh ubuntu@"${slave_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" slave_rm_software.sh ubuntu@"${slave_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" aws_config.json ubuntu@"${slave_ip}":/home/ubuntu/

# Set permissions and execute scripts on Jenkins Slave
ssh -i "$PEM_KEY_PATH" ubuntu@"${slave_ip}" 'sudo chmod +x /home/ubuntu/slavesoftware.sh /home/ubuntu/slave_rm_software.sh && sudo bash /home/ubuntu/slavesoftware.sh'
# ssh -i "$PEM_KEY_PATH" ubuntu@"${slave_ip}" 'sudo bash /home/ubuntu/slave_rm_software.sh'
# Change hostname of the Slave VM
ssh -i "$PEM_KEY_PATH" ubuntu@"${slave_ip}" 'sudo hostnamectl set-hostname jenkins-slave'
ssh -i "$PEM_KEY_PATH" ubuntu@"${slave_ip}" 'hostname'
ssh -i "$PEM_KEY_PATH" ubuntu@"${slave_ip}" 'hostname -f'

# Sonarqube_server
echo "Copying and executing scripts on SonarQube Server..."
scp -i "$PEM_KEY_PATH" sonarqube-server-software.sh ubuntu@"${sonarqube_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" sonar_rm_software.sh ubuntu@"${sonarqube_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" aws_config.json ubuntu@"${sonarqube_ip}":/home/ubuntu/

# Set permissions and execute scripts on SonarQube Server
ssh -i "$PEM_KEY_PATH" ubuntu@"${sonarqube_ip}" 'sudo chmod +x /home/ubuntu/sonarqube-server-software.sh /home/ubuntu/sonar_rm_software.sh && sudo bash /home/ubuntu/sonarqube-server-software.sh'
# ssh -i "$PEM_KEY_PATH" ubuntu@"${sonarqube_ip}"  'sudo bash /home/ubuntu/sonar_rm_software.sh'
# Change hostname of the Sonarqube server
ssh -i "$PEM_KEY_PATH" ubuntu@"${sonarqube_ip}" 'sudo hostnamectl set-hostname sonarqube'
ssh -i "$PEM_KEY_PATH" ubuntu@"${sonarqube_ip}" 'hostname'
ssh -i "$PEM_KEY_PATH" ubuntu@"${sonarqube_ip}" 'hostname -f'

# Dev_server
echo "Copying and executing scripts on Dev VM..."
scp -i "$PEM_KEY_PATH" dev_vm_software.sh ubuntu@"${dev_vm_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" rm_dev_software.sh ubuntu@"${dev_vm_ip}":/home/ubuntu/
scp -i "$PEM_KEY_PATH" aws_config.json ubuntu@"${dev_vm_ip}":/home/ubuntu/

# Set permissions and execute scripts on Dev VM
ssh -i "$PEM_KEY_PATH" ubuntu@"${dev_vm_ip}" 'sudo chmod +x /home/ubuntu/dev_vm_software.sh /home/ubuntu/rm_dev_software.sh && sudo bash /home/ubuntu/dev_vm_software.sh'
# ssh -i "$PEM_KEY_PATH" ubuntu@"${dev_vm_ip}" 'sudo bash /home/ubuntu/rm_dev_software.sh'
# Change hostname of the Dev server
ssh -i "$PEM_KEY_PATH" ubuntu@"${dev_vm_ip}" 'sudo hostnamectl set-hostname develope'
ssh -i "$PEM_KEY_PATH" ubuntu@"${dev_vm_ip}" 'hostname'
ssh -i "$PEM_KEY_PATH" ubuntu@"${dev_vm_ip}" 'hostname -f'

# Final message
echo "Scripts executed successfully on all VMs."
