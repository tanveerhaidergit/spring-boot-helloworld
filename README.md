# Maven Spotify plugin to build a docker image

1. build the spring boot jar file

mvn clean package

2.Build docker image . The docker configuration steps are mentioned in Dockerfile.

docker build -t helloworld .

verify the image created by using following docker command

docker image ls

3. Run the docker image

docker container run -p 5080:8080 helloworld

or run it in detached mode

docker run -d -p 5080:8080 --name helloworld-container  helloworld

4 . Check container logs 

you can check log file of the container by using command

docker container logs 50ad03a0acfb i.d id of container created

we can even name the container 

docker container run --name helloworld-container  -d -p 5080:8080 helloworld

docker container logs helloworld-container

5. Push the docker image to docker hub

	a. Login with docker id
		Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
		
		
		to avoid prompt use the following command
		docker login -utanveerhaider -p <>
		
	b. Tag the image
	
	To push a local image to docker registry, you need to associate the local image with a repository on the docker registry. 
	The notation for the repository on docker registry is username/repository:tag.

	To tag an image, we use the docker tag command -

	$ docker tag image username/repository:tag
	
	$ docker tag helloworld tanveerhaider/helloworld:0.0.2
	
    c. Push the image to docker hub
	
	docker push tanveerhaider/helloworld:0.0.2

6. Pulling the image from docker hub and running it  (Delete the local images docker rmi -f <imageId>)

	
docker container run --name helloworld-container  -d -p 5080:8080 tanveerhaider/helloworld:0.0.2

7. All the above steps can be automated using spotify plugin. Add the following in pom.xml

<plugin>
				<groupId>com.spotify</groupId>
				<artifactId>dockerfile-maven-plugin</artifactId>
				<version>1.4.9</version>
				<configuration>
					replace `tanveerhaider` with your docker id
					<repository>tanveerhaider/helloworld:0.0.2-SNAPSHOT</repository>
					<tag>${project.version}</tag>
					<buildArgs>
						<JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
					</buildArgs><serverId>docker-hub</serverId>
					<registryUrl>https://index.docker.io/v1/</registryUrl>
					
				</configuration>
				<executions>
					<execution>
						<id>default</id>
						<phase>install</phase>
						<goals>
							<goal>build</goal>
							<goal>push</goal>
						</goals>
					</execution>
				</executions>
			</plugin>
 

		






