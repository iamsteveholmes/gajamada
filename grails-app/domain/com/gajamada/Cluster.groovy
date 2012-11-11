package com.gajamada

class Cluster {

    String name

    static hasMany = [jobs: Job, runs: ClusterRun]
}
