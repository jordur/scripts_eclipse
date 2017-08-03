#!/usr/bin/perl -w

use Bio::SeqIO; 
my $in = Bio::SeqIO->new (-file =>  $ARGV[0], -format => "Fasta");  ###Toxines
#open IN, "<", $ARGV[1]; ### blastPresults
#open OUT, ">/home/bec2-jcalvete/Feina_Jordi/Giulia/prova.txt";

my $field2;
my $id;

while (my $seq = $in->next_seq) {  #### while cada toxina
	$id = $seq->primary_id;
	$desc = $seq -> description;
	chomp($id);
	chomp($desc);
	#my $name = $id." ".$desc;
	#print lc $id,"\n";
#	print ">",$id,"\t",$desc,"\n",$seq->seq,"\n";
	print ">",$id,"\t",$desc,"\n";

#	my $line = <IN>;  ### Per cada linia dels blastP_results
#	chomp($line);
#	my @field = split (/ /,$line);
#	$field2= lc $field[0];
#	#print $field2,"\n";
#	#@field3 = split (/ /, $field2);
#	#print $field3[1],"\n"; ### imprimeix els 10 caràcters úinics
#	#print $desc,"\n";
# 		if ($field2 eq $id){
#			print $field2,"\n";
#			#print ">",$name,"\t",$field2[1],"\n";	
#		}
	
}
	

print "Done";

#close IN;
#close OUT;