#!/usr/bin/perl -w

########## Script per obtindre els ID d'un fitxer fasta, localitzar-los en un altre i obtindre la seva sequencia fasta ########
###############################################################################################################################

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

my $dna;
my $dnaI;
my $dnaL;
my $dnaIK;
my $dnaIQ;
my $dnaLK;
my $dnaLQ;


if (@ARGV < 1){
	print "Afegir com a argument el directori de treball\n"
}else{


chdir $ARGV[0];
open OUT, ">prova.fasta";
		my $fasta = Bio::SeqIO->new ( "-file"   => "unidentified.fasta",  "-format" => "Fasta" );
		my $count = 1;
#		my %hash;
			while(my $inseq = $fasta->next_seq ) {
				my $id_seq = $inseq->id();			
#				print $id_seq,"\n";
				my $dna = $inseq->seq();
#				print $dna,"\n";
				if ($dna =~ /X/){
					($dnaL = $dna) =~ s/X/L/g;
					($dnaI = $dna) =~ s/X/I/g;
					if ($dnaL =~ /B/){
						($dnaLK = $dnaL) =~ s/B/K/g;
						($dnaLQ = $dnaL) =~ s/B/Q/g;			
						print OUT ">".$id_seq."_".$count."\n".$dnaLK,"\n";
						$count = $count += 1;
						print OUT ">".$id_seq."_".$count."\n".$dnaLQ,"\n";
						$count += 1;
					}
					if($dnaI =~ /B/){
						($dnaIK = $dnaI) =~ s/B/K/g;
						($dnaIQ = $dnaI) =~ s/B/Q/g;
						print OUT ">".$id_seq."_".$count."\n".$dnaIK,"\n";
						$count += 1;
						print OUT ">".$id_seq."_".$count."\n".$dnaIQ,"\n";	
						$count +=1;
					}else{
						print OUT ">".$id_seq."_".$count."\n".$dnaL,"\n";
						$count +=1;
						print OUT ">".$id_seq."_".$count."\n".$dnaI,"\n"; 
					}
				}else{
					print OUT ">".$id_seq."\n".$dna."\n";
				}
				
#				$hash{$id_seq} = 1;
#				if (exists($hash{$id_seq})){
#					print $id_seq."_".$count."\n";
#					my $desc = $inseq -> desc();
#					(my $desc2=$desc) =~ s/ /_/g; 
#					$id_seq = $1 if $id_seq =~ /(>lcl|\w+.\w+(\/\w+)?).*/;
#					print $1,"\n";
#					my $sec = $inseq->seq();		
#					print $desc2,"\n";
#					print ">".$1."_".$count."\t".$desc2,"\n"."$sec"."\n";
#				}
#				$count = $count +1;
			}

		
}
print "DONE";

