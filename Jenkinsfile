pipeline {
  agent any
  tools { 
        maven 'Maven'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
      withSonarQubeEnv('sonarQube') {
    sh 'mvn clean test sonar:sonar package'
      nexusPublisher nexusInstanceId: '2123', nexusRepositoryId: 'maven_spring_boot', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/project.spring.boot/spring_boot_project/target/spring-boot-aop-0.0.1-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'spring-boot-aop', groupId: 'com', packaging: 'jar', version: '0.0.1']]]
}
      // sh 'mvn -B -DskipTests clean package'
             }
    }
    stage('CreateInstance') {
      steps {
        node('Ansible'){
         checkout scm
         ansiblePlaybook playbook: '$WORKSPACE/createInstance.yaml'
      }
      }}
    stage('DeployArtifact') {
      steps {
        node('Ansible'){
          withMaven(maven: 'Maven') {
          sh 'mvn clean package -DskipTests'
          }
       ansiblePlaybook become: true, colorized: true, credentialsId: 'ANSID', disableHostKeyChecking: true, inventory: '/tmp/hosts_dev', playbook: 'deployArtifact.yaml'
        
        }}
   }

  }
}
