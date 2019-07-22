This repo serves as a template for Python Dockers which exit after the execution of a python script. 

# 1. Create Docker Image

First we have to create a Docker-image. For this we will need to have a look at how to structure our Dockerfile. 
As in our case we wanted to run a Python-Procedure we used an image with preinstalled anaconda/miniconda of continuum. 
Furthermore we need to copy the following files to our docker-container. Have a look at the Dockerfile to see how its done

In the Dockerfile we create a new conda environment and install all its packages defined in the environment.yml in it.
On Entry we start the run.py script. The Docker container will exit after Python script was executed and you will 
be back at your command line 

Lastly, build and test your docker container locally with the following commands

    SERVICE_NAME=my_service
    IMAGE_TAG="latest"
    
    docker build -t ${SERVICE_NAME}:${IMAGE_TAG} .
    docker run -e ENVIRONMENT=local_docker \
               --network="host"\
               -it -t ${SERVICE_NAME}:${IMAGE_TAG} 

which are executing the following script (run.py) with output: 

    >>> Docker works in local_docker.
    
The --network flag is here not needed  but if you would like to know how you can use your hosting machines connections, 
this is how its done.


# Automated testing and deployment of data science scripts
https://github.com/bats-core/bats-core#file-descriptor-3-read-this-if-bats-hangs

So for automation, what we do is basically the following:
 
We create a bitbucket-pipelines.yml file in the data-scientists repo in which we define and build up a docker container. 
The pipeline also installs bats, a library for bash testing. We have written tests, which run the docker container with different 
input and check its output and exit codes. With that we can also test if the python-scripts of the data-scientists are
executed successfully and check the output with something we would expect. If the tests ran all successfully we can push our 
docker image to ECR such that it we be used by all tasks which are build in the future. Soo cool!