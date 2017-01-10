/*
= hosts-contacting-decoys.sql
Select and count all hosts contacting decoys, over the last 24 hours.

== Copyright
Copyright (c)2017 Ridgeback Network Defense, Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
