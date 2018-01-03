/*
= decoy-on-ip.sql
Select all endpoints contacting a decoy on a specific IP address.

== Copyright
Copyright (C)2018 Ridgeback Network Defense, Inc.

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
sqlite3 /var/opt/ridgeback/ridgeback.db < decoy-on-ip.sql

== Output Format
IP|MAC|PROTO|PORT|COUNT

IP:: host IP address contacting decoy
MAC:: host MAC address contacting decoy
PROTO:: protocol
PORT:: destination port, if applicable
COUNT:: times decoy contacted

== Sample Outputs

Example 1:

----
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.039|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.041|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.057|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.062|icmp||2
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.071|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.073|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.086|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.088|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.093|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.100|icmp||1
010.000.000.030|b8:2a:72:00:00:1e|010.000.000.103|icmp||1
----

Example 2:

----
010.000.000.004|b8:2a:72:00:00:04|010.000.000.072|tcp|7884|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.074|tcp|7|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.085|tcp|80|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.092|tcp|4515|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.094|tcp|80|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.106|tcp|7|2
010.000.000.004|b8:2a:72:00:00:04|010.000.000.112|tcp|80|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.115|tcp|80|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.119|tcp|6273|1
010.000.000.004|b8:2a:72:00:00:04|010.000.000.122|tcp|7|1
----

*/

SELECT
        "src_ip",
        "src_mac",
        "dst_ip",
        "proto",
        "dst_port",
        count(*)
FROM
        "log"
WHERE
        (
                ("src_ip" == "010.000.000.030") AND
                ("dst_sim" == "1")
        )
GROUP BY
      "src_ip",
      "src_mac",
      "dst_ip",
      "proto",
      "dst_port"
ORDER BY
      "src_ip"
;
