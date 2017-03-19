# fanuc_driver_exp

A new - experimental - Fanuc robot driver for ROS-Industrial.


## Overview

Main differences with `fanuc_driver`:

 - tries to adhere to commanded velocity constraints on trajectory segments (but will most likely fail)
 - adds out-of-the-box support for linear joints / tracks
 - 125 Hz / 83 Hz joint state reporting (controller maximum, depending on `ITP`)
 - decouples network traffic processing from trajectory execution
 - proper support for trajectory goal `abort` (ie: motion cancel using a `SKIP` condition)
 - adds a configurable length point-buffer to minimise influence of network latency between controller and ROS PC
 - significantly more robust and flexible network code
 - extensive use of `rossum` build infrastructure support (modularity, code reuse)


## Build

 1. create `rossum` workspace.
 1. clone dependencies using Dirk Thomas' `vcs`.
 1. Build using `rossum` and copy the following files to the controller:

    - libindlog.pc
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


## Running

Start the `ROS` TP program.


## License

Unless stated otherwise, all code under the Apache 2.0 license.
