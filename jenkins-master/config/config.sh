sleep 30

java -jar /jenkins_config/jenkins-cli.jar -s http://localhost:8080/ groovy /jenkins_config/convert_key.groovy > encrypted_key
export encrypted_key=$(cat encrypted_key)
sed -i 's/$PRIVATE_KEY/'$encrypted_key'/' /jenkins_config/jenkins.yaml

java -jar /jenkins_config/jenkins-cli.jar -s http://localhost:8080/ apply-configuration < /jenkins_config/jenkins.yaml
java -jar /jenkins_config/jenkins-cli.jar -s http://localhost:8080/ create-job __jobs-pipeline__ < /jenkins_config/jobs-pipeline.xml
ssh -T git@bitbucket.org

tail -f /dev/null