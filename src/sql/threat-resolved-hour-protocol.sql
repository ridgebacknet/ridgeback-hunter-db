/*
= threat-resolved-hour-protocol.sql
Select and count all threats over the last 24 hours, grouped by hour, protocol.

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
sqlite3 /var/opt/ridgeback/ridgeback.db < threat-resolved-hour-protocol.sql

== Output Format
YYYY-MM-DD|HH|PROTO|COUNT

YYYY:: year
MM:: month (1-12)
DD:: day (1-31)
HH:: hour (0-23)
PROTO:: protocol
COUNT:: how many threats seen

== Sample output
2017-01-04|01|arp|41
2017-01-03|21|arp|85
2017-01-03|21|tcp|42
2017-01-03|23|icmp|41
*/

SELECT
    strftime('%Y-%m-%d', datetime("time"/1000, 'unixepoch', 'utc'))
        AS "day",
    strftime('%H', datetime(time/1000, 'unixepoch', 'localtime'))
        AS "hour",
    "proto",
    count(*)
FROM "log"
WHERE
    (threat IS NOT NULL) AND
    (("time" / 1000) >= (strftime('%s','now') - 86400.0))
GROUP BY
    "hour",
    "proto"
;
