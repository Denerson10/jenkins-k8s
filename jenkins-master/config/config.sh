sleep 30

java -jar /jenkins_config/jenkins-cli.jar -s http://localhost:8080/ apply-configuration < /jenkins_config/jenkins.yaml
java -jar /jenkins_config/jenkins-cli.jar -s http://localhost:8080/ create-job __jobs-pipeline__ < /jenkins_config/jobs-pipeline.xml

tail -f /dev/null