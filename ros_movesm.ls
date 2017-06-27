/PROG  ROS_MOVESM
/ATTR
OWNER       = MNEDITOR;
COMMENT     = "ROS//r2b";
PROG_SIZE	= 1102;
CREATE      = DATE 27-03-14  TIME 13:06:56;
MODIFIED	= DATE 27-03-14  TIME 13:06:56;
FILE_NAME   = ;
VERSION     = 0;
LINE_COUNT	= 54;
MEMORY_SIZE	= 1518;
PROTECT     = READ_WRITE;
TCD:  STACK_SIZE    = 0,
      TASK_PRIORITY = 50,
      TIME_SLICE    = 0,
      BUSY_LAMP_OFF = 0,
      ABORT_REQUEST = 0,
      PAUSE_REQUEST = 0;
DEFAULT_GROUP   = 1,*,*,*,*;
CONTROL_CODE    = 00000000 00000000;
/APPL
/MN
    :  !poses in world frame ;
    :  UFRAME_NUM=0 ;
    :  UTOOL_NUM=1 ;
    :  PAYLOAD[1] ;
    :   ;
    :   ;
    :  !force Cart repr ;
    :  PR[1:pos]=LPOS    ;
    :  PR[2:pos cache]=LPOS    ;
    :   ;
    :  !init: not rdy, no ack ;
    :  F[1:msm_ready]=(OFF) ;
    :  F[2:msm_dready]=(OFF) ;
    :   ;
    :  !listen to ros_traj for SKIPs ;
    :  SKIP CONDITION R[7:ros skip]<>0;
    :   ;
    :   ;
    :  LBL[10] ;
    :   ;
    :  !we're ready for new point ;
    :  F[1:msm_ready]=(ON) ;
    :   ;
    :  !wait for relay ;
    :  WAIT (F[2:msm_dready])    ;
    :   ;
    :  !cache in temp preg ;
    :  PR[2:pos cache]=PR[1:pos]    ;
    :  R[4:lin_vel cache]=R[1:lin_vel]    ;
    :  R[5:cr cache]=R[2:cr]    ;
    :  R[6:acc cache]=R[3:acc]    ;
    :   ;
    :  !first rdy low, then ack copy ;
    :  !TODO: can this be ON? ;
    :  F[1:msm_ready]=(OFF) ;
    :  F[2:msm_dready]=(OFF) ;
    :   ;
    :  !move to point ;
    :  !note: CR is hard-coded ;
    :L PR[2:pos cache] R[4:lin_vel cache]mm/sec CR5 ACC R[6:acc cache] Skip,LBL[10]    ;
    :   ;
    :  !skipped, goto handler ;
    :  JMP LBL[20] ;
    :   ;
    :   ;
    :  !see what the problem is ;
    :  LBL[20:skip handler] ;
    :   ;
    :  !in any case re-enable skip ;
    :  SKIP CONDITION R[7:ros skip]<>0;
    :   ;
    :  !on any unknown err, abort ;
    :  IF R[7:ros skip]<>1,JMP LBL[999] ;
    :   ;
    :  !traj stop from ros_traj: ;
    :  !don't touch R[7:ros skip], ;
    :  !that is the responsibility ;
    :  !of ros_traj. ;
    :  JMP LBL[10] ;
    :   ;
    :   ;
    :  LBL[999:abort];
    :  !something else, abort ;
    :  MESSAGE[ ROS Motion ABORT ] ;
    :  ABORT ;
    :   ;
/POS
/END
