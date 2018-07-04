# fanuc_driver_exp

A new - experimental - Fanuc robot driver for ROS-Industrial.


## Overview

Main differences with `fanuc_driver`:

 - tries to adhere to commanded velocity constraints on trajectory segments (but will most likely fail)
 - adds out-of-the-box support for linear joints / tracks
 - 125 Hz / 83 Hz joint state reporting (controller maximum, depending on `ITP`)
 - decouples network traffic processing from trajectory execution
 - proper support for trajectory goal `abort` (ie: motion cancel using a `SKIP` condition), but see [issue 3][]
 - adds a configurable length point-buffer to minimise influence of network latency between controller and ROS PC
 - significantly more robust and flexible network code
 - extensive use of `rossum` build infrastructure support (modularity, code reuse)


## Installation

Installation using a binary distribution is preferred, but building from sources is also supported.


### Binaries

Determine the system software version running on the target controller, then download the latest binary distribution from the [releases][] page.

Extract the zip file to a suitable location and follow the steps under [Copying](#copying).


### Source build

Note: the below steps use Dirk Thomas' [vcstool][] to clone all required repositories with a single command (`vcstool` can be installed under Windows using `pip`). This can also be done manually: just `git clone ..` each of the repositories listed in the `repos.repos` file.

In a [rossum][] workspace (on a Windows machine with Roboguide):

    wget https://raw.githubusercontent.com/gavanderhoorn/fanuc_driver_exp/master/repos.repos
    vcs import --input repos.repos
    mkdir build
    cd build
    rossum -r ..\fanuc_driver_exp\robot.ini ..
    ninja

Now continue with [copying](#copying) the necessary files.


## Copying

### Using the provided scripts

This is the recommended way to install.

Note: the following steps refer to *removable media*. This can either be a USB stick (FAT32 formatted), or a PCMCIA memory card. Refer to the relevant Fanuc documentation for more information.

 1. Extract the binary distribution zip file to the root of the removable medium.
 1. Check and make sure the `install.cm`, `uninstall.cm` and the `product` directory are **in the root of the drive**. Placing them in sub directories will **not work**.
 1. For a USB stick, insert it either into the TP, or in one of the ports on the controller. For a memory card, insert it into the slot on the controller.
 1. Using the TP, browse to the root of the device that corresponds to whichever removable medium contains the driver's files.
 1. Highlight the `uninstall.cm` file, press `ENTER`. Some warnings may be expected, if files were / are not present.
 1. Highlight the `install.cm` file, press `ENTER`.

Status output is printed to the TP and the installation process should complete with a confirmation shown on the screen.

An installation log is written to the removable medium (`install.log`).


### Manually

This method of installation is recommended only when customising the Karel programs or if using a removable medium or the installation scripts is not possible.

Copy the following files to the controller:

 - libindlog.pc
 - libmathex.pc
 - librosfanuc.pc
 - libsm000a.pc
 - libsm000b.pc
 - libsm000d.pc
 - libsm_hdr.pc
 - libssock.pc
 - ros_state.pc
 - ros_traj.pc
 - rstate_cfg.pc
 - rtraj_cfg.pc
 - ros.tp (or the .ls version)
 - ros_movesm.tp (or the .ls version)

If this is a fresh install, run the `RSTATE_CFG` and the `RTRAJ_CFG` programs **once**.


## Configuration

Configuration is similar to that of `fanuc_driver`. See [fanuc_driver/wiki/cfg][] for more information (but note that `fanuc_driver_exp` has additional configuration entries which have not been documented yet).

Note that upon startup, both `ROS_STATE` as well as `ROS_TRAJ` will check their configuration. If any item is not present or set correctly, or the `CHECKED` item is not set to `TRUE`, a `FILE-032 Illegal parameter` error will be shown on the TP and the programs will be terminated. In that case open the *Karel Vars* of the faulting program (either `ROS_STATE` or `ROS_TRAJ`) and update the configuration. Make sure everything is correct, and finally set `CHECKED` to `TRUE`.


## Running

Start the `ROS` TP program, then follow the normal `fanuc_driver` workflow.


## License

Unless stated otherwise, all code under the Apache 2.0 license.



[issue 3]: https://github.com/gavanderhoorn/fanuc_driver_exp/issues/3
[releases]: https://github.com/gavanderhoorn/fanuc_driver_exp/releases
[vcstool]: https://github.com/dirk-thomas/vcstool
[rossum]: https://github.com/gavanderhoorn/rossum
[fanuc_driver/wiki/cfg]: http://wiki.ros.org/fanuc/Tutorials/hydro/Configuration
