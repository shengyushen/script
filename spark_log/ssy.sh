cd /opt/spark/data/
hadoop fs -mkdir /seqdata

bwa index -a bwtsw human_g1k_v37.fasta
# generate dict
gatk CreateSequenceDictionary -R human_g1k_v37.fasta -O human_g1k_v37.dict
# compare
bwa mem -M -t 96 human_g1k_v37.fasta SRR742200_1.fastq SRR742200_2.fastq > SRR742200.sam
# reorder
gatk ReorderSam -I SRR742200.sam -O SRR742200_reorder.bam -R human_g1k_v37.fasta
hadoop fs -put SRR742200_reorder.bam /seqdata
#sort
gatk SortReadFileSpark -I hdfs://spark01:9000/seqdata/SRR742200_reorder.bam -O hdfs://spark01:9000/seqdata/SRR742200_sorted.bam -- --spark-runner SPARK --spark-master spark://spark01:7077 
hadoop fs -get /seqdata/SRR742200_sorted.bam ./
# prefix
gatk AddOrReplaceReadGroups -I SRR742200_sorted.bam -O SRR742200_header.bam -LB lib1 -PL illumina -PU unit1 -SM 20
hadoop fs -put SRR742200_header.bam /seqdata
# dedup
gatk MarkDuplicatesSpark -I hdfs://spark01:9000/seqdata/SRR742200_header.bam -O hdfs://spark01:9000/seqdata/SRR742200_markdup.bam --bam-partition-size 100000 -- --spark-runner SPARK --spark-master spark://spark01:7077
# BQSR
cd /opt/spark/2bit
hadoop fs -put dbsnp132_20101103.vcf /seqdata
hadoop fs -put human_g1k_v37.fasta.2bit /seqdata
gatk BQSRPipelineSpark -I hdfs://spark01:9000/seqdata/SRR742200_markdup.bam -R hdfs://spark01:9000/seqdata/human_g1k_v37.fasta.2bit -O hdfs://spark01:9000/seqdata/SRR742200_bqsr.bam --known-sites hdfs://spark01:9000/seqdata/dbsnp132_20101103.vcf --disable-sequence-dictionary-validation true --bam-partition-size 100000 -- --spark-runner SPARK --spark-master spark://spark01:7077
#HC
gatk HaplotypeCallerSpark -R hdfs://spark01:9000/seqdata/human_g1k_v37.fasta.2bit -I hdfs://spark01:9000/seqdata/SRR742200_bqsr.bam -O hdfs://spark01:9000/seqdata/SRR742200_snp.raw.vcf --bam-partition-size 100000 -- --spark-runner SPARK --spark-master spark://spark01:7077


