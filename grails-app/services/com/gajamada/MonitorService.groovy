package com.gajamada

import org.quartz.TriggerBuilder
import org.quartz.core.QuartzScheduler

import grails.events.Listener
import grails.plugin.quartz2.ClosureJob

class MonitorService {

    QuartzScheduler quartzScheduler

    //private static Map<String, JobKey> jobCache = new HashMap<String, JobKey>()

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

        def dataMap

        def jobDetail = ClosureJob.createJob(name:"quartz-${clusterRun.clusterId}",durability:true,concurrent:false){ jobCtx, appCtx->
            queryState(clusterRun)
        }
        jobDetail.jobData = [gormSession:false]

        jobDetail.key

        def trigger = TriggerBuilder.newTrigger().withIdentity("trigger-${clusterRun.clusterId}")
            .withSchedule(
                simpleSchedule()
                .withIntervalInMilliseconds(10)
                .withRepeatCount(2)
            ).startNow().build()

        quartzScheduler.scheduleJob(jobDetail, trigger)
    }

    /*@Listener(topic = 'shutdown-cluster')
    void shutDownMonitor(ClusterRun clusterRun){
        quartzScheduler.unscheduleJob(quartzScheduler."trigger-${clusterRun.clusterId}")
    }*/
}
