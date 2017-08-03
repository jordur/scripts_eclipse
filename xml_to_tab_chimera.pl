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
print "Escriu el tamany del vector:\n";
my $tamany = <STDIN>;

my @files=<*>; ## Llegim tots els arxius 
my @files2 = grep (/Bjararaca_unmapped_results_(\d+).xml/, @files); ## LLegim resultats blastx
#my @files2 = grep (/motlle.+xml/, @files); ## LLegim resultats blastx
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
my $inici = 1;
my $final = 100000000000;
my $count;
my $partial;
my $num; 

foreach my $blast_report(@files2){

	$blast_report =~ /Bjararaca_unmapped_results_(\d+).xml/;
#	$blast_report =~ /motlle.+xml/;
#	print $1,"\n";
#	open OUT, ">>blastN_output"."_".$1;
######## Get the report
	my $searchio = new Bio::SearchIO (-format => 'blastxml', -file=>$blast_report);
#	print $searchio,"\n"; 
		while(my $result = $searchio->next_result){
			my $id=$result->query_name(); 
			$acc = $result->query_description();
#			($acc2 = $acc) =~ s/\sNo definition line found//g;
#			my $b =1;
#			print OUT $id,"\n"; ### contigs names
			while (my $hit=$result->next_hit){
					$name = $hit->name(); ### hit name
					$desc=$hit->description(); ### description name
					$num=$hit->num_hsps();
#					$frame = $hit->frame();
        			my $hitframe_positiu = 0;
        			my $hitframe_negatiu = 0;
        			my $count=0;
        			my $partial =0;
        			my $start_hsp = 1;
        			my $end_hsp = 1;
					($desc_2 = $desc) =~ s/\s/_/g; ## Canvio els espais per underscores per no tenir problemes amb la delimitació de camps de Trinotate
				if($num < 2){
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
							if ($length > 300){  										# longitud mínima de l'HSP
								if ($hframe > 0){
									$hitframe_positiu = $hitframe_positiu + 1;			# Mira el frame
									if (($subject_start > 1 && $subject_end <= $tamany) || ($subject_start <= 1 && $subject_end < $tamany)){
										 $partial += 1;								
									}
								}elsif($hframe < 0){
									$hitframe_negatiu = $hitframe_negatiu + 1;
									if (($subject_start > 1 && $subject_end <= $tamany) || ($subject_start <= 1 && $subject_end < $tamany)){
										 $partial += 1;								
									}		
								}
								if (($subject_start <= $inici && $subject_end >= $inici) || ($subject_start >= $inici && $subject_end <= $final) || ($subject_start <= $final && $subject_end  >= $final) || ($subject_start <= $inici && $subject_end >= $final)){
									$inici = $subject_start;
									$final = $subject_end;
									$count += 1;
								}
								
							}
					}	

				if ($hitframe_positiu >= 1 && $hitframe_negatiu >= 1){					# Amb frames diferents l'imprimeix	
#					print OUT ">".$acc."\t".$random."\t".$desc_2."\n".$qseq2."\n";
#					print  ">".$id."\t".$desc_2."\n".$qseq2."\n";
#					print OUT $acc2."\t".$desc_2."\t".$percentid."\t".$length."\t"."10"."\t".$gaps."\t".$query_start."\t".$query_end."\t".$subject_start."\t".$subject_end."\t".$evalue."\t".$bits."\n";
					print "PLUS_MINUS_1hsp"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";
#					print OUT l">".$acc."\n".$qseq."\n";
#					print  $id."\n";

			    }elsif($count >=2){
			    	print  "DUPLICATED_1hsp"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";		    	
			    }elsif($partial >=1){
			    	
			    	print "PARTIAL VECTOR_1hsp"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";
			    }
#			    $b++;
#					}
#					print $id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hframe."\n";	

					}else{
					
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
							if ($length > 300){  										# longitud mínima de l'HSP
								if ($hframe > 0){
									$hitframe_positiu = $hitframe_positiu + 1;			# Mira el frame
									if ($subject_start >= 1 && $subject_end < $tamany && $subject_start >= $end_hsp){
										$start_hsp = $subject_start;
										$end_hsp = $subject_end;
									}else{
										$partial += 1;								
									}
								}elsif($hframe < 0){
									$hitframe_negatiu = $hitframe_negatiu + 1;
									if ($subject_start >= 1 && $subject_end <= $tamany && $subject_start >= $end_hsp){
										$start_hsp = $subject_start;
										$end_hsp = $subject_end;
									}else{
										 $partial += 1;								
									}		
								}
								if (($subject_start <= $inici && $subject_end >= $inici) || ($subject_start >= $inici && $subject_end <= $final) || ($subject_start <= $final && $subject_end  >= $final) || ($subject_start <= $inici && $subject_end >= $final)){
									$inici = $subject_start;
									$final = $subject_end;
									$count += 1;
								}
								
							}
					}	

				if ($hitframe_positiu >= 1 && $hitframe_negatiu >= 1){					# Amb frames diferents l'imprimeix	
#					print OUT ">".$acc."\t".$random."\t".$desc_2."\n".$qseq2."\n";
#					print  ">".$id."\t".$desc_2."\n".$qseq2."\n";
#					print OUT $acc2."\t".$desc_2."\t".$percentid."\t".$length."\t"."10"."\t".$gaps."\t".$query_start."\t".$query_end."\t".$subject_start."\t".$subject_end."\t".$evalue."\t".$bits."\n";
					print "PLUS_MINUS_hsps"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";
#					print OUT l">".$acc."\n".$qseq."\n";
#					print OUT $id."\n";

			    }elsif($count >=2){
			    	print "DUPLICATED_hsps"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";		    	
			    }elsif($partial >1){
			    	print "PARTIAL VECTOR_hsps"."\t".$id."\tfrom\t".$subject_start."\tto\t".$subject_end."\t".$hitframe_positiu."\t".$hitframe_negatiu."\n";
			    }
					}
		    	}
		    
			}
		}	
#close OUT;
print "DONE\n"
}


