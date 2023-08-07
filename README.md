# TrustyTools
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) ![Cross Platform](https://img.shields.io/badge/platform-windows%20%7C%20macos%20%7C%20linux-lightgrey) [![License][license-badge]](LICENSE) ![Build Status Windows PowerShell Main](https://github.com/TrustyTristan/TrustyTools/workflows/ActionsTest-Windows-Build/badge.svg?branch=master)

[license-badge]: https://img.shields.io/github/license/TrustyTristan/TrustyTools

## Synopsis

TrustyTools is a PowerShell module that is a collection of useful CLI tools.

## Description

TrustyTools adds extra commands that I frequently need to use for just everyday shell activities or for scripts that I need to build.

## Getting Started

### Installation

```powershell
# how to install TrustyTools
Install-Module -Name TrustyTools -Repository PSGallery -Scope CurrentUser
```

### Quick start

#### Example

```powershell
Get-Command -Module TrustyTools

```
## TrustyTools Cmdlets
[Cmdlets list](/docs/TrustyTools.md)

## Contributing

If you'd like to contribute to TrustyTools, please see the [contribution guidelines](.github/CONTRIBUTING.md).

## License

TrustyTools is licensed under the [MIT license](LICENSE).

## Author

Tristan Brazier