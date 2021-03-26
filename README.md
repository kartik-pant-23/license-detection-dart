
# SPDX License Detection Package

## Getting started - Sample project

This project tends to fetch any license present in [SPDX master files][FILES-SRC] and parses the XML and prints into the terminal. It can either print the already provided template license or you provide `licenseId` and it prints that.

This is attempt to the [idea][IDEA-URI], license detection package in dart. This should not be considered as final product but is for the first example project.

  

## Approach

This is my approach to the good sample project and not for the complete project. 
Complete approach would be mentioned in the proposal.

1.  **Creating the license file**:
If person chooses to prepare a new file instead of available template then that file is fetched from `https://raw.githubusercontent.com/spdx/license-list-XML/master/src/<licenseId>.xml`

2.  **Parsing the file**:
* Unnecessary spaces and line breaks are removed and closing p tag `</p>` is replaced with line-breaks.
* Everything present inside the `<license>..</license>` tag, along with the attributes in the tag are used for printing.
* Opening tags are removed and closing tags replaced with dashed lines.



## How to run locally

* Clone this repository `git clone <repository-url>`, or download the zip file and unzip.
* Change your current working directory to this folder.
* I your terminal, run `dart run interactor.dart`

**Don't delete `license.xml` file present in the repository**

  

[IDEA-URI]: https://github.com/dart-lang/sdk/wiki/Dart-GSoC-2021-Project-Ideas#idea-spdx-license-detection-package

[FILES-SRC]: https://github.com/spdx/license-list-XML/tree/master/src
