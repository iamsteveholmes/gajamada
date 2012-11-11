package com.gajamada

import grails.events.Listener


class LaunchService {

    @Listener(topic = 'launch-cluster')
    String launchClusterHandler(LaunchClusterEvent launchClusterEvent){
        //launch cluster synchronously returning id
        launchCluster()
    }

    @Listener(topic = 'launch-job')
    String launchJobHandler(LaunchClusterEvent launchClusterEvent){
        //launch job synchronously returning id
        launchJob()
    }

    @Listener(topic = 'shutdown-cluster')
    void shutdownClusterHandler(LaunchClusterEvent launchClusterEvent){
        //shutdown cluster
    }

    String launchCluster(){
        //returns clusterId
    }

    String launchJob(){
        //returns jobId
    }
}
