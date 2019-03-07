pipeline {
agent any
stages {
stage('Clone repository') {
/* Let's make sure we have the repository cloned to our workspace... */
steps {
checkout scm
}
}
stage('Build docker image') {
steps {
withDockerRegistry(credentialsId: 'ecr:us-east-1:AWS_ECR-ID', url: 'http://485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootrepo') {
//docker.build('485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootapplication:latest')
buildImage name: 'spring:latest', path: '.'
// tagImage name: 'spring:latest', tag: '485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootapplcation:latest'
sh "docker tag spring:latest 485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootrepo:latest"
}
}
}
stage('publish docker image to ecr') {
steps {
withDockerRegistry(credentialsId: 'ecr:us-east-1:AWS_ECR-ID', url: 'http://485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootrepo') {
// docker.image('485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootapplication:latest').push(latest)
// pushImage name: '485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootapplcation', tag: 'latest'
sh "docker push 485069714813.dkr.ecr.us-east-1.amazonaws.com/springbootrepo:latest"
}
}
}
stage('creating task definition and task for springboot cluster'){
steps{
ansiblePlaybook become: true, playbook: 'ecs.yaml'
}
}
}
}
