#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/Jaime.data.2018
#$ -l h_rt=12:00:00,h_data=8G,highp
#$ -o /u/scratch/d/dechavez/rails.project/log/rmBad
#$ -e /u/scratch/d/dechavez/rails.project/log/rmBad
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load samtools

## SAMTOOLS=/u/home/j/jarobins/project-rwayne/utils/programs/samtools-1.3.1/samtools
IN_DIR=/u/scratch/d/dechavez/rails.project/Jaime.data.2018
OUT_DIR=/u/scratch/d/dechavez/rails.project/Jaime.data.2018

samtools view -hb -f 2 -F 256 -q 30 ${IN_DIR}/${1} | samtools view -hb -F 1024 > ${OUT_DIR}/${1%.bam}_Filtered.bam

source /u/local/Modules/default/init/modules.sh
module load java

PICARD=/u/local/apps/picard-tools/current/picard.jar

java -jar -Xmx5g -Djava.io.tmpdir=/u/scratch/d/dechavez/temp ${PICARD} BuildBamIndex \
VALIDATION_STRINGENCY=LENIENT TMP_DIR=/u/scratch/d/dechavez/temp \
I=${OUT_DIR}/${1%.bam}_Filtered.bam 
