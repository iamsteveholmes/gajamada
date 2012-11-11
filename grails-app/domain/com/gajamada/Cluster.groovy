package com.gajamada

class Cluster {

    static hasMany = [jobs: Job, runs: ClusterRun]
}
