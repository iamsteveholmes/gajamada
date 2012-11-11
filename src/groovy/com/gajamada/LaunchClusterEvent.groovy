package com.gajamada

import groovy.transform.Immutable

@Immutable
class LaunchClusterEvent {

    Cluster cluster
    EMRType masterType
    EMRType slaveType
    int slaveInstances
}
