#!/home/utils/perl-5.12/5.12.1-nothreads-64/bin/perl

my $file1=$ARGV[0];
`hexdump -v -e '3/1 "%02x," "\n"' $file1 > $file1.hex`;

