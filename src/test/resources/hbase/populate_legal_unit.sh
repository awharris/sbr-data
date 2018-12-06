#!/bin/bash

# This shell script will create and populate an HBase table.
# All HBase daemons must be running before you execute this.
# The script is idempotent, as we check for (and delete) the
# table from a previous run, after which a new table is created

TABLE_NAME='LEGAL_UNIT'

# The strange values in the 'annualbudget' column family are ints, but
# have been hex-encoded as required by the HBase shell.
echo "Creating and populating the '$TABLE_NAME' table in HBase"
hbase shell <<-EOT

	put '$TABLE_NAME', 'aj8462', 'contactinfo:fname', 'Alice'
	put '$TABLE_NAME', 'aj8462', 'contactinfo:mname', 'Jane'
	put '$TABLE_NAME', 'aj8462', 'contactinfo:lname', 'Ames'
	put '$TABLE_NAME', 'aj8462', 'contactinfo:mobile', '555-2182'
	put '$TABLE_NAME', 'aj8462', 'contactinfo:home', '555-3714'
	put '$TABLE_NAME', 'aj8462', 'annualbudget:movies', "\x00\x00\x00d"
	put '$TABLE_NAME', 'aj8462', 'annualbudget:concerts', "\x00\x00\x02\xEE"
	put '$TABLE_NAME', 'aj8462', 'annualbudget:travel', "\x00\x00\x13\x88"

	put '$TABLE_NAME', 'bb2988', 'contactinfo:fname', 'Bob'
	put '$TABLE_NAME', 'bb2988', 'annualbudget:concerts', "\x00\x00\x01\xF4"

	put '$TABLE_NAME', 'cs8701', 'contactinfo:fname', 'Carol'
	put '$TABLE_NAME', 'cs8701', 'contactinfo:mname', 'Sue'
	put '$TABLE_NAME', 'cs8701', 'contactinfo:lname', 'Clemens'
	put '$TABLE_NAME', 'cs8701', 'contactinfo:mobile', '555-2642'
	put '$TABLE_NAME', 'cs8701', 'annualbudget:concerts', "\x00\x00\x01\xF4"

	put '$TABLE_NAME', 'dd7235', 'contactinfo:fname', 'Dan'
	put '$TABLE_NAME', 'dd7235', 'contactinfo:lname', 'Davis'
	put '$TABLE_NAME', 'dd7235', 'contactinfo:home', '555-3421'
	put '$TABLE_NAME', 'dd7235', 'annualbudget:concerts', "\x00\x00\x01w"
	put '$TABLE_NAME', 'dd7235', 'annualbudget:travel', "\x00\x00\x03\xE8"

	put '$TABLE_NAME', 'ee5361', 'contactinfo:fname', 'Eve'
	put '$TABLE_NAME', 'ee5361', 'contactinfo:mname', 'A.'
	put '$TABLE_NAME', 'ee5361', 'contactinfo:lname', 'Ellis'
	put '$TABLE_NAME', 'ee5361', 'contactinfo:mobile', '555-3960'
	put '$TABLE_NAME', 'ee5361', 'annualbudget:movies', "\x00\x00\x00d"
	put '$TABLE_NAME', 'ee5361', 'annualbudget:travel', "\x00\x00\x09\xC4"

	exit
EOT

echo ""
echo ""
echo "HBase table '$TABLE_NAME' is now created and populated with data"