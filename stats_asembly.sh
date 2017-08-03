dir="/home/bec2-jcalvete/Feina_Jordi/Minion/Echis/FAE31750/temp"
#echo $dir
echo "K-mer,Total_contigs,Reads>1000nt,Reads>3000nt,Reads>5000nt,Reads>10000nt,Reads>20000n,Reads>30000nt,Max_length,Total_nt,Avrge_length,N50" > $dir/header	 
#for i in `seq 1 1 7`; do
	#	for j in `seq 25 2 69`;do
		cd $dir;
		#name=`echo $i | awk -F "/" '{print $NF}'`
		resultado=`grep -c ">" Echis_2.fasta`
		#echo $resultado
 		/home/bec2-jcalvete/Feina_Jordi/scripts/repositori_SSGG/scripts/deprecated/length_fasta.pl Echis_2.fasta | awk '{print $2}'| sort -nr > $dir/t
 		long=`awk '{if ($1>1000) print}' $dir/t | wc -l`
  		long2=`awk '{if ($1>3000) print}' $dir/t | wc -l`
  		long3=`awk '{if ($1>5000) print}' $dir/t | wc -l`
  		long4=`awk '{if ($1>10000) print}' $dir/t | wc -l`
  		long6=`awk '{if ($1>20000) print}' $dir/t | wc -l`
  		long7=`awk '{if ($1>30000) print}' $dir/t | wc -l`
  		max=`head -n 1 $dir/t | awk '{print}'`
 		res2=`/home/bec2-jcalvete/Feina_Jordi/scripts/repositori_SSGG/scripts/deprecated/sg_suma_columna.pl $dir/t`
		avrge=`echo $res2/$resultado | bc`
 		n50=`/home/bec2-jcalvete/Feina_Jordi/scripts/repositori_SSGG/scripts/deprecated/quality_stats/sg_calcularN50.pl Echis_2.fasta | head -n 1`
 		echo "oasesBAC${i}_${j},$resultado,$long,$long2,$long3,$long4,$long6,$long7,$max,$res2,$avrge,$n50" >> $dir/stats_${j}
 		rm $dir/t
		
	#	done
#done
cat $dir/header $dir/stats_* >> $dir/final_stats.csv
rm $dir/header
rm $dir/stats_*
echo "Done"