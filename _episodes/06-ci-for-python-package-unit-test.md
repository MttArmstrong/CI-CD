---
title: "CI for Python Package"
teaching: 10
exercises: 10
questions:
  - How do I setup CI for a Python package in GitHub Actions?
objectives:
  - Learn about the Actions for GitHub Actions
  - Learn basic setup for Python package GitHub Actions
keypoints:
  - GitHub has a Marketplace of reusable Actions
  - CI can help automated running tests for code changes to your Python package
---

# Setup Python project

For this episode, we will be using some of the material
from the [INTERSECT packaging carpentry](https://intersect-training.org/packaging)

# Setup CI

Now we will switch from setting up a general CI pipeline
to more specifically setting up CI for our Python package needs.

But first...
> ## Activity: What do we need in CI for a Python package project?
>
> What are some of the things we want to automate checks for in CI for a Python Package?
>
> What tools accomplish these checks?
> 
> > ## Solution
> > Just some suggestions (not comprehensive):
> > * Testing passes ([pytest][pytest] for unit testing or [nox][nox] for parallel Python environment testing)
> > * Code is of quality (i.e. [ruff][ruff] or [flake8][flake8] for [linting][lint] or [mccabe][mccabe] for reducing [cyclomatic complexity][cc]
> > * Code conforms to project formatting guide (i.e. [black][black] for formatting)
> > * Code testing coverage does not drop significanly (i.e. [pytest-cov][pytest-cov] or [Coverage.py][coverage])
> > * Static type checking (i.e. [mypy][mypy] )
> > * Documentation builds (i.e. [sphinx][sphinx] )
> > * Security vulnerabilities (i.e. [bandit][bandit])
> > 
> {: .solution}
{: .challenge}

> ## CI development
> When you are first starting out setting up CI,
> don't feel you need to add all the checks at the beginning of a project.
> First, pick the ones that are  "must haves" or easier to implement.
> Then, iteratively improve your pipeline.
{: .callout }

## Setup Python environment in CI 

As of right now, your `.github/workflows/main.yml` YAML file should look like
~~~
name: Code Checks
on: push
jobs:
  greeting:
    runs-on: ubuntu-latest
    steps:
      - name: Greeting!
        run: echo hello world
~~~
{: .language-yaml}

Overall, we will want to get our CI to run our unit tests via [pytest][pytest].
But first, let's figure out how to setup a Python environment.

Let's change the name from `example` to `Code Checks` to better reflect what we will be doing.

We will add another job (named `test-python-3-10`)
and add the steps to setup a Python 3.10 environment to our YAML file:

~~~
name: Code Checks
on: push
jobs:
  greeting:
    runs-on: ubuntu-latest
    steps:
      - name: Greeting!
        run: echo hello world

  test-python-3-10:
    name: Check Python 3.10 on Ubuntu
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-python@v4
        with:
          python-version: "3.10"
~~~
{: .language-yaml}

You might be asking: _"What is going on with the `uses` command?"_

Here, we are using what GitHub calls ["Actions"][actions].
These are custom applications that,
quoted from the documation link above,
 _"...performs a complex but frequently repeated task."_

Second, you might ask: _"Okay... but what is it doing?"_

We won't go into too much detail but mainly, `actions/checkout@v3` checks out your code. 
This one is used all the time.

> ## GitHub Acions Marketplace
> GitHub has what they call a ["Marketplace" for "Actions"][marketplace-actions] where you can search for reusable tasks.
{: .callout }

There is a Marketplace page for `actions/checkout` ([Marketplace page][actions-checkout-marketplace]]) and also a GitHub repository for the source code ([GitHub][actions-checkout-github]).

The `@v3` in `actions/checkout@v3` signifies which version of the `actions/checkout` to use.

So...
> ## Activity: What does the `setup-python` Action do?
>
> What do you think the `actions/setup-python` does?
>
> Can you find the Marketplace page for `actions/setup-python`?
>
> Can you find the GitHub repository for `actions/setup-python`?
>
> *Bonus:* Can you find a file in the GitHub repo that gives you all the `with` options?
> 
> > ## Solution
> > * This action helps install a version of Python along with other options
> > * Marketplace: [https://github.com/marketplace/actions/setup-python](https://github.com/marketplace/actions/setup-python)
> > * GitHub repository: [https://github.com/actions/setup-python][actions-setup-python-github]
> > * *Bonus:* This will be in the `actions.yml`. Here is the `@v4` version of `actions.yml`: [link](https://github.com/actions/setup-python/blob/v4/action.yml).
> {: .solution}
{: .challenge}

## Running your unit tests via CI

We now have our Python environment setup in CI.
Let's add running our tests!

~~~
name: Code Checks
on: push
jobs:
  greeting:
    runs-on: ubuntu-latest
    steps:
      - name: Greeting!
        run: echo hello world

  test-python-3-10:
    name: Check Python 3.10 on Ubuntu
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install package
        run: python -m pip install -e .[test]

      - name: Test package
        run: python -m pytest
~~~
{: .language-yaml}

We see that we are installing our Python package
with the test dependencies and then running `pytest`,
just like we would locally.

Let's push it and see our new CI for Python!

```bash
git add .github/workflows/main.yml
git commit -m "Adds Python 3.10 test to CI"
git push
```

Checkout the results! We see that we now have two jobs running!:

![Actions]({{ page.root }}/fig/python-ci-actions.png)

We can see the output / results from running `pytest`:
![Actions test]({{ page.root }}/fig/python-ci-actions-test.png)

Similarly, we see our open Pull Request has updated dynamically with updates!

![Pull Request]({{ page.root }}/fig/python-ci-pull-request.png)


> ## Activity: Running multiple jobs
>
> Did the jobs run in sequence or in parallel?
>
> > ## Solution
> > Parallel. We will discuss this more when we get to the CD section.
> > 
> {: .solution}
{: .challenge}

{% include links.md %}

[pytest]: https://docs.pytest.org
[nox]: https://nox.thea.codes
[ruff]: https://beta.ruff.rs/docs/
[flake8]: https://flake8.pycqa.org
[lint]: https://en.wikipedia.org/wiki/Lint_(software)
[mccabe]: https://github.com/PyCQA/mccabe
[cc]: https://en.wikipedia.org/wiki/Cyclomatic_complexity
[bandit]: http://www.lizard.ws/
[black]: https://black.readthedocs.io
[pytest-cov]: https://pytest-cov.readthedocs.io
[coverage]: https://coverage.readthedocs.io
[mypy]: https://www.mypy-lang.org/
[sphinx]: https://www.sphinx-doc.org
[bandit]: https://bandit.readthedocs.io

[actions]: https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#actions
[marketplace-actions]: https://github.com/marketplace?type=actions
[actions-checkout-marketplace]: https://github.com/marketplace/actions/checkout
[actions-checkout-github]: https://github.com/actions/checkout
[actions-setup-python-github]: https://github.com/actions/setup-python
