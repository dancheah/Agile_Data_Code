/* Set Home Directory - where we install software */
%default HOME `echo /home/dc/workplace/jars`

REGISTER $HOME/mongo-java-driver-2.11.3.jar
REGISTER $HOME/mongo-hadoop-core-1.1.0.jar
REGISTER $HOME/mongo-hadoop-pig-1.1.0.jar

set mapred.map.tasks.speculative.execution false
set mapred.reduce.tasks.speculative.execution false

sent_counts = LOAD '/tmp/sent_counts.txt' AS (from:chararray, to:chararray, total:long);
STORE sent_counts INTO 'mongodb://localhost/agile_data.sent_counts' USING com.mongodb.hadoop.pig.MongoStorage();
