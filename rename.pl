#!usr/bin/env perl -w
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

#open OUT , ">trans_rename.txt";
#open OUT2, ">codons.txt";

sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] };

print "Enter your fasta file name:\n";
my $file = <STDIN>;
chomp($file);
open OUT , ">".$file."_rename.fasta";
my $in  = Bio::SeqIO->new(-file => $file , '-format' => 'Fasta')  or die "Failed to open input file: $!";
chomp($in);

while ( my $seq = $in->next_seq() ) {
		my $random = rndStr 8, 'a'..'z', 0..9;
		print OUT ">",$seq->id()." ".$random."\n";
		my $dna = $seq->seq();
		chomp($dna);
	 	print OUT $dna,"\n";
	}
	
	close OUT;
