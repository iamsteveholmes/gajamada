package com.gajamada

class Job {

    String name
    static hasMany = [runs: JobRun]
}
