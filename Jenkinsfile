pipeline {
    agent any

    environment { 
        GIT_REPO_URL = 'https://github.com/enreap/Sample-web-app.git'
        BRANCH_NAME  = 'main'
        VM_USER = "ubuntu"                // SSH username for your VM
        VM_HOST = "54.163.31.126"          // VM IP address
        WEB_DIR = "/var/www/html"       // Web server root directory (Nginx/Apache)
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning code from ${GIT_REPO_URL} (branch: ${BRANCH_NAME})"
                git branch: "${BRANCH_NAME}", url: "${GIT_REPO_URL}"
            }
        }    
        stage('Deploy to VM') {
            steps {
                sshagent(['jenkins-ssh-ubuntu']) {   // replace with your credential ID
                    sh """
                        scp -o StrictHostKeyChecking=no -r * ${VM_USER}@${VM_HOST}:${WEB_DIR}

                        ssh -o StrictHostKeyChecking=no ${VM_USER}@${VM_HOST} 'sudo systemctl restart nginx || sudo systemctl restart apache2'
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully!"
        }
        failure {
            echo "Deployment failed. Check logs."
        }
    }
}
