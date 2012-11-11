package com.gajamada

import grails.events.Listener


class MonitorService {

    @Listener(namespace='gorm', topic = 'afterInsert')
    void afterInsertClusterRun(ClusterRun clusterRun){
        //startMonitor
    }

    void queryState(){
        //api call to check state
        new ClusterState().save()
        new JobState().save()
        //if cluster terminated shutdown monitor
    }
}
