#!/home/utils/perl-5.12/5.12.1-nothreads-64/bin/perl
sub PRINT
{
    my $print_level=$ENV{'PERL_PRINT_LEVEL'};
    my ($cur_prtlvl, $prt_line)=@_;
    if ($print_level>=$cur_prtlvl) {
        print "[$0 level $cur_prtlvl:] $prt_line\n";
    }
}

return 1;

