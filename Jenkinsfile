pipeline {
  agent any
 
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
      stage('Image Build') {
      def Ecr-ecs-image = docker.build("485069714813.dkr.ecr.us-east-1.amazonaws.com/myecrrepo:latest:${env.BUILD_ID}")

        /* Push the container to the custom Registry */
        Ecr-ecs-image.push()
      }
      
      
    }
  }
}
