/*
= mac-ip-joined.sql
All MAC addresses and IP addresses that joined the network in the last 24 hours.

== Copyright
Copyright (c)2017 Ridgeback Network Defense, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

== Sample Usage
sqlite3 /var/opt/ridgeback/ridgeback.db < threat-day-hour-protocol.sql

== Output Format
YYYY-MM-DD HH:MM:SS|IP|MAC|T

YYYY:: year
MM:: month (1-12)
DD:: day (1-31)
HH:: hour (0-23)
MM:: minute (0-59)
SS:: second (0-59)
IP:: IP address
MAC:: MAC address
T:: UTC timestamp in Unix epoch milliseconds

== Sample output
2017-01-03 23:38:19|010.000.000.123|b8:2a:72:00:00:7b|1483504699952
2017-01-03 23:38:20|010.000.000.248|b8:2a:72:00:00:f8|1483504700053
2017-01-03 23:38:20|010.000.000.089|b8:2a:72:00:00:59|1483504700154
2017-01-03 23:38:20|010.000.000.075|b8:2a:72:00:00:4b|1483504700255
2017-01-03 23:38:20|010.000.000.219|b8:2a:72:00:00:db|1483504700859
2017-01-03 23:38:21|010.000.000.076|b8:2a:72:00:00:4c|1483504701060

FIXME: Need to double check this SQL statement. Looking for 1st occurance.

*/

SELECT
    "src_sim",
    strftime('%Y-%m-%d %H:%M:%S UTC',
        datetime("time"/1000, 'unixepoch', 'utc')),
    "src_ip",
    "src_mac",
    MIN("time")
        AS "t"
FROM "log"
WHERE "id" IN
(
    SELECT
        "id"
    FROM "log"
    WHERE
        ("src_sim" IS NULL) AND
        (("time"/1000) >= (strftime('%s','now') - (1 * 86400)))
)
GROUP BY
    "src_ip",
    "src_mac"
;
