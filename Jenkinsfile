pipeline {
    agent any

    environment {
        VM_USER = "ubuntu"                // SSH username for your VM
        VM_HOST = "54.163.31.126"          // VM IP address
        WEB_DIR = "/var/www/html"       // Web server root directory (Nginx/Apache)
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull the latest code from GitHub
                git branch: 'main', url: 'https://github.com/yourusername/sample-web-app.git'
            }
        }

        stage('Deploy to VM') {
            steps {
                // Copy static files to the web server directory
                sh """
                scp -r * ${VM_USER}@${VM_HOST}:${WEB_DIR}
                """

                // Restart the web server so changes take effect
                sh """
                ssh ${VM_USER}@${VM_HOST} 'sudo systemctl restart nginx || sudo systemctl restart apache2'
                """
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
