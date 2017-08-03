#!/usr/bin/perl -w
use strict;
use warnings;

### Script per comparar dos fitxers per una de les columnes i imprimir el resultat. L'script agafa el primer arxiu resultant de compare.pl () i els dos resultants amb els IDs de MapMi per comparar-los i imprimir si existerix MapMi o no ###

if (@ARGV != 3){
    print "Arguments:\n\t ID-MapMi_Adult\t\tID-MapMi_Newborn\tCommon Ids-counts\n\n";
}else{


print "Enter ouput name:\n";
my $output = <STDIN>;

chomp($output);
open FILE1, $ARGV[0];
open FILE2, $ARGV[1];
open FILE3, $ARGV[2];
open OUT, ">$output";

my %hash;
my %hash2;
my $ident;
my $ident2;
my $ident3;
my $ident4;

my $file1=<FILE1>;
my $file2=<FILE2>;
my $file=<FILE3>;

my $number = 1;

my @line;
my @line2;
my @line3;
my @line4;


####ID-counts ADULT####
while (<FILE1>){
    chomp;
    @line=split /\t/;
    $ident=$line[0];
    $hash{$ident} = $number;
#    print $hash{$ident},"\n";
#    print keys %hash,"\n";
}
close FILE1;


#####ID-counts NEWBORN####

while (<FILE2>){
    chomp;
    @line2=split /\t/;
    $ident2=$line2[0];
    $hash2{$ident2}=$number;
#    print $ident2,"\n";

}
close FILE2;

#### IDs ####
while(<FILE3>){
    chomp;
    @line3=split /\t/;
    $ident3=$line3[0]; ##Identificacio Newborn
    $ident4=$line3[1]; ## Identificacio Adult
#    print $ident3,"\n";
    
#    print OUT $ident4."\t".$hash2{$ident4},"\n";
    if (exists ($hash{$ident4})){
	print OUT $line3[0],"\t",$line3[1],"\t",$line3[2],"\t",$line3[3]."\tOK\n";
    }elsif(exists ($hash2{$ident3})){
	print OUT $line3[0],"\t",$line3[1],"\t",$line3[2],"\t",$line3[3],"\tOK\n";
    }
}
close FILE3;

}
close OUT;
print "DONE";