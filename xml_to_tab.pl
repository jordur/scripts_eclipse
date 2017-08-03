#!/usr/bin/perl -w
use strict;
use Bio::Perl;
use Bio::SearchIO;
use Bio::SeqFeature::SimilarityPair;
use Bio::Search::Hit::GenericHit;
use Cwd;

### Script per parsejar xml BLAST (outfmt 6) a TAB BLAST (outfmt 5). 

sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] };

if (@ARGV < 1){
	print "Afegir com a argument el directori de treball"	
}else{

### Obrim l'arxiu ouput al directori fixat com a argument 1 ###
chdir $ARGV[0];
#print "Escriu el tamany del vector:\n";
#my $tamany = <STDIN>;

my @files=<*>; ## Llegim tots els arxius 
#my @files2 = grep (/Bjararaca_unmapped_results_(\d+).xml/, @files); ## LLegim resultats blastx
my @files2 = grep (/ONT_transcriptomics.results_(\d+).xml/, @files); ## LLegim resultats blastx
my $name;
my $desc;
my $desc_2;
my $acc;
my $acc2;
my $evalue;
my $length;
my $bits;
my $query_start;
my $query_end;
my $subject_start;
my $subject_end;
my $percentid;
my $gaps;
my $hseq;
my $qframe;
my $hframe;
my $number;
my $qseq;
my $qseq2;
my $random;
my $count;
my @reps;
foreach my $blast_report(@files2){

#	$blast_report =~ /Bjararaca_unmapped_results_(\d+).xml/;
	$blast_report =~ /ONT_transcriptomics.results_(\d+).xml/;
#	print $1,"\n";
	open OUT, ">>blastN_output"."_".$1;
#	open OUT, ">>reads_amb_vector.id";
######## Get the report
	my $searchio = new Bio::SearchIO (-format => 'blastxml', -file=>$blast_report);
#	print $searchio,"\n"; 
		while(my $result = $searchio->next_result){
			my $id=$result->query_name(); 
			$acc=$result->query_description();
#			($acc2 = $acc) =~ s/\sNo definition line found//g;
#			my $b =1;
#			print $id,"\t".$acc,"\n"; ### contigs names
			while (my $hit=$result->next_hit){
			    #if($b < 2){
			    	$count=0;
					$name = $hit->name(); ### hit name
					$desc=$hit->description(); ### description name
#					$frame = $hit->frame();
					($desc_2 = $desc) =~ s/\s/_/g; ## Canvio els espais per underscores per no tenir problemes amb la delimitació de camps de Trinotate
					while( my $hsp = $hit->next_hsp ) {
						$random = rndStr 8, 'a'..'z', 0..9;
						$evalue = $hsp ->evalue(); ### evalue
						$length = $hsp ->length('total'); #### alignment lenght
						$bits = $hsp -> bits(); ### bit score
						$query_start = $hsp->start('query'); ### query start
						$query_end= $hsp -> end ('query'); ### query end 
						$subject_start = $hsp->start('hit'); ### subject start
						$subject_end= $hsp -> end ('hit'); ### subject end
						$percentid = $hsp->percent_identity(); ### percentage identity
						$gaps = $hsp->gaps('total'); ### number of total gaps
						$hseq = $hsp->hit_string;
						$qframe = $hsp->strand('query');
						$hframe = $hsp->strand('hit');
						$qseq = $hsp->query_string;
						($qseq2 = $qseq) =~ s/-//g;
						my $suma = $subject_end - $subject_start;
#						$count= $count + $suma;
						print OUT $id,"\n";
#						if ($subject_start < 20 && $subject_end > 700){  
#						if ($length > 600){
#							print OUT $id,"\t",$count,"\n";
#							print OUT $id, "\t",$name,"\t",$qframe,"\t",$hframe,"\t",$subject_start,"\t", $subject_end,"\n";
#							push @reps, $id;
#						}else{ 
#							print $id,"\t",$name,"\t",$qframe,"\t",$hframe,"\t",$subject_start,"\t", $subject_end,"\n";
#						}
#							if ($subject_start >= 1 && $subject_end <= $tamany){
#							if ($subject_start >= 1 && $subject_end <= $tamany){
						
#							$number = "Plus";							
#						}else{
#							$number = "Minus";
#						}
				#	}
					
#				print OUT ">".$acc."\t".$random."\t".$desc_2."\n".$qseq2."\n";
#				print  OUT ">".$id,"\n",$qseq2,"\n";
#				print OUT $acc2."\t".$desc_2."\t".$percentid."\t".$length."\t"."10"."\t".$gaps."\t".$query_start."\t".$query_end."\t".$subject_start."\t".$subject_end."\t".$evalue."\t".$bits."\n";
#				print ">".$id."\n".$qseq."\n";
#				print OUT l">".$acc."\n".$qseq."\n";
#			    		}
#					}
				}	
#			    $b++;
				}
#				print $id,"\t", $count,"\n";	
#			if ($count > 6000){
#				print $id,"\n";
#				}
		    }
#		    my %params = map { $_ => 1 } @reps;
#		    my $searchio2 = new Bio::SearchIO (-format => 'blastxml', -file=>$blast_report);
#		    while(my $result2 = $searchio2->next_result){
#		    	my $id2= $result2->query_name();
##		    	print $id2,"\n"; 
#		    	unless(exists($params{$id2})) {
#		    		print OUT $id2,"\n";
#		    	}	
#		    	
#		    }
#		    print $reps[0],"\n";
#		    print $reps[1],"\n";
#		    print scalar@reps,"\n";
		    
		}
close OUT;
print "DONE\n"
}


