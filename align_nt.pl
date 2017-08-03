#!/usr/bin/perl -w

use strict;
use Bio::DB::GenBank;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Perl;
use Bio::SearchIO;
use Bio::SeqFeature::SimilarityPair;
use Bio::AlignIO;
use Bio::Align::AlignI;
use Bio::SimpleAlign ;

####### introducir protein query and reference id ########

# my $out = Bio::SeqIO->new ( "-file"   => ">ref.fasta",
#		     "-format" => "Fasta" );
# print "Waiting for reference sequence...\n";
# print "Waiting for a query name...\n";
# my $line = <STDIN>;
# chomp $line;
# open OUTFILE , ">".$line."-UTR.txt" or die "can't open outfile\n";
# my $gb = Bio::DB::GenBank->new();
#	 print "Waiting for reference id...\n";
#	 my $gi = <STDIN>;
#	 chomp($gi);
#	
# 	print "Fetching gi ", $gi, " ... ";
#	 my $seq = $gb->get_Seq_by_gi($gi); # GI Number
#	 my $id = $seq->id();
#	 my $secuencia= $seq->seq();
#	 print OUTFILE ">".$id,"\n";
#	 print OUTFILE $secuencia,"\n";
# 	print "done. ";

chdir $ARGV[0];
#######blastn#######
print "Waiting for a query name...\n";	
my $line = <STDIN>;
chomp($line);
#~ system("blastall -p blastn -d $line.class.txt.database  -i $line-UTR.txt -e 0.001 -m 7 -o $line");

# open REF,"ref.fasta";
# my $ref=<REF>;
# print $ref;


#######parseo blastxml#######
open OUT ,">".$line."_UTR.fasta";
print "Enter blastxml report:\n";
my $blast_report = <STDIN>;
# Get the report
print "Query start:\n"; #########   Punt de d'start del CDS
my $start=<STDIN>;
print "Query end:\n";  ########## Punt de fi de CDS
my $end=<STDIN>; 

my @cincUTR;
my @tresUTR;
my @inter;
my @cds;
my @indef;
my $qstart;
my $qend;

my $searchio = new Bio::SearchIO (-format => 'blastxml',
				  -file   => $blast_report);

while( my $result = $searchio->next_result ) {
    while(my $hit = $result->next_hit){
		my $hit_name= $hit->name();
	while (my $hsp = $hit->next_hsp ){
	    my $query_name=$result->query_name();
	    my $hstart = $hsp->start('hit');
	    my $hend = $hsp->end('hit');	
	    my $hit_string = $hsp->hit_string;
	    my $query_string = $hsp->query_string;
	    $qstart = $hsp->start('query');
	    $qend = $hsp-> end ('query');	
#		print OUT $hit_name,"\t",$qstart,"\t",$qend,"\n";
		print $hit_name,"\t",$hstart,"\t",$hend,"\n";
#		print $hit_string,"\n";
		if (($qstart <= $start and $qend < $start)){
			chomp($hit_name);
			push (@cincUTR, $hit_name);
		}
		elsif (($qstart >= $end and $qend > $end)  or  ($qstart < $end and $qend >$end) ){
			chomp($hit_name);
			print OUT ">",$hit_name,"\n",$hit_string,"\n";
#			print ">",$hit_name,"\n",$hit_string,"\n";
#			print $hit_name,"\t",$hstart,"\t",$hend,"\t",$end."\n";
			push (@tresUTR, $hit_name);
		}	
		elsif ( ($qstart < $start and $qend > $start)  or ($qstart >= $start and $qend <= $end) ){
			chomp($hit_name);
			push (@inter, $hit_name);
		}	
		# elsif (($qstart > $start and $qend <$end)){
		# 	chomp($hit_name);
		# 	 push (@cds, $hit_name);	
			
		# }
		}
	}

}
open OUT1, ">>informe_UTR_2015";
my %seen1;
my @uniq1 = grep !$seen1{$_}++, @tresUTR;
print  OUT1 $line."_UTR\n";
print  OUT1 "\t3'UTR reads:\t";
print  OUT1 scalar@uniq1,"\n";
# foreach my $element1 (@tresUTR){
#      #print OUT1 $element1,"\n";
#   }

my %seen2;
my @uniq2 = grep !$seen2{$_}++, @cincUTR;
print  OUT1 "\t5'UTR reads:\t";
print  OUT1 scalar@uniq2,"\n";

my %seen3;
my @uniq3 = grep !$seen3{$_}++, @inter;
print  OUT1 "\tCDS contained reads:\t";
print OUT1 scalar@inter,"\n";
# foreach my $element3 (@inter){
#     print $element3,"\n";
# }

 my %seen4;
 my @uniq4=grep !$seen4{$_}++, @cds;
 print OUT1 "\tTotal CDS contained reads:\t";
 print OUT1 scalar@uniq4,"\n\n\n";

 my %seen5;
 my@uniq5=grep !$seen5{$_}++, @indef;
 print "\tNo identificat amb referencia:\t";
 print scalar@uniq5,"\n\n\n\n\n";

close OUT;
#close OUTFILE;
close OUT1;

