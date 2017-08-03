#!usr/bin/env perl -w
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

#### Definim funcions########
if (@ARGV < 1){
    print "Afegir com a argument el directori de treball\n"
}else{

	sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] };

	sub codon2aa{
	my($codon)=@_;
	$codon= uc $codon;
	
	my(%genetic_code) = (
 	'TCA'=>'S', #SERINE
	'TCC'=>'S', #SERINE
	'TCG'=>'S',  #SERINE
	'TCT'=>'S', #SERINE
	'TTC'=>'F', #PHENYLALANINE
	'TTT'=>'F', #PHENYLALANINE
	'TTA'=>'L', #LEUCINE
	'TTG'=>'L', #LEUCINE
	'TAC'=>'Y', #TYROSINE
	'TAT'=>'Y', #TYROSINE
	'TAA'=>'B', #STOP
	'TAG'=>'B', #STOP
	'TGC'=>'C', #CYSTEINE
	'TGT'=>'C', #CYSTEINE
	'TGA'=>'B', #STOP
	'TGG'=>'W', #TRYPTOPHAN
	'CTA'=>'L', #LEUCINE
	'CTC'=>'L', #LEUCINE
	'CTG'=>'L', #LEUCINE
	'CTT'=>'L', #LEUCINE
	'CCA'=>'P', #PROLINE
	'CAT'=>'H', #HISTIDINE
	'CAA'=>'Q', #GLUTAMINE
	'CAG'=>'Q', #GLUTAMINE
	'CGA'=>'R', #ARGININE
	'CGC'=>'R', #ARGININE
	'CGG'=>'R', #ARGININE
	'CGT'=>'R', #ARGININE
	'ATA'=>'I', #ISOLEUCINE
	'ATC'=>'I', #ISOLEUCINE
	'ATT'=>'I', #ISOLEUCINE
	'ATG'=>'M', #METHIONINE
	'ACA'=>'T', #THREONINE
	'ACC'=>'T', #THREONINE
	'ACG'=>'T', #THREONINE
	'ACT'=>'T', #THREONINE
	'AAC'=>'N', #ASPARAGINE
	'AAT'=>'N', #ASPARAGINE
	'AAA'=>'K', #LYSINE
	'AAG'=>'K', #LYSINE
	'AGC'=>'S', #SERINE
	'AGT'=>'S', #SERINE
	'AGA'=>'R', #ARGININE
	'AGG'=>'R', #ARGININE
	'CCC'=>'P', #PROLINE
	'CCG'=>'P', #PROLINE
	'CCT'=>'P', #PROLINE
	'CAC'=>'H', #HISTIDINE
	'GTA'=>'V', #VALINE
	'GTC'=>'V', #VALINE
	'GTG'=>'V', #VALINE
	'GTT'=>'V', #VALINE
	'GCA'=>'A', #ALANINE
	'GCC'=>'A', #ALANINE
	'GCG'=>'A', #ALANINE
	'GCT'=>'A', #ALANINE
	'GAC'=>'D', #ASPARTIC ACID
	'GAT'=>'D', #ASPARTIC ACID
	'GAA'=>'E', #GLUTAMIC ACID
	'GAG'=>'E', #GLUTAMIC ACID
	'GGA'=>'G', #GLYCINE
	'GGC'=>'G', #GLYCINE
	'GGG'=>'G', #GLYCINE
	'GGT'=>'G', #GLYCINE
	);


	if(exists $genetic_code{$codon}){
    	return $genetic_code{$codon};
    	}else{
    	print "";
    	 }
	}

	chdir $ARGV[0];
#	print "Enter your fasta file name:\n";
#	my $file = <STDIN>;
#	print "Sample identification name:\n";
#	my $name =<STDIN>;
#	chomp($name);
my @files=<*>;
my @files2 = grep (/.\.class.txt.fasta/, @files);

foreach my $blast_report(@files2){
	$blast_report =~ /(.+)\.class.txt.fasta/;
	my $name = $1;
	#print $name,"\n";
	open OUT , ">".$name."_translation.txt";	
	my $in  = Bio::SeqIO->new(-file => $blast_report , '-format' => 'Fasta')  or die "Failed to open input file: $!";
	while ( my $seq = $in->next_seq() ) {
    	my $dna = $seq->seq();
		my $id =$seq->id();
		(my $id3 = $id) =~ s/lcl\|//g;
		my $id2 = $id3."_".$name;
		chomp($dna);
		my $reverse = scalar reverse $dna;
		$reverse =~ tr/ACGTacgt/TGCAtgca/;
		my $protein1;
		my $protein2;
		my $protein3;
		my $rev1;
		my $rev2;
		my $rev3;
		my $codon;
		my @a;
		my $random;
	
		for(my $i=0; $i<(length($dna)-2); $i+=3){
	    	$codon = substr($dna,$i,3);
#	    print $codon,"\n";
	    	if ($codon =~ /N/){
			$codon = "X";		
	    	}else{
			$protein1 .= codon2aa($codon);
	    	}
		}
		@a = split('|',$id2);
		$random = rndStr 8, 'a'..'z', 0..9;
		print  OUT ">Frame+1_",$id2." ".$random."\n",$protein1,"\n";
		substr($dna,0,1)="";


		for(my $i=0; $i<(length($dna)-2); $i+=3){
	    	$codon = substr($dna,$i,3);
	    	if ($codon =~ /N/){
			$codon = "X";
	    	}else{
			$protein2 .= codon2aa($codon)
	    	}	
		}
		$random = rndStr 8, 'a'..'z', 0..9;
		@a = split('|',$id2);
 		print OUT">Frame+2_".$id2." ".$random."\n".$protein2,"\n";
		substr($dna,0,1)="";


        for(my $i=0; $i<(length($dna)-2); $i+=3){
	    	$codon = substr($dna,$i,3);
	    	if ($codon =~ /N/){
			$codon = "X";
	    	}else{
			$protein3 .= codon2aa($codon);
	    	}
		}
		$random = rndStr 8, 'a'..'z', 0..9;
		@a = split('|',$id2);
		print OUT ">Frame+3_".$id2." ".$random."\n".$protein3,"\n";



		for(my $i=0; $i<(length($reverse)-2); $i+=3){
	    	$codon = substr($reverse,$i,3);
	    	if ($codon =~ /N/){
			$codon = "X";
	    	}else{
			$rev1 .= codon2aa($codon);
	    	}
		}
		$random = rndStr 8, 'a'..'z', 0..9;
		@a = split('|',$id2);
 		print OUT ">Frame-1_",$id2." ",$random."\n".$rev1,"\n";		
		substr($reverse,0,1)="";


		for(my $i=0; $i<(length($reverse)-2); $i+=3){
	    	$codon = substr($reverse,$i,3);
	    	if ($codon =~ /N/){
			$codon = "X";
	    	}else{
			$rev2 .= codon2aa($codon);
	    	}
		}
		$random = rndStr 8, 'a'..'z', 0..9;
		@a = split('|',$id2);
 		print OUT ">Frame-2_".$id2." ",$random."\n".$rev2,"\n";	
 		substr($reverse,0,1)="";


		for(my $i=0; $i<(length($reverse)-2); $i+=3){
	    	$codon = substr($reverse,$i,3);
	    	if ($codon =~ /N/){
			$codon = "X";
	    	}else{
			$rev3 .= codon2aa($codon);
	    	}
		}
		$random = rndStr 8, 'a'..'z', 0..9;
		@a = split('|',$id2);
 		print OUT ">Frame-3_",$id2." ",$random."\n".$rev3,"\n";	

		}
	}

close OUT;

}

print "DONE";


