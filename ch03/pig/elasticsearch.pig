/* Set Home Directory - where we install software */
%default HOME `echo /Users/dc/workplace/jars`

/* Avro uses json-simple, and is in piggybank until Pig 0.12, where AvroStorage and TrevniStorage are builtins */
REGISTER $HOME/avro-1.7.4.jar
REGISTER $HOME/json-simple-1.1.jar
REGISTER $HOME/piggybank.jar

DEFINE AvroStorage org.apache.pig.piggybank.storage.avro.AvroStorage();

/* Elasticsearch's own jars */
REGISTER /opt/personal/pkg/elasticsearch/lib/*.jar

/* Register wonderdog - elasticsearch integration */
REGISTER $HOME/wonderdog-1.0-SNAPSHOT.jar

/* Remove the old json */
rmf /tmp/sent_count_json

/* Nuke the elasticsearch sent_counts index, as we are about to replace it. */
sh curl -XDELETE 'http://localhost:9200/inbox/sent_counts'

/* Load Avros, and store as JSON */
sent_counts = LOAD '/tmp/sent_counts.txt' AS (from:chararray, to:chararray, total:long);
STORE sent_counts INTO '/tmp/sent_count_json' USING JsonStorage();

/* Now load the JSON as a single chararray field, and index it into ElasticSearch with Wonderdog from InfoChimps */
sent_count_json = LOAD '/tmp/sent_count_json' AS (sent_counts:chararray);
STORE sent_count_json INTO 'es://inbox/sentcounts?json=true&size=1000' USING com.infochimps.elasticsearch.pig.ElasticSearchStorage(
  '/opt/personal/pkg/elasticsearch/config/elasticsearch.yml', 
  '/opt/personal/pkg/elasticsearch/plugins');

/* Search for Hadoop to make sure we get a hit in our sent_count index */
sh curl -XGET 'http://localhost:9200/inbox/sentcounts/_search?q=russell&pretty=true&size=1'
