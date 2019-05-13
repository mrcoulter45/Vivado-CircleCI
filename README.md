Vivado 2018.3 tar download:
https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz

Install Docker:
// install steps at https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

// Should receive:
//  pub   rsa4096 2017-02-22 [SCEA]
//        9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
//  uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
//  sub   rsa4096 2017-02-22 [S]

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
// verify docker installed
sudo docker run hello-world
// Should print:
// Hello from Docker!
// This message shows that your installation appears to be working correctly.
//
// To generate this message, Docker took the following steps:
//  1. The Docker client contacted the Docker daemon.
//  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
//     (amd64)
//  3. The Docker daemon created a new container from that image which runs the
//     executable that produces the output you are currently reading.
//  4. The Docker daemon streamed that output to the Docker client, which sent it
//     to your terminal.
//
// To try something more ambitious, you can run an Ubuntu container with:
//  $ docker run -it ubuntu bash
//
// Share images, automate workflows, and more with a free Docker ID:
//  https://hub.docker.com/
//
// For more examples and ideas, visit:
//  https://docs.docker.com/get-started/

List all running/ran containers/images:
sudo docker ps -a

List Docker images on system:
sudo docker image list

Run vivado image in a container:
sudo docker run -it vivado

Docker folder location:
/var/lib/docker

Remove any stopped containers and all unused images (not just dangling images):
docker system prune -a

Delete all containers:
sudo docker container stop $(sudo docker container ps -aq)
sudo docker container rm $(sudo docker container ps -aq)
if error:
Error response from daemon: cannot stop container: bf4706e9d507: Cannot kill container bf4706e9d507c82a62d501ff79c5c7a1fa3c9de910dd7cb5393d05ab5a478276: unknown error after kill: runc did not terminate sucessfully: container_linux.go:388: signaling init process caused "permission denied"
: unknown
run:
sudo systemctl disable apparmor.service --now
sudo service apparmor teardown
sudo docker container stop $(sudo docker container ps -aq)
sudo docker container rm $(sudo docker container ps -aq)

Delete Docker image:
sudo docker image rm <IMAGE ID>
If you get an error similar to the following, it means that the image is used by an existing container. To remove the image you will have to remove the container first.
Error response from daemon: conflict: unable to remove repository reference "centos" (must force) - container cd20b396a061 is using its referenced image 75835a67d134

If the container is already stopped and you still want to access the files from it:
sudo docker cp <container_name>:/foo /tmp/foo. This will copy /foo from your container into /tmp/foo from your host (must be path from root '/', not home '\~')
Eg. sudo docker cp gallant_leakey:/home/vivado/ci-test-shield-fpga files

# Restart exited container
sudo docker start -ai <container_name>

To create new image based off of already existing container:
sudo docker commit <container_id> mrcoulter45/vivado-ci

To push image to Docker Hub:
sudo docker login
sudo docker push mrcoulter45/vivado-ci
