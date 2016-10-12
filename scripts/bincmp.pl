#!/home/utils/perl-5.12/5.12.1-nothreads-64/bin/perl
use Getopt::Long;
unshift (@INC, $ENV{'PERL_INC_PATH'});
require "comlib.pl";

GetOptions(
 'verbose!' => \$verbose
,'help!' => \$help
 ) || usage("invalid options");

sub usage
{
  die <<EOF;
  Usage: $0 <file1> <file2>
  options:
    -verbose            show the verbose information for debug
    -help   	        this infomation
@_
EOF
}


if ($help) {
    usage();
    return 0;
}
if ($#ARGV!=1) {
    usage("There are ($#ARGV+1) args! Expectation is 2");
    return 0;
}

my $file1=$ARGV[0];
my $file2=$ARGV[1];


PRINT(5,"comparing file1: $file1         &             file2: $file2");

if (! -e $file1) {
    PRINT(0,"file1: $file1 doesn't exist");
}
if (! -e $file2) {
    PRINT(0,"file2: $file2 doesn't exist");
}

`hexdump -v -e '3/1 "%02x," "\n"' $file1 > $file1.hex`;
`hexdump -v -e '3/1 "%02x," "\n"' $file2 > $file2.hex`;

$difference=`diff $file1.hex $file2.hex`;

if ($difference) {
    PRINT(0,"$file1 and $file2 are DIFFERENT");
    if ($verbose) {
        `bcompare $file1.hex $file2.hex`;
    }
    else {
        `rm -rf $file1.hex $file2.hex`;
    }
}
else {
    PRINT(0,"$file1 and $file2 are the SAME");
}

