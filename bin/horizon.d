#!/bin/bash
#
# This is used to start/stop horizon 

RETVAL=0

start () {
    rm ../src/horizon/*.pyc
    /usr/bin/env python ../src/horizon/horizon-agent.py start
        RETVAL=$?
        if [[ $RETVAL -eq 0 ]]; then
            echo "started horizon-agent"
        else
            echo "failed to start horizon-agent"
        fi
        return $RETVAL
}

stop () {
    # TODO: write a real kill script
    ps aux | grep 'horizon-agent.py start' | grep -v grep | awk '{print $2 }' | xargs kill -9
    /usr/bin/env python ../src/horizon/horizon-agent.py stop
        RETVAL=$?
        if [[ $RETVAL -eq 0 ]]; then
            echo "stopped horizon-agent"
        else
            echo "failed to stop horizon-agent"
        fi
        return $RETVAL
}


# See how we were called.
case "$1" in
  start)
    start
        ;;
  stop)
    stop
        ;;

  *)
        echo $"Usage: $0 {start|stop}"
        exit 2
        ;;
esac
