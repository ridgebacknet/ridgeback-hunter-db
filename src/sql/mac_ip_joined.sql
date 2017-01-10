/*
= mac-ip-joined.sql
All MAC addresses and IP addresses that joined the network in the last 24 hours.

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
