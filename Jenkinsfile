pipeline {
    agent any

    environment {
        SVC_ACCOUNT_KEY = credentials('TERRAFORM-AUTHE')
    }

    stages {

        stage('Set Terraform path') {
            steps {
                script {
                    // Use the tool directive to set up the Terraform path
                    def tfHome = tool name: 'Terraform'
                }
                sh 'pwd'
                sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./terraform.json'
                sh 'terraform --version'  // Verifies that terraform is available in the PATH
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Action') {
            steps {
                sh 'terraform ${ACTION} --auto-approve'
            }
        }
    }
}
