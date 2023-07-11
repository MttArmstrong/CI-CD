---
title: "Hello CI World"
teaching: 5
exercises: 5 
objectives:
  - Add CI/CD to your project.
questions:
  - How do I run a simple GitHub Actions job?
hidden: false
keypoints:
  - Creating `.github/workflows/main.yml` is the first step to CI/CD.
  - Pipelines are made of jobs with steps.
---

## Adding CI/CD to a project

The first thing we'll do is create a `.github/workflows/main.yml` file in the project.
```bash
mkdir name-of-your-project/
cd name-of-your-project/
git init # if not initialized yet...
mkdir -p .github/workflows
```

Open `.github/workflows/main.yml` with your favorite editor and add the following
~~~
name: example
on: push
jobs:
  greeting:
    runs-on: ubuntu-latest
    steps:
      -run: echo hello world
~~~
{: .language-yaml}

## Run GitHub Actions


We've created the `.github/workflows/main.yml` file but it's not yet on GitHub. Next step we'll push these changes to GitHub so that it can run our job.
Since we're adding a new feature (Actions) to our project, we'll work in a feature branch. This is just a human-friendly named branch to indicate that it's adding a new feature.

```bash
cd name-of-your-project/
git checkout -b feature/add-actions
git add .github/workflows/main.yml
git commit -m "my first actions"
git push -u origin feature/add-actions
```

And that's it! You've successfully run your CI/CD job and you can view the output. You just have to navigate to the GitHub webpage for the `name-of-your-project` project and hit Actions button, you will find details of your job (status, output,...).

*TODO: add a image of workflow.... like from [here](https://hsf-training.github.io/hsf-training-cicd-github/07-hello-world-ci/index.html)*

From this page, click through until you can find the output for the successful job run which should look like the following

*TODO: add a image of workflow.... like from [here](https://hsf-training.github.io/hsf-training-cicd-github/07-hello-world-ci/index.html)*

## Pull Request

Lastly, we'll open up a pull request for this branch, since we plan to merge this back into `main` when we're happy with the first iteration of the Actions.

{% include links.md %}
