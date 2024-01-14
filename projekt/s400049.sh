#!/bin/bash

###################################################
# 
# Author: Konrad Bujak
# Creation Date: 04-01-2024
#
# Description:
# This script downloads .zip archive from http://home.agh.edu.pl/~wsarlej/dyd/bdp2/materialy/cw10/InternetSales_new.zip, 
# unzips downloaded file and performs validation. Then validated records are inserted into newly created table 
# in postgre database. Script updates column SecretCode and exports updated row to .csv file which is then added to archive
# 
# Changelog:
# Version 1.0 - Initial release
#
###################################################


#Basic Data
ZIP_PSSWD="bdp2agh"
ZIP_NAME="InternetSales_new.zip"
ZIP_URL="http://home.agh.edu.pl/~wsarlej/dyd/bdp2/materialy/cw10/InternetSales_new.zip"
FILE_NAME="InternetSales_new.txt"
TIMESTAMP=$(date +%m%d%Y)
LOG_FILE="./PROCESSED/s400049_${TIMESTAMP}.log"
HEADER=header.txt
TMP="tmp.txt"
TMP2="tmp2.txt"
BAD_ROWS="$(basename "$FILE_NAME" .txt).bad_${TIMESTAMP}"
OUTPUT_FILE="./PROCESSED/${TIMESTAMP}_${FILE_NAME}"


#Databases data
NRINDEKSU=400049
PSQL_USER=postgres
PSQL_PSSWD=admin
PSQL_HOST=localhost
PSQL_PORT=5432
PSQL_TABLE=CUSTOMERS_$NRINDEKSU
PSQL_CREATE="./create_table.sql" 
PSQL_UPDATE="./update_table.sql" 



function reset_tmp_files {
  mv $TMP2  $TMP
}

function log_msg {
if [ $? -ne 0 ] 
then
    echo "$(date +%Y%m%d%H%M%S) - $1 - Failure" >> $LOG_FILE
    exit 1
else
    echo "$(date +%Y%m%d%H%M%S) - $1 - Succesful" >> $LOG_FILE
fi
}

mkdir -p ./PROCESSED
echo -e "\nStart of Processing - $(date +%Y%m%d%H%M%S)\n---------------------------------------------\n" > $LOG_FILE

# Download file
wget $ZIP_URL -q -nc

log_msg "Download step"

#Unzip downloaded archive
unzip -q -u -P $ZIP_PSSWD $ZIP_NAME

log_msg "Unzip step"

# Remove header and save it to variable. Remove empty lines
read -r firstline<$FILE_NAME
sed '1d' $FILE_NAME > $TMP
sed -i '/^$/d' $TMP
log_msg "Remove empty lines"

#Remove duplicate rows


sort $TMP | uniq -d > $BAD_ROWS
sort $TMP | uniq | tee > $TMP2

log_msg "Remove duplicates"
reset_tmp_files

#Remove rows where do not have the same number of columns as in header
num_columns=$(echo "$firstline" | awk -F '|' '{print NF}')

awk -v num_columns="$num_columns" -v header="$firstline" -F '|' 'NF != num_columns'  $TMP >> $BAD_ROWS
awk -v num_columns="$num_columns" -v header="$firstline" -F '|' 'NF == num_columns' $TMP > $TMP2

log_msg "Remove rows not matching with header"
reset_tmp_files

#Remove rows where OrderQuantity value is greater than 100
awk -F '|' '($5 > 100)'  $TMP >> $BAD_ROWS
awk -F '|' '($5 <= 100)' $TMP > $TMP2

log_msg "Remove rows with wrong OrderQuantity"
reset_tmp_files

#Remove rows which got any value in SecretCode
awk  -F '|' 'BEGIN {OFS = FS} ($7) {$7=""; print $0}' $TMP >> $BAD_ROWS
awk -F '|' '(!$7)' $TMP > $TMP2

log_msg "Remove rows with value in SecretCode"
reset_tmp_files

#Remove rows which do not match pattern 'FirstName,LastName' in CustomerName column
awk  -F '|' '{ split($3, CustomerKey, ","); if (length(CustomerKey) != 2) print $0 }' $TMP >> $BAD_ROWS
awk  -F '|' '{ split($3, CustomerKey, ","); if (length(CustomerKey) == 2) print $0 }' $TMP > $TMP2

log_msg "Remove rows with value in CustomerName"
reset_tmp_files

#Split CustomerName into two new columns FirstName, LastName

#add column
awk  -F '|' 'BEGIN {OFS = FS}{$3 = $3 OFS value}1' $TMP > $TMP2
reset_tmp_files
#modify value
awk -F '|' 'BEGIN {OFS = FS}{ split($3, CustomerKey, ","); if (length(CustomerKey) == 2) { $3=CustomerKey[1]; $4=CustomerKey[2]; } print }' $TMP | tr -d '"' > $TMP2

log_msg "Split CustomerName into two new columns"
reset_tmp_files

#Add new header to file

awk -F '|' 'BEGIN {OFS = FS}{$3 = $3 OFS value}1' <<< $firstline | cat - $TMP > $TMP2
reset_tmp_files

col3="FIRST_NAME"
col4="LAST_NAME"

awk -F '|' -v col3="$col3" -v col4="$col4" 'NR==1 {OFS = FS; $3=col3; $4=col4} {print}'  $TMP > $TMP2
reset_tmp_files

#Prepare and load to database

psql_conn_str="postgresql://$PSQL_USER:$PSQL_PSSWD@$PSQL_HOST:$PSQL_PORT/postgres"

psql -q $psql_conn_str -f $PSQL_CREATE 

log_msg "Preparing postgres database"

#change comma to point for import and move to /PROCESSED with timestamp
sed -i 's/,/./g' $TMP 
mv $TMP $OUTPUT_FILE

psql -q $psql_conn_str -c "\COPY $PSQL_TABLE FROM $OUTPUT_FILE DELIMITER '|' CSV HEADER;"
log_msg "Import validated file"

#Update SecretCode with random value

psql -q $psql_conn_str -f $PSQL_UPDATE 

log_msg "Update Secret Code"

# Export final table
psql -q $psql_conn_str -c "\COPY $PSQL_TABLE TO './PROCESSED/$PSQL_TABLE.csv' DELIMITER '|' CSV HEADER;"

log_msg "Export $PSQL_TABLE table to .csv file"

# Add .csv file to archive

zip -q ./PROCESSED/$PSQL_TABLE.zip ./PROCESSED/$PSQL_TABLE.csv
log_msg "Add $PSQL_TABLE to archive"

echo Script completed without errors. For more information check $LOG_FILE