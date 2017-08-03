#!/usr/bin/perl -w
use strict;

chdir $ARGV[0];
print "Enter ouput name:\n";
my $output = <STDIN>;
chomp($output);
open OUT1, ">$output";
open IN,"<taula_id_contig_all_serps";
while(my $a = <IN>){
	chomp $a;
	if ($a =~ /(.+)\/\d+(.+)\/.+/){
		print OUT1 $1,"\t",$2,"\n";
	}elsif($a =~ /(.+)\/\d+/){
		print OUT1 $1,"\n";
	}else{
		print OUT1 $a,"\n";
		
	}
}
close OUT1;