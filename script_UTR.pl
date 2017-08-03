#!/usr/bin/perl -w

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

#######Esborrem referncies anteriors############
#system ("rm output.cobalt.prova output.cobalt.prova.parsed");

####### introducir protein query and reference id ########
#open OUTFILE , ">outfile.txt" or die "can't open outfile\n";
my $prot_id;
my $sec_ref;
my $id;
# my $out = Bio::SeqIO->new ( "-file"   => ">ref.fasta",
# 			    "-format" => "Fasta" );

chdir $ARGV[0];		    
			    
 			    print "Waiting for a query name...:\n";
  			    my $line = <STDIN>;	
			    my $gb = Bio::DB::GenBank->new();
			    print "Waiting for reference id...:\n"; ## Li diem quina serà la referència UTR
			    my $gi = <STDIN>;
			    chomp($gi); 
			    print "Fetching gi ", $gi, " ... ";
			    my $seq = $gb->get_Seq_by_gi($gi); # GI Number
                            $sec_ref = $seq->seq();
                            $id = $seq->display_id();  ## Obté la seqüència de la referència UTR
#                            print $sec_ref."\n";
			    print "done."."\n";
			    
#			     my @features = $seq->get_SeqFeatures(); # just top level
#			     foreach my $feat ( @features ) {
#			     	 if( $feat->primary_tag eq 'CDS' ) {
#			            ( $prot_id )= $feat->get_tag_values('protein_id');
				    
#			     	     print "Fetching prot id ", $prot_id, " ... ";
#			     	     my $prot_obj = $gb->get_Seq_by_acc( $prot_id );
			       #     my $prot_obj = $gb->get_Seq_by_acc( $gi );
#			     	     print "done."."\n";
				    
			     	     print "Writting fasta ... \n";
				    
#			     #	     my $out->write_seq( $prot_obj );
#			     	     $sec_ref=$prot_obj->seq();
#			     	     print "done."."\n";

			     	     open REF,">ref.fasta"; ## Escriu a ref.fasta la referència 
                                     print REF ">".$id."\n";
                                     print REF $sec_ref."\n";
                                     print "done\n";
#			     	     chomp(my $ref=<REF>);
#			     	     print REF ">".$prot_id."\n";
#			     	     print REF $sec_ref."\n";		 
#			     	     print OUTFILE ">".$prot_id."\n";
#				     print OUTFILE "$ref\n";
#			     	     print OUTFILE "$secuencia\n";
                                    close REF;

#				}
				 
# 			    }

#########Obtindre la com a primera linea la referncia ############
   # my $out;
   # my $id;
   # my $in  = Bio::SeqIO->new(-file => "$line" , -format => 'Fasta');
   # while ( my $seq = $in->next_seq() ) {
   # 	 my $id= $seq->id();
   # 	 my $out=$seq->seq();
    
   # print   OUTFILE ">".$id."\n".$out."\n";
   # }

#######tblastn#######
chomp($line);
print "Performing BLAST process..";
system("blastall -p blastn -v 12000 -d database/${line}.database -i ref.fasta -e 0.001 -m 7 -o ${line}_blastN_UTR.xml");
print "done\n";



#######parseo blastxml#######    
# #			    chomp($line);
# 			    my $blast_report = "$line.xml";
# #			    chomp($blast_report);
# #			    print $blast_report;
# #			    print "Enter blast_report file name\n";
# #			    my $blast_report = <STDIN>;

# 			    my $searchio = new Bio::SearchIO (-format => 'blastxml',
# 							      -file   => $blast_report);
# #			    my $nt_seqs = new Bio::SeqIO (-format => 'fasta',
# #							  -file   => 'pla2_all_correct_frame.fasta');

# 			    my $query;
# 			    my $qstart;
# 			    my $qend;
# 			    while( my $result = $searchio->next_result ) {
# #				my $a=0;
# 				while(my $hit = $result->next_hit){
# 				    my  $hit_name = $hit->name;
# #				    print $hit_name,"\n";
# 				    my $query = $result->query_name();
# #				    print $query,"\n";
# #				    my $desc=$hit->description();
# #				    if ($hit_name eq "uaccno=FGSMDPN09FM4Z2") {
# 					while (my $hsp = $hit->next_hsp ){
# #					    my $percentid = $hsp->percent_identity();
# #					    my $score = $hit->bits();
# #					    my $start = $hsp->start('hit');
# #					    my $end = $hsp->end('hit');		
# 					    my $hit_string = $hsp->hit_string;
# #					    my $homo_string = $hsp->homology_string ;
# #					    my $query_string = $hsp->query_string;
# #					    $qstart = $hsp->start('query');
# #					    $qend = $hsp-> end ('query');	
# #					    $a++;
# 					}

# 					if ($hit_string =~ s/-//g ){
					    
# 					    print OUTFILE ">".$hit_name."\n".$hit_string,"\n";
# 					}else{
# 					    print OUTFILE ">".$hit_name."\n".$hit_string,"\n";
					    

# 					}
# #					my @query_start = $qstart;
# #					my @query_end = $qend;
# #					print $hit_name . ' ' . "@query_start" .' ' . "@query_end\n";

# #				    }
# #				    print $query,"\n";
# 				    # foreach( my $seq= $nt_seqs->next_seq) {	
# 				    # 	my $id=$seq->display_id;
# 				    # 	print $id,"\n";
# 				    # 	print $qstart,"\n";
					
# 				    # 	if ($id == $hit_name){
# 				    # 	    print $query,"\n";
# 				    # 	    print "a"."\n"}
# 				    }
				
#                              }
#  close OUTFILE;

######## Sequence alignment ##########
#system("./mafft_shortreads --clustalout --retree 2 --maxiterate 16 --bl 62 --op 1.53 --ep 0.0000 outfile.txt > $line\_mafft");
#print "Aligning with COBALT...";
#system("./cobalt -rpsdb ~/programes/cobalt/cdd_clique_0.75 -p ~/programes/cobalt/patterns -i outfile.txt > ${line}_cobalt");
#print "done.\n";
#system ("./consensus.linux $line\_cobalt > $line\_consensus");
#########

# print "Aligning with COBALT... ";
# my $seq_in= Bio::SeqIO->new ( "-file"   => "outfile.txt",  "-format" => "Fasta" );
# my $a = 1;
#      while( my $inseq = $seq_in->next_seq ) {
# 	 my $id = $inseq->id();
# 	 my $sec = $inseq->seq();
# 	 open IN, "<ref.fasta";
# 	 my @ref = <IN>;
# 	 open OUT, ">temp";
# 	 print OUT @ref;
# 	 print OUT ">".$id."\n".$sec."\n";
# 	 close OUT;
# 	 close IN;
# 	 system("./cobalt -rpsdb ~/programes/cobalt/cdd_clique_0.75 -clusters F -p ~/programes/cobalt/patterns -i temp >> temp2");
# 	 system("rm temp");
# }
# print "done.\n";

# open OUT, ">".$line."_cobalt";
# my $in= Bio::SeqIO->new ( "-file"   => "temp2",  "-format" => "Fasta" );
# print OUT ">".$prot_id."\n".$sec_ref."\n";
# while( my $inseq = $in->next_seq ) {
#     my $id = $inseq->id();
#     if($id ne $prot_id){
# 	my $sec = $inseq->seq();
# 	print OUT ">".$id."\n".$sec."\n";
#     }
# }
# system("rm temp2");
# close OUT;
