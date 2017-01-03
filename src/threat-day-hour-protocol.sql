/*
Select and count all threats, grouped by day, hour, protocol.

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
