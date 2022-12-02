## Übung D1: Docker &nbsp; (<span style="color:red">16 Pts + 6 Extra Pts</span>)
This assignment will setup Docker and demonstrate basic use.
If you already have Docker, you can use that configuration.

---

### Challenges
1. [Challenge 1:](#1-challenge-1) Docker Setup and CLI - (4 Pts)
2. [Challenge 2:](#2-challenge-2) Run hello-world container - (3 Pts)
3. [Challenge 3:](#3-challenge-3) Run minimal Alpine container - (3 Pts)
4. [Challenge 4:](#4-challenge-4) Containerize Java application - (6 Pts)
5. [Challenge 5:](#5-challenge-5) Configure Alpine container for ssh access - (6 Extra Pts)


&nbsp;

---
### 1.) Challenge 1
Install Docker. Open a terminal and type commands:
```
> docker --version
Docker version 20.10.17, build 100c701
> docker --help
...
> docker ps                 ; dockerd is not running
error during connect: This error may indicate that the docker daemon is not runn
ing.

> docker ps                 ; dockerd is now running, no containers yet
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
If you can't run the `docker` command, the client-side *docker-CLI* (Command-Line-Interface)
may not be installed or is not on the PATH. If `docker ps` says: "can't connect",
the *Docker engine* (server-side: *dockerd* ) is not running and must be started.

(4 Pts)


&nbsp;

---
### 2.) Challenge 2
Run the *hello-world* container from Docker-Hub:
[hello-world](https://hub.docker.com/_/hello-world):

```sh
> docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:62af9efd515a25f84961b70f973a798d2eca956b1b2b026d0a4a63a3b0b6a3f2
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Show the container image loaded on your system:
```sh
> docker image ls
REPOSITORY       TAG           IMAGE ID       CREATED         SIZE
hello-world      latest        feb5d9fea6a5   12 months ago   13.3kB
```

Show that the container is still present after the end of execution:
```sh
> docker ps -a
CONTAINER ID  IMAGE        COMMAND   CREATED    STATUS     PORTS   NAMES
da16000022e0  hello-world  "/hello"  6 min ago  Exited(0)  magical_aryabhata
```

Re-start the container with an attached (-a) *stdout* terminal.
Refer to the container either by its ID (here: *da16000022e0* ) or by its
generated NAME (here: *magical_aryabhata* ).
```sh
> docker start da16000022e0 -a          or: docker start magical_aryabhata -a
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Re-run will create a new container and execut it. `docker ps -a ` will then
show two containers created from the same image.
```sh
> docker run hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

> docker ps -a
CONTAINER ID  IMAGE        COMMAND   CREATED    STATUS     PORTS   NAMES
da16000022e0  hello-world  "/hello"  6 min ago  Exited(0)  magical_aryabhata
40e605d9b027  hello-world  "/hello"  4 sec ago  Exited(0)  pedantic_rubin
```
"Run" always creates new containers while "start" restarts existing containers.

(3 Pts)


&nbsp;

---
### 3.) Challenge 3
[Alpine](https://www.alpinelinux.org) is a minimal base image that has become
popular for building lean containers (few MB as opposed to 100's of MB or GB's).
Being mindful of resources is important for container deployments in cloud
environments where large numbers of containers are deployed and resource use
is billed.

Pull the latest Alpine image from Docker-Hub (no container is created with just
pulling the image). Mind image sizes: hello-world (13.3kB), alpine (5.54MB).
```sh
> docker pull alpine:latest
docker pull alpine:latest
latest: Pulling from library/alpine
Digest: sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad
Status: Image is up to date for alpine:latest
docker.io/library/alpine:latest

> docker image ls
REPOSITORY       TAG           IMAGE ID       CREATED         SIZE
hello-world      latest        feb5d9fea6a5   12 months ago   13.3kB
alpine           latest        9c6f07244728   8 weeks ago     5.54MB
```

Create and run an Alpine container executing an interactive shell `/bin/sh` attached to the terminal ( `-it` ). It launches the shell that runs commands inside the Alpine
container.

**GitBash:**
if error: *OCI runtime exec failed: exec failed: unable to start container
process: exec: ... no such file or directory* occurs, use:
`//bin//sh` instead of `/bin/sh`.

```sh
> docker run -it alpine:latest /bin/sh
# ls -la
total 64
drwxr-xr-x    1 root     root          4096 Oct  5 18:32 .
drwxr-xr-x    1 root     root          4096 Oct  5 18:32 ..
-rwxr-xr-x    1 root     root             0 Oct  5 18:32 .dockerenv
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 bin
drwxr-xr-x    5 root     root           360 Oct  5 18:32 dev
drwxr-xr-x    1 root     root          4096 Oct  5 18:32 etc
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 home
drwxr-xr-x    7 root     root          4096 Aug  9 08:47 lib
drwxr-xr-x    5 root     root          4096 Aug  9 08:47 media
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 mnt
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 opt
dr-xr-xr-x  179 root     root             0 Oct  5 18:32 proc
drwx------    1 root     root          4096 Oct  5 18:36 root
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 run
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 sbin
drwxr-xr-x    2 root     root          4096 Aug  9 08:47 srv
dr-xr-xr-x   13 root     root             0 Oct  5 18:32 sys
drwxrwxrwt    2 root     root          4096 Aug  9 08:47 tmp
drwxr-xr-x    7 root     root          4096 Aug  9 08:47 usr
drwxr-xr-x   12 root     root          4096 Aug  9 08:47 var

# whoami
root

# uname -a
Linux aab69035680f 5.10.124-linuxkit #1 SMP Thu Jun 30 08:19:10 UTC 2022 x86_64

# exit
```

Commands after the `#` prompt (*root* prompt) are executed by the `/bin/sh` shell
inside the container. 

`# exit` ends the shell process and returns to the surrounding shell. The container
will go into a dormant (inactive) state.
```sh
> docker ps -a
CONTAINER ID  IMAGE         COMMAND   CREATED    STATUS     PORTS   NAMES
aab69035680f  alpine:latest "/bin/sh" 9 min ago  Exited     boring_ramanujan
```

The container can be restarted with any number of `/bin/sh` shell processes.

Containers are executed by **process groups** - so-called
[cgroups](https://en.wikipedia.org/wiki/Cgroups) used by
[LXC](https://wiki.gentoo.org/wiki/LXC) -
that share the same environment (filesystem view, ports, etc.), but are isolated
from process groups of other containers.

Start a shell process in the dormant Alpine-container to re-activate.
The start command will execute the default command that is built into the container
(see the COMMAND column: `"/bin/sh"`). The option `-ai` attaches *stdout* and *stdin*
of the terminal to the container.

Write *"Hello, container"* into a file: `/tmp/hello.txt`. Don't leave the shell.
```sh
> docker start aab69035680f -ai
# echo "Hello, container!" > /tmp/hello.txt
# cat /tmp/hello.txt
Hello, container!
#
```

Start another shell in another terminal for the container. Since it refers to the same
container, both shell processes share the same filesystem.
The second shell can therefore see the file created by the first and append another
line, which again will be seen by the first shell.
```sh
> docker start aab69035680f -ai
# cat /tmp/hello.txt
Hello, container!
# echo "How are you?" >> /tmp/hello.txt
```

First terminal:

```sh
# cat /tmp/hello.txt
Hello, container!
How are you?
#
```

In order to perform other commands than the default command in a running container,
use `docker exec`.

Execute command: `cat /tmp/hello.txt` in a third terminal:
```sh
docker exec aab69035680f cat /tmp/hello.txt
Hello, container!
How are you?
```

The execuition creates a new process that runs in the container seeing its filesystem
and other resources.

Explain the next command:
- What is the result?
- How many processes are involved?
- Draw a skech with the container, processes and their stdin/-out connections.

```sh
echo "echo That\'s great to hear! >> /tmp/hello.txt" | \
        docker exec -i aab69035680f /bin/sh
```

When all processes have exited, the container will return to the dormant state.
It will preserve the created file.

(3 Pts)


&nbsp;

---
### 4.) Challenge 4
We use the Java application from
[Übung A1](https://lms.bht-berlin.de/mod/assign/view.php?id=966552) 
(project: "setup.se2"):

```perl
# run application
java --class-path target application.App 48
Hello, App!
n=48 factorized is: [2, 2, 2, 2, 3]
```

Goal is to package this application as a Docker container.

Create a new project directory: `docker-se2` and copy the Java-project
from Übung A1 inside. You find other files (`Dockerfile`, `Manifest.mf`, ... )
on this page above.

Create this structure for project: `docker-se2`:
```
--<docker-se2>:     <-- new container-build project
 |
 +--Dockerfile
 +--Manifest.mf
 +-- ...
 |
 +--<setup-se2>:    <-- copied from Übung A1
 |    |
 |    +--Manifest.mf    <- copy from ../
 |    +--src
 |    |   +--application
 |    |        +--App.java
 |    |
 |    +--test
 |    |   +--application
 |    |        +--AppTest.java
 |    |
 |    +--target
 |    |   +--application
 |    |        +--App.class
 |    |        +--AppTest.class
 |    |
 |    +--resources ...
 |    +--lib
 |    |   +--org.junit.jar, org.junit.jupiter.api,
 |    |      org.opentest4j, org.apiguardian.jar, ...
```
Make sure to copy the `Manifest.mf` file into "setup.se2".

The following steps will "build" the Java-project `setup-se2` and produce
a packageable `app.jar` file with following steps:
1. change directory into "setup.se2"
1. compile: `App.java` -> target/application/App.class
1. set variable `JUNIT_CLASSPATH` for compiling unit tests
1. compile: `AppTest.java` -> target/application/AppTest.class
1. perform JUnit tests
1. package project into `app.jar`
1. copy `app.jar` one level up to `docker-se2` directory for containerization.

It is important that code must be compiled for the Java-version
that is available in the container as deployment environment,
which will be Java-11.

The Java compiler must therefore be called with Java source and target
version flags vor Java 11:

    javac -source 11 -target 11 ...

```perl
# change directory into "setup.se2"
> cd setup.se2

# compile: `App.java` -> target/application/App.class
> javac -source 11 -target 11 src/application/App.java -d target

# set variable JUNIT_CLASSPATH
# Mac/Linux: use ':' as path separator, not ';' (Windows)
> JUNIT_CLASSPATH="./lib/org.junit.jupiter.api.jar;\
./lib/org.apiguardian.jar;\
./lib/org.junit.platform.commons.jar;\
./lib/org.junit.jar;\
./lib/org.opentest4j.jar"

# show value of JUNIT_CLASSPATH variable
> echo $JUNIT_CLASSPATH
./lib/org.junit.jupiter.api.jar;./lib/org.apiguardian.jar;./lib/org.junit.platform.commons.jar;./lib/org.junit.jar;./lib/org.opentest4j.jar

# use JUNIT_CLASSPATH to compile JUnit test class
> javac -source 11 -target 11 test/application/AppTest.java -d target/ -cp "target;$JUNIT_CLASSPATH"

# show results
> find target
target/
target/application
target/application/App.class
target/application/AppTest.class

# run application
> java --class-path target application.App 48
Hello, App!
n=48 factorized is: [2, 2, 2, 2, 3]
```

Run JUnit Tests. It is common practize to only package and deploy
software that passes unit tests.

```perl
# run JUnit tests
> java -jar lib/junit-platform-console-standalone-1.9.1.jar \
    --class-path target --scan-class-path

# alternatively, run JUnit tests using opt-file
> java @resources/junit-options.opt --scan-class-path
```

Output:
```
+-- JUnit Jupiter [OK]
| '-- AppTest [OK]
|   +-- test0003_FactorizeExceptionCases() [OK]
|   +-- test0001_FactorizeRegularCases() [OK]
|   '-- test0002_FactorizeCornerCases() [OK]
+-- JUnit Vintage [OK]
'-- JUnit Platform Suite [OK]

Test run finished after 164 ms
[         4 containers found      ]
[         0 containers skipped    ]
[         4 containers started    ]
[         0 containers aborted    ]
[         4 containers successful ]
[         0 containers failed     ]
[         3 tests found           ]
[         0 tests skipped         ]
[         3 tests started         ]
[         0 tests aborted         ]
[         3 tests successful      ]
[         0 tests failed          ]
```

When all tests pass, the final step is to package the application into `app.jar`.

```perl
# create app.jar file and add App.class and AppTest.class
> jar cfm app.jar Manifest.mf -C target application/App.class
> jar uf app.jar -C target application/AppTest.class

# show app.jar
> ls -la
-rwxr-xr-x  1 svgr2 Kein 1556 Nov 21 21:44 app.jar*

# look inside
> jar tvf app.jar
     0 Mon Nov 21 21:44:32 CET 2022 META-INF/
    91 Mon Nov 21 21:44:32 CET 2022 META-INF/MANIFEST.MF
  1781 Mon Nov 21 21:23:12 CET 2022 application/App.class
  2992 Mon Nov 21 21:26:38 CET 2022 application/AppTest.class

# show MANIFEST.MF that defines the Main-Class as entry point
> cat manifest.mf
Manifest-Version: 1.0
Created-By: 11 (Oracle Corporation)
Main-Class: application.App

# run jar file
> java -jar app.jar 100
Hello, App!
n=100 factorized is: [2, 2, 5, 5]

# copy app.jar one level up to docker project
> cp app.jar ..

# cd one level up to docker project
> cd ..
```

The container housing the Java application (`app.jar`) is built from a
base image
[adoptopenjdk/openjdk11:alpine](https://hub.docker.com/r/adoptopenjdk/openjdk11)
that contains:
- the minimal Alpine Unix environment,
- the `Java-11 JDK`, which includes the run-time environment
  to execute Java and also tools such as `javac`, `jar` etc.

`Dockerfile` describes the additions to include in the new container:
- the Java application (`app.jar`).

Mac's with M1 Chip need to specify `--platform=linux/amd64` in `FROM`,
see Dockerfile below or:
*"Choosing the right Docker Image for your Apple M1 Pro"*,
[link](https://collabnix.com/choosing-the-right-docker-image-for-your-apple-m1-pro).

```py
# base image, https://hub.docker.com/r/adoptopenjdk/openjdk11
# Mac with M1-Chip use: FROM --platform=linux/amd64 adoptopenjdk/openjdk11:alpine
FROM adoptopenjdk/openjdk11:alpine

# create a new directory in the container: /opt/app
RUN mkdir /opt/app

# copy 'app.jar' from the project directory into: /opt/app
COPY app.jar /opt/app

# define a command that executes when the container started
CMD ["java", "-jar", "/opt/app/app.jar"]
```

The lifecycle of building and executing a Docker container has the
following steps:
1. Build new container *image* from a referenced image: `docker build` using `Dockerfile`.
1. Create container from new image: `docker run`, which also starts the container.
1. Start container: `docker start`.
1. Stop container: `docker stop`.
1. Cleaning up containers and images: `docker rm, rmi`.

`docker run` always creates new container instances and should only be
performed once. Later, `docker start` and `docker stop` can be used to
start and stop containers.

&nbsp;

**Step 1:**

Build new container *image* named `"openjdk11/app.jar_img"` using `Dockerfile`.
```py
# build new image using Dockerfile at '.'
> docker build -t "openjdk11/app.jar_img" --no-cache .
```

Output:

```
[+] Building 2.4s (9/9) FINISHED
 => [internal] load build definition from Dockerfile                       0.0s
 => => transferring dockerfile: 32B                                        0.0s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [internal] load metadata for docker.io/adoptopenjdk/openjdk11:alpine   1.5s
 => [auth] adoptopenjdk/openjdk11:pull token for registry-1.docker.io      0.0s
 => CACHED [1/3] FROM docker.io/adoptopenjdk/openjdk11:alpine@sha256:1977  0.0s
 => [internal] load build context                                          0.1s
 => => transferring context: 3.04kB                                        0.0s
 => [2/3] RUN mkdir /opt/app                                               0.3s
 => [3/3] COPY app.jar /opt/app                                            0.1s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.1s
 => => writing image sha256:9daa8d160b6705b43da15b401a79069ad67e3d615a96e  0.0s
 => => naming to docker.io/openjdk11/app.jar_img                           0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and l
earn how to fix them
```

Show new container image:

```perl
# show docker images
> docker images
```

Output:

```
REPOSITORY               TAG       IMAGE ID       CREATED          SIZE
openjdk11/app.jar_img    latest    9daa8d160b67   20 seconds ago   343MB
```

&nbsp;

**Step 2:**

Create container from new image, which also starts the container.

```perl
# create container from new image
> docker run -it --name=java_app_container -d openjdk11/app.jar_img
```

Show new container (not running):

```perl
# show new container
> docker ps -a
```

Output:

```
CONTAINER ID  IMAGE                  COMMAND                       STATUS      NAMES
8efa2c6a84a6  openjdk11/app.jar_img  "java -jar /opt/app/app.jar"  Exited (0)  java_app_container
```

&nbsp;

**Steps 3 + 4:**

Start the container. Since the container only runs the Java application,
it exits immediately after execution and does not need to be stopped.

The `-ai` option attaches the terminal for stdin/stdout to see output.

```py
# start container with -ai attached terminal for output
> docker start -ai java_app_container
```

Output:

```
Hello, App!
n=36 factorized is: [2, 2, 3, 3]
```

Attach an interactive shell to the container to explore what is inside
(we actually create another container instance with `docker run` that gets
removed after exit with `--rm`):

```perl
# attach shell to the container
> docker run --rm -it openjdk11/app.jar_img /bin/sh
```

Dialog inside the container created from the `openjdk11/app.jar_img` image,
which contains Java-JDK 11 and also `app.jar` deployed into the container.

The following commands are executed inside the container (as user *root* with
*root* privileges):
```
# java --version
openjdk 11.0.16.1 2022-08-12
OpenJDK Runtime Environment Temurin-11.0.16.1+1 (build 11.0.16.1+1)
OpenJDK 64-Bit Server VM Temurin-11.0.16.1+1 (build 11.0.16.1+1, mixed mode)

# echo $PATH
/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# java --version
openjdk 11.0.16.1 2022-08-12
OpenJDK Runtime Environment Temurin-11.0.16.1+1 (build 11.0.16.1+1)
OpenJDK 64-Bit Server VM Temurin-11.0.16.1+1 (build 11.0.16.1+1, mixed mode)

# ls -la /opt/app
total 16
drwxr-xr-x    1 root     root          4096 Nov 21 22:20 .
drwxr-xr-x    1 root     root          4096 Nov 21 22:20 ..
-rwxr-xr-x    1 root     root          2999 Nov 21 22:18 app.jar

# java -jar /opt/app/app.jar 136
Hello, App!
n=136 factorized is: [2, 2, 2, 17]
```

&nbsp;

**Steps 5:**
Removing containers and images keeps the environment clean.

Any container and any image should be deletable and reconstructable at any time.
Therefore, images and containers can be removed at any time (and reconstructed
when needed).

Removing the container:
```py
> docker rm "java_app_container"
```

Removing the image:
```py
> docker rmi "openjdk11/app.jar_img"
```

To demonstrate the completion of the challenge, delete all images and containers,
rebuild from scratch and run `app.jar` (takes < 10 secs):
```py
# rebuild the image
docker build -t "openjdk11/app.jar_img" --no-cache .

# recreate the container from the image
docker run -it --name=java_app_container -d openjdk11/app.jar_img

# start the container
docker start -ai java_app_container
```

Output:

```
Hello, App!
n=36 factorized is: [2, 2, 3, 3]
```

(6 Pts)


&nbsp;

---
### 5.) Challenge 5
Create a new Alpine container with name `alpine-ssh` and configure it for
[ssh](https://en.wikipedia.org/wiki/Secure_Shell) access.
```sh
docker run --name alpine-ssh -p 22:22 -it alpine:latest
```
Instructions for installation and confiduration can be found here:
["How to install OpenSSH server on Alpine Linux"](https://www.cyberciti.biz/faq/how-to-install-openssh-server-on-alpine-linux-including-docker) or here:
["Setting up a SSH server"](https://wiki.alpinelinux.org/wiki/Setting_up_a_SSH_server).

Add a local user *larry* with *sudo*-rights, install *sshd* listening on the
default port 22.

Write down commands that you used for setup and configuration to enable the
container to run *sshd*.

Verify that *sshd* is running in the container:
```sh
# ps -a
PID   USER     TIME  COMMAND
    1 root      0:00 /bin/sh
  254 root      0:00 sshd: /usr/sbin/sshd [listener] 0 of 10-100 startups
  261 root      0:00 ps -a
```

Show that *ssh* is working by login in as *larry* from another terminal:
```sh
> ssh larry@localhost

Welcome to Alpine!

The Alpine Wiki contains a large amount of how-to guides and general
information about administrating Alpine systems.
See <http://wiki.alpinelinux.org/>.

You can setup the system with the command: setup-alpine

You may change this message by editing /etc/motd.

54486c62d745:~$ whoami
larry

54486c62d745:~$ ls -la
total 32
drwxr-sr-x    1 larry    larry         4096 Oct  2 21:34 .
drwxr-xr-x    1 root     root          4096 Oct  2 20:40 ..
-rw-------    1 larry    larry          602 Oct  5 18:53 .ash_history

54486c62d745:~$ uname -a
Linux 54486c62d745 5.10.124-linuxkit #1 SMP Thu Jun 30 08:19:10 UTC 2022 x86_64 Linux
54486c62d745:~$
```

(6 Extra Pts)
