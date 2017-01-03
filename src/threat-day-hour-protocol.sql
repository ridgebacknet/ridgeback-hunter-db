/*
= threat-day-hour-protocol.sql
Select and count all threats, grouped by day, hour, protocol.

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
YYYY-MM-DD|HH|PROTO|COUNT

YYYY:: year
MM:: month (1-12)
DD:: day (1-31)
HH:: hour (0-23)
PROTO:: protocol
COUNT:: how many threats seen

== Sample output
2017-01-02|22|arp|87
2017-01-02|22|tcp|45
2017-01-02|23|arp|42
2017-01-02|23|icmp|42
*/

SELECT
    strftime('%Y-%m-%d', datetime(time/1000, 'unixepoch', 'localtime')) as day,
    strftime('%H', datetime(time/1000, 'unixepoch', 'localtime')) as hour,
    proto,
    count(*)
FROM log
WHERE
    threat is not null
GROUP BY
    day,
    hour,
    proto
;
