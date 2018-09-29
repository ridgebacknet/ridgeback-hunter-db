#!/usr/bin/perl
# = sql2table-rows.pl
# Convert SQL output to HTML table rows.
#
# == Copyright
# Copyright (c)2017 Ridgeback Network Defense, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
