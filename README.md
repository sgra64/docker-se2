### Software Engineering 2
## 4 Prozesse und Werkzeuge,

## Docker Container 

---

[Docker](https://docs.docker.com) is a popular software packaging, distribution and execution infrastructure using containers ([Overview](https://docs.docker.com/get-started/overview)):

- Docker runs on Linux only (LXC). MacOS and Windows have developed adapter technologies.

- Windows uses an internal Linux VM to run the Docker engine (or the Docker daemon
    process: *dockerd* ).

- Client tools (CLI, GUI, e.g. [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)) are used to create, manage and execute containers.

Introduction of Docker: *Salomon Hykes* at PyCon 2013, Santa Clara CA: *"The Future of Linux Containers"* ([video](https://www.youtube.com/watch?v=9xciauwbsuo), 5:21min).


Docker builds on Linux technologies:

- Stackable layers of filesystem images that each contain only the changes
  to an underlying image.

- Tools to build, manage and distribute images ("ship container" metaphore).

- Linux LXC or similar technology is used to "run containers" as
  groups of isolated processes on a Linux system.

---

Docker core concepts:
- **Image** - compound of stacked images (image layers) starting with a base image that yields
  a final filesystem impression visible inside a container. Each image layer can be created
  and distributed independently.

- **Registry** - local or global repository to share Docker images, e.g. [Docker Hub](https://hub.docker.com).

- **Container** - Information (state) comprised of:
  - id, name,
  - Dockerfile with reference to base image,
  - entry point, arguments, environment variables,
  - ports, mounted volumes, etc.

- **Running Container instance** - Process group executing on the state of a Container.
  Process groups of one container are fully isolated from state of other containers
  and the state of the host system.

- **Orchestration** of Container instances (docker-compose) - from sets of containers,
  e.g. a database container and an application container. Combine configuration and
  life cycle control in a single `docker-compose.yaml` file.

---

Basic docker [commands](https://docs.docker.com/engine/reference/commandline/docker/):

* **Image lifecycle** commands (lifecycle: states over creation, existence, removal):
  * `docker build | rmi ` (rmi: remove image),
  * `docker pull | push ` from/to a registry.

* **Container lifecycle** commands:
  * `docker run | start | stop | rm ` (rm: remove container).
  * `docker exec ` - attach processes to container.

* **Inspection** commands:
  * show images: `docker images`,
  * show containers: `docker ps -a ` (existing and running containers `-a`),
  * show output: `docker logs`.

---

Docker Overview:
![Docker Overview](https://docs.docker.com/engine/images/architecture.svg "Some hover text")

---

### Reference Documentation
For further reference, find information at links:

* Getting Docker, [here](https://docs.docker.com/get-docker).
* Docker Reference, [here](https://docs.docker.com/reference).
* Docker Commands,  [here](https://docs.docker.com/engine/reference/commandline/docker),
  [cheatsheet](https://devhints.io/docker).
* Compose Reference, [here](https://docs.docker.com/compose/features-uses).
* Dockerfile [cheatsheet](https://devhints.io/dockerfile).
* docker-compose [cheatsheet](https://devhints.io/docker-compose).

---
