#! /usr/bin/python3

""" Script per obtindre les característiques principals dels contigs cclassificats com a bad per transrate del total de transcripts obtinguts per oases a un determinat kmer """
import re
import os

directori="/home/bec2-jcalvete/Feina_Jordi/MALPOLON/150807_SND405_A_L003_GZX-17/results/assembly/Oases/69"
try:
	filename=directori + "/contigs.csv"
	filename_bad=directori + "/bad.69_transcripts.fa"
	output=directori + "/stats.csv"
	out=open(output,"a")
	arxiu_bad=open(filename_bad)
	arxiu=open(filename)
	llista=[]
	
	for line in arxiu_bad:
		linea=re.findall("^>(.+)", line)
		if len(linea) > 0:
			llista.append(linea[0])
# 		paraula=line.split(",")
# 		llista.append(paraula[0])
	#a= 0
	for line in arxiu:	
		paraula=line.split(",")
		header=re.findall("contig_name.+", line)
		if len(header) > 0:
			#print header
			for feature in header:
				feat = feature + ","
				out.write(feat.rstrip())
 		if paraula[0] in llista:
			#a = a + 1
			#print paraula
  			for item in paraula:
  				name = item + ","
 				out.write(name.rstrip())
			
	#print a	
	out.close()
	print "Done"
	
except:
	print "No puc obrir l'arxiu", file
		
		