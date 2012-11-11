import com.gajamada.Cluster
import com.gajamada.ClusterRun
import com.gajamada.Job

class BootStrap {

    def init = { servletContext ->

        Job copyData = new Job(name: 'Copy Data Job').save(flush:  true)
        Job createBotlessTable = new Job(name: 'Create Botless Data Job').save(flush:  true)
        Job recommendations = new Job( name: 'Recommendations Job' ).save( flush:  true )
        Job pricing = new Job( name:  'Pricing Job' ).save( flush:  true )

        Cluster filterBotsCluster = new Cluster(name: 'Filter Bots Cluster').addToJobs( copyData ).addToJobs( createBotlessTable ).save(flush: true)
        Cluster recommendationsCluster = new Cluster( name: 'Recommendations Cluster' ).addToJobs( copyData ).addToJobs( createBotlessTable ).addToJobs( recommendations ).save( flush:  true )
        Cluster pricingCluster = new Cluster( name: 'Pricing Cluster' ).addToJobs( copyData ).addToJobs( createBotlessTable ).addToJobs( pricing ).save( flush: true )

        ClusterRun filter1 = new ClusterRun( clusterId: 'j-1hd145o5').save(flush: true)
        filterBotsCluster.addToRuns( filter1 ).save(flush: true)
        ClusterRun recommendations1 = new ClusterRun( clusterId: 'j-28gbs-2j').save(flush: true)
        ClusterRun recommendations2 = new ClusterRun( clusterId: 'j-dfgjgw73').save(flush: true)
        recommendationsCluster.addToRuns( recommendations1 ).addToRuns(recommendations2).save(flush:  true)
        ClusterRun pricing1 = new ClusterRun( clusterId: 'j-asdf79sh' ).save(flush: true)
        pricingCluster.addToRuns(pricing1).save(flush: true)
    }
    def destroy = {
    }
}
