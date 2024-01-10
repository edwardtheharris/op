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

> Input prompt

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

### Example Output

The following was obtained by running the script on the author's workstation.

1. Execution of the script.

   ```sh
   bash install.sh amd64
   ```

   > Expected output

   <!-- markdownlint-disable MD013 -->
   ```sh
   Proceeding with amd64-compatible installation.
   --2024-01-10 11:56:27--  https://cache.agilebits.com/dist/1P/op2/pkg/v2.24.0/op_linux_amd64_v2.24.0.zip
   Loaded CA certificate '/etc/ssl/certs/ca-certificates.crt'
   Resolving cache.agilebits.com (cache.agilebits.com)... 205.234.175.175
   Connecting to cache.agilebits.com (cache.agilebits.com)|205.234.175.175|:443... connected.
   HTTP request sent, awaiting response... 200 OK
   Length: 8517044 (8.1M) [application/zip]
   Saving to: ‘/tmp/op.zip’

   /tmp/op.zip                                                                                         100%[=================================================================================================================================================================================================================================================================>]   8.12M  2.91MB/s    in 2.8s

   2024-01-10 11:56:31 (2.91 MB/s) - ‘/tmp/op.zip’ saved [8517044/8517044]

   Archive:  op.zip
    extracting: op/op.sig
     inflating: op/op
   ```
   <!-- markdownlint-enable -->

2. Verification of its location.

   ```sh
   command -v op
   ```

   > Expected output

   ```sh
   /usr/local/bin/op
   ```

3. Verification that the installed program runs as expected.

    <!-- markdownlint-disable MD013 -->
   ```sh
   op
   ```

   > Expected output

   ```sh
   ---
   1Password CLI brings 1Password to your terminal.

   Turn on the 1Password app integration and sign in to get started. Run
   'op signin --help' to learn more.

   For more help, read our documentation:
   https://developer.1password.com/docs/cli

   1Password CLI is built using open-source software. View our credits and
   licenses:
   https://downloads.1password.com/op/credits/stable/credits.html

   Usage:  op [command] [flags]

   Management Commands:
     account     Manage your locally configured 1Password accounts
     connect     Manage Connect server instances and tokens in your 1Password account
     document    Perform CRUD operations on Document items in your vaults
     events-api  Manage Events API integrations in your 1Password account
     group       Manage the groups in your 1Password account
     item        Perform CRUD operations on the 1Password items in your vaults
     plugin      Manage the shell plugins you use to authenticate third-party CLIs
     user        Manage users within this 1Password account
     vault       Manage permissions and perform CRUD operations on your 1Password vaults

   Commands:
     completion  Generate shell completion information
     inject      Inject secrets into a config file
     read        Read a secret reference
     run         Pass secrets as environment variables to a process
     signin      Sign in to a 1Password account
     signout     Sign out of a 1Password account
     update      Check for and download updates.
     whoami      Get information about a signed-in account

   Global Flags:
         --account account    Select the account to execute the command by account shorthand, sign-in address, account ID, or user ID. For a list of available accounts, run 'op account list'. Can be set as the OP_ACCOUNT environment variable.
         --cache              Store and use cached information. Caching is enabled by default on UNIX-like systems. Caching is not available on Windows. Options: true, false. Can also be set with the OP_CACHE environment variable. (default true)
         --config directory   Use this configuration directory.
         --debug              Enable debug mode. Can also be enabled by setting the OP_DEBUG environment variable to true.
         --encoding type      Use this character encoding type. Default: UTF-8. Supported: SHIFT_JIS, gbk.
         --format string      Use this output format. Can be 'human-readable' or 'json'. Can be set as the OP_FORMAT environment variable. (default "human-readable")
     -h, --help               Get help for op.
         --iso-timestamps     Format timestamps according to ISO 8601 / RFC 3339. Can be set as the OP_ISO_TIMESTAMPS environment variable.
         --no-color           Print output without color.
         --session token      Authenticate with this session token. 1Password CLI outputs session tokens for successful 'op signin' commands when 1Password app integration is not enabled.
     -v, --version            version for op

   Run 'op [command] --help' for more information on the command.
   ```
   <!-- markdownlint-enable -->

## New Versions

At the time of writing the author does not intend to add support for automated
version updates, so if you need to download a version other than v2.24.0,
you will need to update line 23 of the `install.sh` script with the version
that you need to download.
