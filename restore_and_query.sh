#!/bin/sh
set -eu

DUMP_PATH="/tmp/dump.sql.gz"

echo "Fetching dump..."
curl -sS "https://hackattic.com/challenges/backup_restore/problem?access_token=${ACCESS_TOKEN}" \
  | jq -r .dump \
  | base64 -d > ${DUMP_PATH}

echo "Restoring dump into db..."
zcat ${DUMP_PATH} | psql -h "${PGHOST}" -U "${PGUSER}" -d "${PGDATABASE}"

echo "Querying ssn with status = 'alive'..."
psql -h "${PGHOST}" -U "${PGUSER}" -d "${PGDATABASE}" -t \
    -c "SELECT json_build_object('alive_ssns', json_agg(ssn)) FROM public.criminal_records WHERE status = 'alive';" > ssns.json

echo "Contents of ssns.json:"
jq . ssns.json

echo "Sending ssns back to Hackattic..."
curl -s -X POST "https://hackattic.com/challenges/backup_restore/solve?access_token=${ACCESS_TOKEN}&playground=1" \
    -H "Content-Type: application/json" \
    -d @ssns.json
