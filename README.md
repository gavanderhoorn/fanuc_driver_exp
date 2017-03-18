# fanuc_driver_exp

A new - experimental - Fanuc robot driver for ROS-Industrial.


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
