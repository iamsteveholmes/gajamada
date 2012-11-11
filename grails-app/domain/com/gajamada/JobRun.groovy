package com.gajamada

class JobRun {

    String jobId
    static hasMany = [jobStates: JobState]
}
