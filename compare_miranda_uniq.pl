#!/usr/bin/perl -w
use strict;
use warnings;

### Script per comparar dos fitxers per una de les columnes i imprimir el resultat. L'script agafa el primer arxiu resultant (.tsv) de compare_Mapmi.pl i els dos resultants de miranda pla2 i miranda repro per comparar-los i imprimir si els que han mostrat Mapmi + mapejen o no a mRNA de pla2 i SVMP ###

if (@ARGV != 4){
    print "Arguments:\n\tID_PLA2\tID_CRISP\tID_3FTx\tArxiu_Mapmi_positius\n\n";
}else{


print "Enter ouput name:\n";
my $output = <STDIN>;

chomp($output);
open FILE1, $ARGV[0];
open FILE2, $ARGV[1];
open FILE3, $ARGV[2];
open FILE4, $ARGV[3];
open OUT, ">$output";

my %hash1;
my %hash2;
my %hash3;

my $ident1;
my $ident2;
my $ident3;
my $ident4;
my $ident5;

my $file1=<FILE1>;
my $file2=<FILE2>;
my $file3=<FILE3>;
my $file4=<FILE4>;

my $number = 1;

my @line1;
my @line2;
my @line3;
my @line4;

####PLA2####
while (<FILE1>){
    chomp;
    @line1=split /\t/;
    $ident1=$line1[0];
    $hash1{$ident1} = $number;
#    print $hash{$ident},"\n";
#    print keys %hash,"\n";
}
close FILE1;


#####CRISP####

while (<FILE2>){
    chomp;
    @line2=split /\t/;
    $ident2=$line2[0];
    $hash2{$ident2}=$number;

}
close FILE2;

#####3FTx####

while (<FILE3>){
    chomp;
    @line3=split /\t/;
    $ident3=$line3[0];
    $hash3{$ident3}=$number;

}
close FILE3;


#### Mapmi positius ####
while(<FILE4>){
    chomp;
    @line4=split /\t/;
    $ident4=$line4[0];
#    print $ident5,"\n";
#    $ident4=$line3[1];
#    print $ident4,"\n";
    
#    print OUT $ident4."\t".$hash2{$ident4},"\n";
    if (exists ($hash1{$ident4})){
	print OUT $line4[0],"\t",$line4[1],"\t",$line4[2]."\tMap_SVMP\n";
    }if(exists ($hash2{$ident4})){
	print OUT $line4[0],"\t",$line4[1],"\t",$line4[2],"\t\tMap_CRISP\n";
    }if(exists ($hash3{$ident4})){
	print OUT $line4[0],"\t",$line4[1],"\t",$line4[2],"\t\t\tMap_3FTx\n";
	}
}
close FILE4;
}
close OUT;
print "DONE";