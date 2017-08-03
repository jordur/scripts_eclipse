#!/usr/bin/perl -w
### Script per estudiar les seqüències full-length observades seguint els scripts de trinity ####################### 
### L'utilitzo després d'script_align_cobalt.pl ja que agafa la referencia en proteïna escrita per aquest script ###
####################################################################################################################


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

###### Demanem el directori de treball com a argument ################
if (@ARGV < 1){
	print "Arguments: DIRECTORI_TREBALL\n";
}else{
	
#### Fixem el directori de treball com l'argument #########
chdir $ARGV[0];

#######Esborrem referencies anteriors si existeixen ############

if (-e "output.cobalt.prova"){
	system("rm output.cobalt.prova");
}elsif(-e "output.cobalt.prova.parsed"){
	system ("rm output.cobalt.prova.parsed");
}

####### introducir protein query and reference id. Aquest arxiu funciopna acceptant la referencia de que escriu script_align_cobalt.pl ########
print "Waiting for a query name...:\n";
my $line = <STDIN>;
chomp($line);

system("formatdb -i $line.ref.fasta -p T -n trinity_hit/$line.db");
chomp($line);
print "Executing BLAST...\n";
system("blastall -p blastx -i ${line}_cobalt.fasta -d trinity_hit/$line.db -e 0.0001 -m 8 -v 1 -b 1 -F F -o trinity_hit/${line}.trin.cov.prova");
print "done\n";
print "Analyzing with Trinity...\n";
system("perl /home/bec2-jcalvete/Feina_Jordi/programes/trinity/util/analyze_blastPlus_topHit_coverage.pl trinity_hit/${line}.trin.cov.prova ${line}_cobalt.fasta $line.ref.fasta");
print "done\n";

}
