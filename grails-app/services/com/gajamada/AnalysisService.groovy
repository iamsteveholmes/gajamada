package com.gajamada

import grails.events.Listener


class AnalysisService {

    @Listener(namespace="gorm", topic = 'afterInsert')
    void afterInsertClusterState(ClusterState clusterState){
        //grow...shrink...what?
    }

    @Listener(namespace="gorm", topic = 'afterInsert')
    void afterInsertJobState(JobState jobState){
        //grow...shrink...what?
    }
}
