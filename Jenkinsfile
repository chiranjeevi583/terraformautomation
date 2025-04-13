pipeline {
    agent any

    environment {
        TF_VAR_project = 'gcp-dev-practice'
        TF_VAR_region  = 'us-central1'
        TF_VAR_zone    = 'us-central1-c'
    }

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action')
    }

    tools {
        terraform 'Terraform' // make sure this name matches exactly what you configured in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Set Terraform Path') {
            steps {
                script {
                    tfHome = tool name: 'Terraform'
                }
            }
        }

        stage('Terraform Version') {
            steps {
                sh """
                    export PATH=${tfHome}:\$PATH
                    terraform --version
                """
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh """
                    export PATH=${tfHome}:\$PATH
                    terraform init
                """
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                    export PATH=${tfHome}:\$PATH
                    terraform plan
                """
            }
        }

        stage('Terraform Action') {
            steps {
                sh """
                    export PATH=${tfHome}:\$PATH
                    terraform ${params.ACTION} -auto-approve
                """
            }
        }
    }
}
