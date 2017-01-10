#!/usr/bin/perl
# = sql2table-rows.pl
# Convert SQL output to HTML table rows.
#
# == Copyright
# Copyright (c)2017 Ridgeback Network Defense, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# == Sample Usage
# sqlite3 /var/opt/ridgeback/ridgeback.db < threat-day-hour-protocol.sql | sql2table-rows.pl
#
# == Input Format
# For i = 1 to n, where n is the number of columns:
# VALUE-1[|VALUE-i]*
#
# == Output Format
# For i = 1 to n, where n is the number of columns:
# <tr><td>VALUE-1</td>[<td>VALUE-i</td>]*</tr>
# Blank lines are not output.
#

my $row = 0;
while ($line = <>) {
    chomp $line;
    if (length($line) > 0) {
        my $class = (($row % 2) == 0) ? "odd" : "even";
        my $col = 0;
        $line =~ s!\|!</td><td>!g;
        $line =~ s!^(.*)$!<tr class="$class"><td>$1</td></tr>!;
        $line =~ s!<td>!"<td class=\"col-".$col++."\">"!ge;
        print "$line\n";
        $row++;
    } # if
} # while
