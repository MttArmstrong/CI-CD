---
title: "(Bonus) Implementing CI/CD for documentation using containers"
teaching: 5
exercises: 0
questions:
   - How to setup CI/CD for documentation using containers?
objectives:
  - Setup a CI and CD workflow for container images using GitHub Actions
  - Learn about the GitHub Container Image Registry
keypoints:
  - GitHub provides resources to publish container images
---

Knowing about containers and how we want to create a container image,
we will dive into implementing CI/CD for our documentation using Docker.

We won't be running these commands locally so you do not need Docker installed.
We will just created the GitHub Actions YAML file
to let CI/CD run it instead.

If you do have docker installed, feel free to run these commands locally.
It is just not required.

# Setup CI for documentation

The main job we need for CI is to build the container image for the documentation.

We can accomplish this simply with Docker via:
```bash
docker build -t my-docs .
```

So let us add this to our CI YAML.
Luckily, Docker is already installed on the GitHub Actions runners!

If not already in the project directory, go ahead and get there.
We will make our feature branch:
```bash
cd intersect-training-cicd
git checkout main
git pull
git checkout -b add-docs-cicd
```

We will create a new `.github/workflows/docs-ci.yml` file in the project.

Open `.github/workflows/docs-ci.yml` with your favorite editor and add the following
~~~
name: Documentation CI
on: push
jobs:
  build-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build docs via Docker
        run: docker build -t my-docs .
~~~
{: .language-yaml}

NOTE: Don't forget the `.` at the end of the `docker build -t my-docs .` command! That tells the build command which directory to use.

Let's push this to the repository and see what happens!
```bash
git add .github/workflows/docs-ci.yml
git commit -m "Adds job to build docs in CI via docker"
git push -u origin add-docs-cicd
```


![GitHub Actions docs CI]({{ page.root }}/fig/docker-ci-docs.png)

# GitHub Container Image Registry

We won't be using the [DockerHub][dockerhub] container image registry.

Instead, we will use GitHub's built-in [GitHub Container Image Regsitry][ghcr] (GHCR).
Similar to one reason why we choose GitHub Actions for CI/CD,
GitHub can integration with GHCR without requiring 3rd party credentials
to be shared, like we did with TestPyPi.

Also, it is free! DockerHub is as well, mostly.

# Setup CD for documentation

[dockerhub]: https://hub.docker.com/
[ghcr]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry

# Setup CD for documentation


