#!/bin/bash

# This shell script will truncate an HBase table.
# All HBase daemons must be running before you execute this.
# The script is idempotent, as we check for (and delete) any
# existing table, after which a new table is created

# check for a previous table, and delete it if one exists
truncate_table=$(echo "exists '$TABLE_NAME'" | hbase shell 2>/dev/null | grep 'does not exist' >/dev/null 2>&1)
if [ $? != 0 ]; then
	echo "Truncating existing table '$TABLE_NAME' from HBase"
	hbase shell <<-EOT
		truncate '$TABLE_NAME'
		exit
	EOT
fi

echo ""
echo ""
echo "HBase table '$TABLE_NAME' is now empty"