import com.gajamada.ClusterState
import com.gajamada.JobState

events = {
    'afterInsert' browser:true, namespace:'gorm', filter:ClusterState
    'afterInsert' browser:true, namespace:'gorm', filter:JobState
}