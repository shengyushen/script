#grep "Event.*SparkListenerTaskEnd.*Stage ID\":15," $1 > $1.1.ll
#grep "Event.*SparkListenerTaskEnd.*Stage ID\"" $1 > $1.1.ll
# taskID launchTime FinishTime duration DesTime ShfRead GetResultTime GCTime ResSerTime ShfWrite
#awk '{match($0,/\"Task ID\":([0-9]+)/,arr);printf arr[1] " " ;match($0,/\"Launch Time\":([0-9]+)/,arr);printf arr[1] " " ;lt=arr[1];match($0,/\"Finish Time\":([0-9]+)/,arr);printf arr[1] " "; printf arr[1]-lt " " ;match($0,/\"Executor Deserialize Time\":([0-9]+)/,arr);printf arr[1] " " ;match($0,/\"Fetch Wait Time\":([0-9]+)/,arr);printf arr[1] " "; match($0,/\"Getting Result Time\":([0-9]+)/,arr);printf arr[1] " ";match($0,/\"JVM GC Time\":([0-9]+)/,arr);printf arr[1] " ";match($0,/\"Result Serialization Time\":([0-9]+)/,arr);printf arr[1] " ";match($0,/\"Shuffle Write Time\":([0-9]+)/,arr);printf arr[1] " ";print ""}' $1.1.ll > $1.2.ll
awk '{dur=dur+$4;des=des+$5;shfread=shfread+$6;getres=getres+$7;gctime=gctime+$8;resser=resser+$9;shfwrite=shfwrite+$10} END{print "des " des/dur " shfread " shfread/dur " getres " getres/dur " gctime " gctime/dur  " resser " resser/dur }' $1.2.ll
