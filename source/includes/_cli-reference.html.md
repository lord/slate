# CLI Reference

The Bonsai Command Line Interface (CLI) is a text based tool that enables you to configure and control the Bonsai Artificial Intelligence Engine. The CLI is especially useful for automation and connection to other tools. Currently, there are some actions that can only be performed using the CLI, such as loading your inkling file and connecting your simulator.  

```shell
$ bonsai command --help
```

Use `bonsai command --help` to get information about a specific command. You can use bonsai --help to view a list of groups and commands.

The Bonsai CLI is hierarchical.

![The Bonsai CLI][1]

The Bonsai CLI command hierarchy.

## Configure Command

```
$ bonsai configure
```

**configure** sets up authentication between you, as a user, and the server. This enables the server to verify that you are allowed to write Inkling code to a specific BRAIN. You can find your access code in your account settings at .

## Brain Group Commands

###### Create

```
$ bonsai brain create brainName
```

**create** generates a new brain and names it (brainName).

Brain names can include:

* letters
* numbers
* dashes

It is case insensitive, but case aware.

###### Load

```
$ bonsai brain load brainNameinklingFile.ink
```

**load** loads an Inkling file (inklingFile.ink) to a specific BRAIN (brainName).

## Train group commands

###### Start

```
$ bonsai brain train start brainName
```

**start** turns on/enables training mode for a specific BRAIN (brainName). The BRAIN trains whenever the simulator is connected. If the simulator is disconnected, the BRAIN remains in training mode, and it will train again where it left off when the simulator is reconnected.

###### Stop

```
$ bonsai brain train stop brainName
```

**stop** turns off training mode for a specific BRAIN (brainName).

## Bonsai CLI --help output

###### `bonsai --help`

```
bonsai --help
Usage: bonsai [OPTIONS] COMMAND [ARGS]...

  Command line interface for the Bonsai Artificial Intelligence Engine.

Options:
  --help  Show this message and exit.

Commands:
  brain      Create, load, train BRAINs.
  configure  Authenticate with the BRAIN Server.
  sims       Retrieve information about simulators
```

###### `bonsai configure --help`

```
$ bonsai configure --help
Usage: bonsai configure [OPTIONS]

  Authenticate with the BRAIN Server.

Options:
  --help  Show this message and exit.
```

###### `bonsai brain --help`

```
$ bonsai brain --help
Usage: bonsai brain [OPTIONS] COMMAND [ARGS]...

  Create, load, train BRAINs.

Options:
  --help  Show this message and exit.

Commands:
  create  Creates a BRAIN.
  list    Lists BRAINs owned by current user or by the...
  load    Loads an inkling file into the specified...
  train   Start and stop training on a BRAIN, as well...
```

###### `bonsai brain train --help`

```
$ bonsai brain train --help
Usage: bonsai brain train [OPTIONS] COMMAND [ARGS]...

  Start and stop training on a BRAIN, as well as get training status
  information.

Options:
  --help  Show this message and exit.

Commands:
  start   Trains the specified BRAIN.
  status  Gets training status on the specified BRAIN.
  stop    Stops training on the specified BRAIN.
```

###### `bonsai brain train status --help`

```
$ bonsai brain train status --help
Usage: bonsai brain train status [OPTIONS] BRAIN_NAME

  Gets training status on the specified BRAIN.

Options:
  --help  Show this message and exit.
```

###### `bonsai brain train start --help`

```
$ bonsai brain train start --help
Usage: bonsai brain train start [OPTIONS] BRAIN_NAME

  Trains the specified BRAIN.

Options:
  --help  Show this message and exit.
```

###### `bonsai brain train stop --help`

```
$ bonsai brain train stop --help
Usage: bonsai brain train stop [OPTIONS] BRAIN_NAME

  Stops training on the specified BRAIN.

Options:
  --help  Show this message and exit.
‍```
```

[1]: https://daks2k3a4ib2z.cloudfront.net/57bf257ce45825764c5cb54b/57e9bbd37af2be7632479217_bonsaiAI.png "The Bonsai CLI"
