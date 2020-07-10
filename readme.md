# Docker
 <!-- Output copied to clipboard! -->

<!-----
NEW: Check the "Suppress top comment" option to remove this info from the output.

Conversion time: 0.879 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β29
* Fri Jul 10 2020 05:48:52 GMT-0700 (PDT)
* Source doc: DockerFile Syntax
* Tables are currently converted to HTML tables.
----->


## DockerFile Syntax

Dockerfile syntax consists of two kind of main line blocks



*   Command
*   Command & Arguments

Ex:

RUN echo “Welcome Docker”

## DockerFile Commands


*   FROM
    *   FROM ubuntu  - FROM [image name]
*   RUN 
    *   RUN apt-get install -y update - RUN [command]
*   CMD
    *   CMD “echo” “Welcome Docker”
*   ENTRYPOINT
    *   ENTRYPOINT ./ruh.sh - First command will execute while starting the container. 
*   ADD
    *   ADD ./src /dst - ADD [Source Target]
*   ENV 
    *   ENV SERVER_WORKS 4 - ENV [Env-Key Env-Value ]
*   WORKDIR
    *   WORKDIR ~/ - WORKDIR [Path]
*   EXPOSE
    *   EXPOSE 80 - EXPOSE [Port]
*   MAINTAINER
    *   MAINTAINER author
*   USER
    *   USER 751 - USER [UID]
*   VOLUME
    *   VOLUME [“/shared_dir”]

### COPY vs ADD

Both commands will be used to copy files from a specific location  into a docker image. COPY takes source and destination. It only lets you copy in a local file or directory from your host into the docker image itself. But ADD lets you do that too. And also support 2 other sources. It accepts source as URL instead of file/directory. Secondly you can extract a tar file from the source directory into the destination which is docker image. 

### RUN vs CMD vs ENTRYPOINT

To be added.

## Most Used Docker Commands


<table>
  <tr>
   <td>
<ul>

<li>docker  --version

<li>docker  --help

<li>docker  pull

<li>docker run

<li>docker build

<li>docker login

<li>docker push

<li>docker ps

<li>docker images

<li>docker stop

<li>docker logs
</li>
</ul>
   </td>
   <td>
<ul>

<li>docker kill

<li>docker rm

<li>docker rmi

<li>docker commit

<li>docker exec

<li>docker import

<li>docker export

<li>docker container

<li>docker compose

<li>docker swarm

<li>docker service
</li>
</ul>
   </td>
  </tr>
</table>


## Docker Swarm

Docker native orchestrations tool for managing the docker cluster, node, container, high availability. 

## Docker Swarm Commands



*   docker swarm init
    *   docker swarm init --advertise-addr &lt;ip-of-manager-node>
*   docker join --token &lt;token> &lt;ip-of-manager-node>
*   docker service ls
*   docker service ps &lt;name>
*   docker service create &lt;name> &lt;image-name> 
    *   docker service create --name “my-app” test
        *   --mode global ( all nodes ) 
        *   --mode replicated ( default )
        *   --replicas 5 
*   docker service rm &lt;name>
*   docker service scale &lt;name>=5
*   docker node ls
*   docker node ps
*   docker node rm &lt;id>
*   docker node update --availability drain &lt;manager-node-name>
*   docker node update --availability active &lt;manager-node-name>

## Docker Networking

Docker Networking is a way to connect all containers to each other in a docker environment. 

## Network Drivers


*   Bridge ( default )
*   Host
*   None
*   Overlay
*   Macvlan

References
