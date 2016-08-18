#!/usr/bin/perl

# Password hashes in md5 format
# Gary Alexander
# 02 Feb 2014

use strict;
use warnings;

use Getopt::Long qw(GetOptions);

my $passwd;
GetOptions('passwd=s' => \$passwd) or die "Usage: $0 --passwd PASSWORD\n";

if ($passwd eq '') {
    print "$0: No password specified.\n";
    print "Usage: $0 --passwd PASSWORD\n";
    print "Using random password...\n\n";
    my (@pwchars) = ('a'..'z','A'..'Z','0'..'9');
    $passwd .= $pwchars[rand @pwchars] for 1..12;
}

my (@chars) = ('a'..'z','A'..'Z','0'..'9','.','/');

sub md5_salt
{
    my ($return) = '$6$';

    $return .= $chars[rand($#chars+1)] foreach (0..7);
    return $return;
}
my $salt = md5_salt();
my $encpasswd = crypt $passwd, $salt;

print "Password: $passwd\nEncrypted: $encpasswd\nSalt: $salt\n"
