/*
= hosts-contacting-decoys.sql
Select and count all hosts contacting decoys, over the last 24 hours.

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
sqlite3 /var/opt/ridgeback/ridgeback.db < hosts-contacting-decoys.sql

== Output Format
IP|MAC|PROTO|COUNT

IP:: host IP address
MAC:: host MAC address
PROTO:: protocol
COUNT:: times decoys contacted

== Sample output
010.000.000.006|b8:2a:72:00:00:06|icmp|47
010.000.000.008|b8:2a:72:00:00:08|arp|45
010.000.000.010|b8:2a:72:00:00:0a|arp|42
010.000.000.017|b8:2a:72:00:00:11|arp|44
010.000.000.019|b8:2a:72:00:00:13|tcp|42
*/

SELECT
    "src_ip",
    "src_mac",
    "proto",
    count(*)
FROM
    "log"
WHERE
    (
        ("dst_sim" == 1) OR
        ("threat" is not null)
    ) AND
    (("time" / 1000) >= (strftime('%s','now') - (1 * 86400.0)))
GROUP BY
    "src_ip",
    "src_mac",
    "proto"
ORDER BY
    "src_ip"
;
