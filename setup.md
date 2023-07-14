---
title: Setup
questions:
- "What do I need to start?"
---

## Set up Python

Part of this lesson consists in learning how to make scripts exit correctly. At some point, we will need to test exit codes with Pytest, Python testing tool.

To know whether your Python has `pytest`, just run `python -c "import pytest"`. If this command returns nothing, it means everything is fine. Otherwise, please visit [https://docs.pytest.org/en/stable/getting-started.html](https://docs.pytest.org/en/stable/getting-started.html) for installation.

## Set up Python project code

> ## Notice
> We will be reusing the materials from the [INTERSECT packaging lesson](https://intersect-training.org/packaging) for our Python project code sample.
{: .callout}

- Create a new project on your personal GitHub account and name it `intersect-training-cicd`.

  ![example of a properly-filled-in blank project form for gitlab]({{site.baseurl}}/fig/blank-project-form.png)
  {: .callout}


### Get via git clone...

- Clone the pre-setup repository

  Open a terminal and clone the repository that contains files required for this lesson.

  ```bash
  git clone git@github.com:marshallmcdonnell/intersect-training-packaging-example.git intersect-training-cicd
  cd intersect-training-cicd
  ```

- Add the code to your personal GitHub account

  At the moment, your clone is the remote repository stored on someone GitHub account. To get the name of the existing remote use
  ```bash
  git remote -v # -v stands for verbose
  ```

  ```
  origin	git@github.com:marshallmcdonnell/intersect-training-packaging-example.git (fetch)
  origin	git@github.com:marshallmcdonnell/intersect-training-packaging-example.git (push)
  ```
  {: .output}

  You have to change remote's URL in order to be able to add the code to your personal GitHub account.

  ```bash
  git remote set-url origin git@github.com:<GitHub username>/intersect-training-cicd.git
  ```
  Check again the name of the current remote:
  ```bash
  git remote -v
  ```

  Checkout `main` (if not already)
  ```bash
  git checkout -b main
  ```

  The last step is to run the push command as follows
  ```bash
  git push -u origin main
  ```

### Get via download...

- Download the [zip for intersect-training-cicd][download-site]

- Unzip:

  ```bash
  unzip intersect-training-cicd.zip
  cd intersect-training-cicd/
  ```

- Add the code to your personal GitHub account

  Make this diretory a local git repository
  ```bash
  git init
  ```

  Set the remote for the local repository using the repository you made above
  ```bash
  git remote add origin git@github.com:<GitHub username>/intersect-training-cicd.git
  ```

  Check the name of the current remote:
  ```bash
  git remote -v
  ```

  Checkout `main` (if not already)
  ```bash
  git checkout -b main
  ```

  Stage and commit new project changes to `main`
  ```bash
  git add .
  git commit -m "Adds initial project example"
  ```

  The last step is to run the push command as follows
  ```bash
  git push -u origin main
  ```

If you're having issues, **please let us know immediately**
since you might not be able to follow this lesson without a proper setup.

[download-site]: https://github.com/INTERSECT-training/CI-CD/raw/main/downloads/intersect-training-cicd.zip

## Set up Docker (optional)

- Install Docker:  [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
<!-- Mac OS:  [https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/)-->
<!-- Windows: [https://docs.docker.com/docker-for-windows/install/](https://docs.docker.com/docker-for-windows/install/)-->

To check your installation open a terminal and run:
  ```bash
  docker --version
  ```
**Note** that you may have to run with *sudo*. If you don’t want to preface the *docker* command with *sudo*, you may need to checkout [https://docs.docker.com/engine/install/linux-postinstall/](https://docs.docker.com/engine/install/linux-postinstall/).



