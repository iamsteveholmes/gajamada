package com.gajamada

class ClusterRun {

    String clusterId
    static hasMany = [states: ClusterState]
}