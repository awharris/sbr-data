#!/bin/bash

DIRECTORY=$(cd `dirname $0` && pwd)
hadoop fs -copyFromLocal -f "$DIRECTORY"/csv/*.csv /tmp

#bin/hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=a,b,c <tablename> <hdfs-inputdir>

#LEGAL_UNIT
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=d:ubrn,HBASE_ROW_KEY,d:ern,d:crn,d:name,d:trading_style,d:address1,d:address2,d:address3,d:address4,d:address5,d:postcode,d:sic07,d:paye_jobs,d:turnover,d:legal_status,d:trading_status,d:birth_date,d:death_date,d:death_code,d:uprn -Dimporttsv.separator=, LEGAL_UNIT /tmp/Legal_Unit.csv

#VAT
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=d:vatref,HBASE_ROW_KEY,d:ubrn,d:sic07,d:turnover,d:record_type,d:legalstatus,d:nameline,d:tradstyle,d:address1,d:address2,d:address3,d:address4,d:address5,d:postcode -Dimporttsv.separator=, VAT /tmp/VAT.csv

#PAYE
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=d:payeref,HBASE_ROW_KEY,d:ubrn,d:dec_jobs,d:mar_jobs,d:june_jobs,d:sept_jobs,d:jobs_lastupd,d:legalstatus,d:stc,d:nameline,d:tradstyle,d:address1,d:address2,d:address3,d:address4,d:address5,d:postcode -Dimporttsv.separator=, PAYE /tmp/PAYE.csv

#ENT
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=d:entref,d:ern,HBASE_ROW_KEY,d:name,d:trading_style,d:address1,d:address2,d:address3,d:address4,d:address5,d:postcode,d:legal_status,d:sic07 -Dimporttsv.separator=, ENTERPRISE /tmp/Enterprise.csv

#REPORTING_UNIT
#TABLE_NAME="REPORTING_UNIT" sh truncate_table.sh
#hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=D:rurn,HBASE_ROW_KEY,d:ruref,d:ern,d:entref,d:rusic07,d:employees,d:employment,d:turnover,d:prn,d:legal_status,d:region,d:name,d:trading_style,d:address1,d:address2,d:address3,d:address4,d:address5,d:postcode -Dimporttsv.separator=, REPORTING_UNIT /tmp/Reporting_Unit.csv


echo ""
echo ""
hbase shell <<-EOT
    count 'VAT'
    count 'PAYE'
    count 'LEGAL_UNIT'
	count 'ENTERPRISE'
	count 'LOCAL_UNIT'
	count 'REPORTING_UNIT'
	exit
EOT
