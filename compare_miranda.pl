#!/usr/bin/perl -w
use strict;
use warnings;

### Script per comparar dos fitxers per una de les columnes i imprimir el resultat. L'script agafa el primer arxiu resultant (.tsv) de compare_Mapmi.pl i els dos resultants de miranda pla2 i miranda repro per comparar-los i imprimir si els que han mostrat Mapmi + mapejen o no a mRNA de pla2 i SVMP ###

if (@ARGV != 7){
    print "Arguments:\n\tID_PLA2_Newborn\tID_PLA2_Adult\tID_SVMP_Newborn\tID_SVMP_Adult\tArxiu_Mapmi_positius\n\n";
}else{


print "Enter ouput name:\n";
my $output = <STDIN>;

chomp($output);
open FILE1, $ARGV[0];
open FILE2, $ARGV[1];
open FILE3, $ARGV[2];
open FILE4, $ARGV[3];
open FILE5, $ARGV[4];
open FILE6, $ARGV[5];
open FILE7, $ARGV[6];

open OUT, ">$output";

my %hash1;
my %hash2;
my %hash3;
my %hash4;
my %hash5;
my %hash6;

my $ident1;
my $ident2;
my $ident3;
my $ident4;
my $ident5;
my $ident6;
my $ident7;
my $ident8;

my $file1=<FILE1>;
my $file2=<FILE2>;
my $file3=<FILE3>;
my $file4=<FILE4>;
my $file5=<FILE5>;
my $file6=<FILE6>;
my $file7=<FILE7>;

my $number = 1;

my @line1;
my @line2;
my @line3;
my @line4;
my @line5;
my @line6;
my @line7;

####PLA2 Newborn####
while (<FILE1>){
    chomp;
    @line1=split /\t/;
    $ident1=$line1[0];
    $hash1{$ident1} = $number;
#    print $hash1{$ident1},"\n";
#    print keys %hash1,"\n";
}
close FILE1;


#####PLA2 Adult####

while (<FILE2>){
    chomp;
    @line2=split /\t/;
    $ident2=$line2[0];
    $hash2{$ident2}=$number;

}
close FILE2;

#### CRISP Newborn #####

while(<FILE3>){
    chomp;
    @line3=split /\t/;
    $ident3=$line3[0];
    $hash3{$ident3}=$number;

}
close FILE3;

#### CRISP Adult ####
while (<FILE4>){
    chomp;
    @line4= split /\t/;
    $ident4=$line4[0];
    $hash4{$ident4}=$number;
}
close FILE4;

####3FTx Newborn####
while (<FILE5>){
    chomp;
    @line5=split /\t/;
    $ident5=$line5[0];
    $hash5{$ident5} = $number;
#    print $hash{$ident},"\n";
#    print keys %hash,"\n";
}
close FILE5;

####3FTx Adult####
while (<FILE6>){
    chomp;
    @line6=split /\t/;
    $ident6=$line6[0];
    $hash6{$ident6} = $number;
#    print $hash{$ident},"\n";
#    print keys %hash,"\n";
}
close FILE6;


#### Mapmi positius ####
while(<FILE7>){
    chomp;
    @line7=split /\t/;
    $ident7=$line7[0];
    print $ident7,"\n";
    $ident8=$line7[1];
#    print $ident4,"\n";
    
#    print OUT $ident4."\t".$hash2{$ident4},"\n";
    if (exists ($hash1{$ident7})){
	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3]."\t".$line7[4]."\tMap_PLA2_N\n";
    }if(exists ($hash2{$ident8})){
	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3],"\t".$line7[4]."\t\tMap_PLA2_A\n";
    }if(exists ($hash3{$ident7})){
 	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3],"\t".$line7[4]."\t\t\tMap_CRISP_N\n";
    }if(exists ($hash4{$ident8})){
	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3],"\t".$line7[4]."\t\t\t\tMap_CRISP_A\n";
    }if(exists ($hash5{$ident7})){
	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3],"\t".$line7[4]."\t\t\t\t\tMap_3FTx_N\n";
    }if(exists ($hash6{$ident8})){
	print OUT $line7[0],"\t",$line7[1],"\t",$line7[2],"\t",$line7[3],"\t".$line7[4]."\t\t\t\t\t\tMap_3FTx_A\n";
    }
    
    
}
close FILE7;
}
close OUT;
