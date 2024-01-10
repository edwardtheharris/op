# 1Password CLI Utility Install

![shell](https://github.com/edwardtheharris/op/actions/workflows/shellcheck.yml/badge.svg)
![markdown](https://github.com/edwardtheharris/op/actions/workflows/markdownlint.yml/badge.svg)

This is a simple shell script that is intended to provide a slightly friendlier
if quick and dirty, interface to the process described
in the related [1Password docs](http://tinyurl.com/4waw4t7u).

## Usage

The install script requires
[bash](https://www.gnu.org/software/bash/manual/bash.html) entirely as
a matter of the author's personal preference. Hypothetically it could be
modified to run in some other shell with relatively little effort.

To use the script you can either provide the architecture via the
CLI or select the architecture from the provided prompt. The script
will handle the remainder of the operations for you.

### Select Architecture from Prompt

The prompt method is shown below.

```sh
bash install.sh
```

```sh
Please select from the following architectures.

   1) 386
   2) amd64
   3) arm
   4) arm64

Select your architecture:
```

You need only enter the number for the architecture you are installing the
tool on and the script will handle the rest for you.

### Provide Architecture as CLI Option

You can also provide the required architecture value on the command line
as shown here.

The architecture must match one of the four options shown in the prompt above.

## Installation Results

The script will download v2.24.0 of the `op` command using
[wget](https://www.gnu.org/software/wget/manual/wget.html) so you will
need to install that if it isn't available on your system.

The program comes in a zip file, which is downloaded to `/tmp/op.zip`, then
then extracted to `/tmp/op`. Next, the `op` executable is moved to
`/usr/local/bin/op`, the downloaded files are cleaned up from the `/tmp`
directory.

Finally, the script adds a group called `onepassword-cli`, changes the group
ownership of `/usr/local/bin/op` to `onepassword-cli` then sets the `setuid`
bit on the executable.

If this completes successfully, the script exits zero.

## New Versions

At the time of writing the author does not intend to add support for automated
version updates, so if you need to download a version other than v2.24.0,
you will need to update line 23 of the `install.sh` script with the version
that you need to download.
