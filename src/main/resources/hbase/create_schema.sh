#!/bin/bash

# This shell script will create all HBase tables for the
# Business Register.
# All HBase daemons must be running before you execute this.
# The script is idempotent, as we check for (and delete) any
# existing tables, after which new tables are created.

# check for a previous table, and delete it if one exists
create_table() {
TABLE_NAME=$1
$(echo "exists '$TABLE_NAME'" | hbase shell 2>/dev/null | grep 'does not exist' >/dev/null 2>&1)
if [ $? != 0 ]; then
	echo "Removing existing table '$TABLE_NAME' from HBase"
	hbase shell <<-EOT
		disable '$TABLE_NAME'
		drop '$TABLE_NAME'
		exit
	EOT
fi

echo "Creating and populating the '$TABLE_NAME' table in HBase"
hbase shell <<-EOT
	create '$TABLE_NAME', {NAME => 'd', REPLICATION_SCOPE => 1}, {NAME => 'h', REPLICATION_SCOPE => 1}
	exit
EOT

echo ""
echo ""
echo "HBase table '$TABLE_NAME' is now created"
}


# read namespace
NAMESPACE=$1

# check for a previous table, and delete it if one exists
create_table "$NAMESPACE:ENTERPRISE_GROUP"
create_table "$NAMESPACE:ENTERPRISE"
create_table "$NAMESPACE:LOCAL_UNIT"
create_table "$NAMESPACE:REPORTING_UNIT"
create_table "$NAMESPACE:LEGAL_UNIT"
create_table "$NAMESPACE:VAT"
create_table "$NAMESPACE:PAYE"
create_table "$NAMESPACE:CH"
