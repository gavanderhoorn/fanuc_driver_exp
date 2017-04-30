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

In a [rossum][] workspace (on a Windows machine with Roboguide):

    wget https://github.com/gavanderhoorn/fanuc_driver_exp/blob/master/repos.repos
    vcs import --input repos.repos
    mkdir build
    cd build
    rossum -r ..\fanuc_driver_exp\robot.ini ..
    ninja

Now continue with [copying](#copying) the necessary files.


## Copying

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
 - ros.ls
 - ros_movesm.ls


## Configuration

Configuration is similar to that of `fanuc_driver`. See [fanuc_driver/wiki/cfg][] for more information (but note that `fanuc_driver_exp` has additional configuration entries which have not been documented yet).

Note that upon first start, both `ROS_STATE` as well as `ROS_TRAJ` will setup defaults. It is recommended to run the `ROS` TP program at least once, and only then edit the configuration of the Karel programs.


## Running

Start the `ROS` TP program, then follow the normal `fanuc_driver` workflow.


## License

Unless stated otherwise, all code under the Apache 2.0 license.



[issue 3]: https://github.com/gavanderhoorn/fanuc_driver_exp/issues/3
[releases]: https://github.com/gavanderhoorn/fanuc_driver_exp/releases
[rossum]: https://github.com/gavanderhoorn/rossum
[fanuc_driver/wiki/cfg]: http://wiki.ros.org/fanuc/Tutorials/hydro/Configuration
