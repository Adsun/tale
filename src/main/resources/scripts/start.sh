#!/bin/sh
## java env
#export JAVA_HOME=/usr/local/java/jdk1.7.0_72
#export JRE_HOME=$JAVA_HOME/jre

## service name
#########################    change   ######################################
SERVICE_NAME=blog-latest
APP_NAME=blog


###################     do not change   ###################


SERVICE_DIR=.

JAR_NAME=$SERVICE_NAME\.jar
PID=$SERVICE_NAME\.pid

#cd $SERVICE_DIR

case "$1" in

    start)
    rm -rf $SERVICE_DIR/$PID
	nohup java -Xmx512M -Xms256M -jar  $JAR_NAME >> nohup_$APP_NAME\.out 2>&1 &
        echo $! > $SERVICE_DIR/$PID
        echo "=== start $SERVICE_NAME, pid=$!"
        echo $SERVICE_DIR/$PID
        ;;

    stop)
        echo "=== stop $SERVICE_NAME"
        P_ID=`cat $SERVICE_DIR/$PID`
        if [ "$P_ID" ] == ""; then
            echo "=== $SERVICE_NAME process not exists or stop success"
        else
            echo "=== $SERVICE_NAME process pid is:$P_ID"
            echo "=== begin kill $SERVICE_NAME process, pid is:$P_ID"
            kill -9 $P_ID
        fi
        ;;

    restart)
        $0 stop
        sleep 2
        $0 start
        echo "=== restart $SERVICE_NAME"
        ;;

    *)
        ## restart
        $0 stop
        sleep 2
        $0 start
        ;;
esac
exit 0

