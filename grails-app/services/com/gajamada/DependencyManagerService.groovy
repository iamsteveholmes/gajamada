package com.gajamada
import org.grails.plugin.platform.events.EventReply

class DependencyManagerService {

    ClusterRun launchCluster(final Map params){

        EventReply reply = event( topic:'launch-cluster', data: new LaunchClusterEvent( params )).waitFor()

        ClusterRun clusterRun = new ClusterRun( clusterId: reply.value ).save()
    }

    JobRun launchJob(final Map params) {
        EventReply reply = event( topic:'launch-job', data: new LaunchClusterEvent( params )).waitFor()

        JobRun jobRun = new JobRun( jobId: reply.value ).save()
    }

    void shutDownCluster( ClusterRun clusterRun ){
        event( topic:  'shutdown-cluster', data: clusterRun )
    }

}
