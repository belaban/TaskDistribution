# Author: Bela Ban

#!/bin/bash

TD=${TD-$HOME/TaskDistribution}

LIB=$TD/lib

CP=$TD/classes:$TD/conf

# If this is a bin dist, JARs are in the $TD directory.
if [ ! -d $LIB ]; then
    LIB=$TD
fi;

CP=$CP:$LIB/*

if [ -f $HOME/log4j.properties ]; then
    LOG="-Dlog4j.configuration=file:$HOME/log4j.properties"
fi;

if [ -f $HOME/log4j2.xml ]; then
    LOG="$LOG -Dlog4j.configurationFile=$HOME/log4j2.xml"
fi;

if [ -f $HOME/logging.properties ]; then
    LOG="$LOG -Djava.util.logging.config.file=$HOME/logging.properties"
fi;

TD_FLAGS="-Djgroups.bind_addr=$IP_ADDR -Djboss.tcpping.initial_hosts=$IP_ADDR[7800]"
TD_FLAGS="$TD_FLAGS -Djava.net.preferIPv4Stack=true"
FLAGS="-server -Xmx600M -Xms600M"
FLAGS="$FLAGS -XX:CompileThreshold=10000 -XX:+AggressiveHeap -XX:ThreadStackSize=64K -XX:SurvivorRatio=8"
FLAGS="$FLAGS -Xshare:off"
# JMX="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=7777 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
JMX="-Dcom.sun.management.jmxremote"
#EXPERIMENTAL="-XX:+UseFastAccessorMethods -XX:+UseTLAB"

#EXPERIMENTAL="$EXPERIMENTAL -XX:+DoEscapeAnalysis -XX:+EliminateLocks -XX:+UseBiasedLocking"
EXPERIMENTAL="$EXPERIMENTAL -XX:+EliminateLocks -XX:+UseBiasedLocking"

#EXPERIMENTAL="$EXPERIMENTAL -XX:+AggressiveOpts -XX:+DoEscapeAnalysis -XX:+EliminateLocks -XX:+UseBiasedLocking -XX:+UseCompressedOops"
#EXPERIMENTAL="$EXPERIMENTAL -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC"

#java -Xrunhprof:cpu=samples,monitor=y,interval=5,lineno=y,thread=y -classpath $CP $LOG $TD_FLAGS $FLAGS $EXPERIMENTAL $JMX  $*

#DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5000"
#JMC="-XX:+UnlockCommercialFeatures -XX:+FlightRecorder"

java -cp $CP $DEBUG $LOG $TD_FLAGS $FLAGS $EXPERIMENTAL $JMX $JMC  org.taskdistribution.Server $*
