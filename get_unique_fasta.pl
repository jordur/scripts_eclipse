#!/usr/bin/perl -w

########## Script per obtindre sequencies fasta uniques. Fatsx_collpaser canvia el nom de la sequencia. Amb aquest script########
##          mantenim el nom de la sequencia
#################################################################################################################################

use strict;
use Bio::DB::GenBank;
use Bio::Seq::RichSeq;
use Bio::SeqIO;
use Bio::Perl;
use Bio::SearchIO;
use Bio::SeqFeature::SimilarityPair;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

if (@ARGV < 3){
	print "Directori\tAfegir id per treure\tArxiu fasta\n"
}else{

chdir $ARGV[0];
my @names;
my %params;
my @line;
my $ident;
my $file;

open FILE1, $ARGV[1];
open FILE2, $ARGV[2];

while (<FILE1>){
	@line=split /\t/;
    $ident=$line[0];
    chomp($ident);
#    print $ident,"\n";
	$params{$ident}=1;
	
}
$file = <FILE2>;
open OUT, ">temp";	 ## ULL enviem a un arxiu temporal!
#open OUT2, ">temp2";
##### Obrim el segon arxiu, que sera el que conte moltes seqs fasta ####
	my $fasta = Bio::SeqIO->new ( "-file"   => "/home/bec2-jcalvete/Feina_Jordi/Minion/Echis/processing/blast/Echis_trimmed_prinseq_good_gvtT.fasta",  "-format" => "Fasta" );
	while( my $inseq = $fasta->next_seq ) {
		my $id_seq = $inseq->id();
#		print $id_seq,"\n";
		my $sec = $inseq->seq();
		chomp($id_seq);
#		unless(exists($params{$id_seq})) {
#		unless(exists($params{$id_seq})) {
#			print OUT2 ">".$id_seq,"\n".$sec."\n";
#		}
		if(exists($params{$id_seq})) {	
#			print $id_seq,"\n";
 			#$params{$sec} += 1;
 			print OUT  ">".$id_seq,"\n".$sec."\n";
			
 		} 				
				
 	}

}
close OUT;
#close OUT2;
close FILE1;
close FILE2;
print "DONE";



