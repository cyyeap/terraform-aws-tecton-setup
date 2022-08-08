# Contribution

## Making a pull request

### Requirements

* [pre-commit](https://pre-commit.com/#install)
* [terraform-docs](https://github.com/terraform-docs/terraform-docs)
* [tflint](https://github.com/terraform-linters/tflint)
* [terraform](https://www.terraform.io/)

Install pre-commit:

```shell
pre-commit install
```

### Contribution Checklist

A quick list of things to keep in mind as you're making changes:

- Use (**conventional commits**)[https://www.conventionalcommits.org/en/v1.0.0]
- Follow Terraform development guidelines outlined at https://www.terraform-best-practices.com
- If modules have changed update and re-generate the diagram (via diagram.py in the appropriate module)
  - Run `python3 diagram.py` (`pip install diagrams` if necessary) to generate the new png
- Run the pre-commit hooks prior to submitting a pull request

    ```shell
    pre-commit run --color=always --show-diff-on-failure --all-files
    ```

### Forking the repo

Fork this Github repository and clone your fork locally. Then make changes to a local branch to the fork.

See [Creating a pull request from a fork](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)
