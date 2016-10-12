#!/home/utils/perl-5.12/5.12.1-nothreads-64/bin/perl
use Getopt::Long;
use Tie::File;

GetOptions(
 'clean' => \$clean
,'help!' => \$help
 ) || usage("invalid options");

sub usage
{
  die <<EOF;
  Usage: $0 <test dir> <options>
  options:
    -clean              clean up your test directory (delete *.hex and temporary files )
    -help               this infomation
@_
EOF
}

if ($help) {
    usage();
    return 0;
}

if ($clean) {

  `rm @ARGV[0]/rtl/*.hex | rm @ARGV[0]/csim/*.hex`;
  }

else {




my @rtlfile_list = `find @ARGV[0]/rtl/. -name "dumprtl_*"`;
my @csimfile_list = `find @ARGV[0]/csim/. -name "dump_*"`;

chomp (@rtlfile_list);
chomp (@csimfile_list);



## Translate *.rgb to *.hex

foreach $rtlfile (@rtlfile_list) {
    `hexdump -v -e '3/1 "%02x, " "\n"' $rtlfile > $rtlfile.hex`;
}


foreach $csimfile (@csimfile_list) {
    `hexdump -v -e '3/1 "%02x, " "\n"' $csimfile > $csimfile.hex`;
}


## Compare *.hex between CSIM and RTL

my @csim_hex = ("dump_wA_hscale_fil.hex","dump_wA_hscale_nofilt.hex",
                "dump_wB_hscale_fil.hex","dump_wB_hscale_nofilt.hex",
                "dump_wC_hscale_fil.hex","dump_wC_hscale_nofilt.hex",
                "dump_wA_1516to18.hex", "dump_wB_1516to18.hex", "dump_wC_1516to18.hex",
                "dump_wA_vscale.hex","dump_wB_vscale.hex","dump_wC_vscale.hex",
                "dump_wA_csc.hex","dump_wB_csc.hex","dump_wC_csc.hex",
                "dump_wA_dv.hex","dump_wB_dv.hex","dump_wC_dv.hex",
                "dump_dither.hex");

my @rtl_hex = ("dumprtl_wa0_hfilt_out.hex","dumprtl_wa0_hscale_out.hex",
               "dumprtl_wb0_hfilt_out.hex","dumprtl_wb0_hscale_out.hex",
               "dumprtl_wc0_hfilt_out.hex","dumprtl_wc0_hscale_out.hex",
               "dumprtl_wa0_15to16_out.hex", "dumprtl_wb0_15to16_out.hex", "dumprtl_wc0_15to16_out.hex",
               "dumprtl_wa_vscale_out.hex","dumprtl_wb_vscale_out.hex","dumprtl_wc_vscale_out.hex",
               "dumprtl_wa_dv_in.hex","dumprtl_wb_dv_in.hex","dumprtl_wc_dv_in.hex",
               "dumprtl_wa_dv_out.hex","dumprtl_wb_dv_out.hex","dumprtl_wc_dv_out.hex",
               "dumprtl_dither_out.hex");



foreach $i (0 .. $#rtl_hex) { 
        `diff @ARGV[0]/rtl/$rtl_hex[$i] @ARGV[0]/csim/$csim_hex[$i] > temp_$rtl_hex[$i]`;
        my $temp_file = "temp_$rtl_hex[$i]";
        tie my @temp, 'Tie::File', $temp_file or die "$!";
    if(@temp) {
        print "DIFFERENT !!! \trtl/$rtl_hex[$i]     <<==========>>      csim/$csim_hex[$i]\n";
    }
    else {
        print "SAME.         \trtl/$rtl_hex[$i]     <<==========>>      csim/$csim_hex[$i]\n";
    }
}


`rm temp_dump*`;

}

