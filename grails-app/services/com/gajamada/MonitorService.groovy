package com.gajamada

import grails.events.Listener

class MonitorService {

    @Listener(namespace='gorm', topic = 'afterInsert')
    void afterInsertClusterRun(ClusterRun clusterRun){
        startMonitor(clusterRun)
    }

    void queryState(ClusterRun clusterRun){
        //api call to check state on this cluster
        new ClusterState().save()
        new JobState().save()
        //if cluster terminated shutdown monitor
    }

    void startMonitor(ClusterRun clusterRun){


    }

    @Listener(topic = 'shutdown-cluster')
    void shutDownMonitor(ClusterRun clusterRun){
        quartzScheduler.unscheduleJob(quartzScheduler."trigger-${clusterRun.clusterId}")
    }
}
