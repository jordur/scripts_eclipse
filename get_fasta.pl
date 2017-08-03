#!usr/bin/env perl -w
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

#### Parsing file #####
open OUT, ">prova"; 
#open IN, $ARGV[0];
chdir $ARGV[0];
print "Enter input fasta file name:\n";
my $in1 = <STDIN>;
#my $in1 = <IN>;
#print "Quina serp és?:";
#print "Quina toxina és?:";
#my $serp =<STDIN>;
#chomp($serp);
#open OUT, ">".$serp."_UTR_target_scan_format";
#open OUT1, ">file"; 
#print "Adult(1) o Neonato(2)?:";
#my $dev = <STDIN>;
#chomp($dev);

#print "@identificadors\n";
#    chomp($identificador);
#    print $identificador."\n";
my $in = Bio::SeqIO->new( -file => $in1, '-format' => 'Fasta')  or die "Failed to open input file: $!";
my $count=1;
while ( my $seq = $in->next_seq() ) {
#    foreach my $identificador (@identificadors){
#	chomp(@identificadors);
#        print $identificador."\n";
        
	my $dna = $seq->seq();
#	my $dna = $seq->subseq(165924,195024);
	my $id = $seq ->id();
	my $desc = $seq->desc();
#	(my $id2) = $id =~ /.+lcl\|(.+)\|\d+\|.+/;
#	if ($id2){
#		if ($id =~ /Scaffold6/){
			print OUT ">".$id."\t".$dna,"\n";
#			
#		}else{
#			print  OUT1 ">".$id2,"\n".$dna,"\n";	
		}
#	}elsif ((my $id3) = $id =~ /.cd +lcl\|(.+)\//){
#		print OUT1 ">".$id3,"\n",$dna."\n";
#	}else{
#		(my $id4) = $id =~ /.+lcl\|(.+)/;
#		print OUT1 ">".$id4,"\n",$dna,"\n";
#	}
 	#open OUT,">".$id."."."fasta";
#	if ( $id !~ $identificador){
#    	if ($id ~ /@identificador/){    
	#print OUT ">",$id."_".$desc."\n".$dna."\n";
#	print OUT ">".$id."\n".$dna."\n";
#	print OUT $dna."\t".$id."\n";
#	$count += 1;
#	print OUT $dna,"\t",$id,"\n";
#	    print $identificador." found!\n";
#	}else{
#	    print OUT ">".${serp}."_".$id."\n".$dna."\n";
#	    print OUT $id."\t".$dna."\t".$dev."\n";
#	    print OUT $id."\t".$dev."\t".$dna."\n";
	#print OUT ">".$id."\n".$dna."\n";
#	}
#    }
#	close OUT;
#}
#close IN;
close OUT;
print "DONE";
