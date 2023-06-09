# Tecton AWS Setup

## About

Terraform module(s) to deploy prerequisites to AWS prior to installing [Tecton](https://tecton.ai).

:warning: Note: this repository of modules is intended to replace [tecton-ai-ext/tecton-terraform-setup](https://github.com/tecton-ai-ext/tecton-terraform-setup). There will be a transition period from the old modules to this. Please reach out to your Tecton rep if you have any questions.

## Usage

There are several ways that Tecton can be deployed. The deployment model that should be used
should be communicated by Tecton support. Each of the [submodules](modules) here capture the
different deployment models, all of which have [examples](examples). These examples should be used
as a reference point for Terraform module definitions in your own codebase. It is recommended to
use [remote state](https://www.terraform.io/language/state/remote) to track the Terraform state.

For further guidance and questions, please reach out to Tecton support.

## Contribution

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Authors

Module is maintained and supported by [Tecton](https://tecton.ai).

## License

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
