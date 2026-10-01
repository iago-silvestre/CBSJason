#!/bin/bash
clear
# Check if the parameter is provided
if [ $# -ne 1 ]; then
  echo "at least one <integer> param is required"
  exit 1
fi
# Store the input parameter
count=$1
count=$((count - 1))
cp MarsEnvCritical.jaBAA MarsEnvCritical.java
cp buildLC.gradle build.gradle

for ((k=0; k<=0; k++))
do
	runId="lc$k"
	cp runs/$runId ./marsPrjCritical.mas2j
	echo "  "
	echo "Begin '$runId' "
	for ((i=0; i<=count; i++))
	do
		echo "RUN $runId - $i/$count"
		start_time=$(date +%s)
		./gradlew run -q --console=plain  > /dev/null #> $runId-$i.tmp
#		jason marsPrjCritical.mas2j > /dev/null #> $runId-$i.tmp 
		end_time=$(date +%s)
		elapsed_time=$((end_time - start_time))
		echo "Elapsed time (in seconds): $elapsed_time " 
		echo "Elapsed time (in seconds): $elapsed_time " >> reacTimes.log
		echo " "
#		more reacTimes.log
		mv reacTimes.log Bypass-$runId-$i.reacTimes.log.txt
		#mv reacTimes.log $k-$i-Bypass.reacTimes.log.txt
		mv mas-0.log mas-0.log.$i
		echo " "
		#sleep 5
		#echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null
		sleep 5
	done
#	python3 parseStdJ.py $count > $runId.log.txt
#	more $runId.log.txt
#	tar czvf $runId.tar.gz mas-* 
	rm mas-*
	echo "End '$runId' "
done
mv Bypass-* results
rm MarsEnvCritical.java
rm build.gradle
echo "Experiment FINISHED"
