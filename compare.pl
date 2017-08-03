#!/usr/bin/perl -w
use strict;
use warnings;
use Bio::DB::GenBank;
use Bio::Seq::RichSeq;
use Bio::SeqIO;
use Bio::Perl;
use Bio::SearchIO;
use Bio::SeqFeature::SimilarityPair;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

### Script per comparar dos fitxers per una de les columnes i imprimir el resultat ##
if (@ARGV != 3){
    print "Arguments:\n\t Primer argument: fitxer id - counts\n\t Segon argument: id per identificar\n\n";
}else{

chdir $ARGV[2];

print "Enter ouput name:\n";
my $output = <STDIN>;
#chomp($output);

open (FILE1, $ARGV[0]) or die die "Can't open $ARGV[0]: $!";
open (FILE2, $ARGV[1]) or die die "Can't open $ARGV[1]: $!";
#open (FILE3, $ARGV[2]) or die die "Can't open $ARGV[2]: $!";
open OUT, ">$output";

my %hash;
my %hash2;
my %hash3;

my $ident1;
my $ident2;
my $ident3;
my $ident4;
my $ident5;
my $fasta;
my $org;
my $anot;
my $newborn;
	
my $file1=<FILE1>;
my $file2=<FILE2>;
#my $file3=<FILE3>;

my $number;
my $number2;

my @line;
my @line2;
my @line3;

while (<FILE2>){
    chomp;
    @line2=split /\t/;
    $ident3=$line2[0]; ##ident neonato
    $number=$line2[1]; ##count neonato
    #$newborn =$line2[2];
    $hash{$ident3} = $number;
    #$hash2{$ident3}= $newborn;
#    $number = 1;
#	print $ident3,"\n";
#	print $hash{$ident3}."\t".$hash{$ident2},"\n";
#	print $hash{$ident3},"\n";	
#	print $number,"\n";
}
#	print $hash{"comp10263_c1_seq44"};
close FILE2;


#while (<FILE3>){
#    chomp;
#    @line3=split /\t/;
#    $ident4=$line3[0]; ##ident adult
#    $number2=$line3[1]; ##count adult
#    $hash2{$ident4} = $number2;
##   $number2 = 1;
#	print $ident4,"\n";
#	print $hash2{$ident4}."\n";
#	print $number2,"\n";
#}
#print $hash2{">Cluster 0"};
#close FILE3;


while (<FILE1>){
#	print $_;
    chomp();
    @line=split /\t/;
    $ident1=$line[0]; ##ident neonato
    $ident2=$line[1]; ##ident adulto
#    print $ident1,"\n";
#    print $ident2,"\n";
#    $fasta=$line[2];
#   	$ident5 = $line[3];
#   	$org = $line[4];
#   	$anot = $line[5];
    #$number = 1;
#    $hash{$ident} = $number;
#	print $hash{"$ident2"},"\n";
#    print keys %hash,"\n";
#print $ident1."\t".$hash{$ident1}."\t".$ident2."\n";
print OUT $ident1."\t".$hash{$ident1}."\t".$ident2,"\n";

#print OUT $ident1."\t".$ident2."\t".$fasta."\t".$hash{$ident1}."\n";
#	print  $ident1,"\t",$ident2,"\t",$fasta,"\t",$ident5,"\t",$org,"\t",$number,"\n";
#}
#	print OUT $ident1,"\t",$ident2,"\t",$fasta,"\t",$ident5,"\t",$org,"\t",$number2,"\n";
#	}else{
#	print OUT $ident1,"\t",$ident2,"\t",$fasta,"\t",$ident5,"\t",$org,"\t",$anot,"\t",$hash{$ident1},"\t",$hash2{$ident1},"\n";
#	print $ident1, "\t", $hash{$ident3}, "\t",$ident2,"\n";
		}
close FILE1;





#while (<FILE3>){
#    chomp;
#    my $fasta = Bio::SeqIO->new ( "-file"   => "/home/bec2-jcalvete/Feina_Jordi/glandulas_mejicanas/glandulas_mejicanas/Feina/transcriptomes/results_10/assembly/blast/class_script/final/fasta/BLAST_DEF/prova.fasta",  "-format" => "Fasta" );
#    while( my $inseq = $fasta->next_seq ) {
#    	my $id_seq = $inseq->id();
#    	my $sec = $inseq->seq();
#    	my $desc = $hash{$id_seq};
#    	print OUT ">".$id_seq,"\t".$desc."\n".$sec."\n";
#    }
    
#    @line3=split /\t/;	
#    $ident3=$line3[0];
#    print $ident3,"\n";
#    $ident4 = $line3[1];
#    $start = $line3[2]; 
#    $end= $line3[4];
#    my $sentit = $line3[5];
#    my $seq = $line3[6];
#    if ($sentit eq "Plus"){ 
#		print OUT "gb|".$hash{$ident2}.".1|\t".$ident3."\n";
#    	print ">Feature\t".$ident2,"\n",$start,"\t",$end,"\tmRNA\n","\t\t\t","product\tsimilar to ".$hash{$ident2},"\n";
#    }elsif($sentit eq "Minus"){
#    	print OUT ">Feature\t"."gb|".$hash2{$ident3}.".1|","\n",$start,"\t",$end,"\tmRNA\n","\t\t\t","product\tsimilar to ".$hash{$ident3},"\n";
#    }
}

#close FILE2;
close OUT;
#}
print "DONE";
