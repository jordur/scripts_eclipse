#! /usr/bin/python3
""" Script per obtindre l'anotacio de les sequencies de Csimus que vaig depositar
Input 1 = arxiu amb dues columnes, la primera el nom del contig la segona el nom de la toxina
        Exemple:
        
            comp10241_c1_seq6        Snake Venom Metalloproteinase
            comp10263_c1_seq44       C-type lectin
            comp10264_c0_seq3        Snake Venom Serine Protease
            
Input 2 Exemple:
        
        3. TSA: Crotalus simus comp10264_c0_seq3 transcribed RNA sequence
        356 bp linear transcribed-RNA 
        GECP01000003.1 GI:974994090

L'objctiu de l'script es obtindre GECP01000003.1 Snake Venom Serine Protease
"""


import re
import os

directori="/home/bec2-jcalvete/Escriptori"
try:
    filename=directori+"/toxines_SRA.txt"
    filename2=directori+"/nuccore_result.txt"
    file_out=directori+"/Table_depostited_toxins.txt"
    out=open(file_out, "a")
    file=open(filename)
    file2=open(filename2)
    
 ## Manipulem un arxiu per obtindre els noms del contigs com a keys   
    toxines=dict()
    
    for line in file:
        linea=line.split("\t")
        toxines[linea[0]] = linea[1] ### Keys = nom dels contigs
    #print toxines
    
## Obrim arxiu de NCBI pEr obtindre el nom del diposit
    ncbi=dict()
    llista=[]
    for line in file2:
        if re.search("TSA", line):
            linea= re.findall(".+simus\s(.+)\stranscribed", line)
            #print linea
        elif re.search("GECP", line):
            linea2=re.findall("(GECP.+)\sGI.+", line)
            llista= linea + linea2
            #print llista
        else:
            continue
        if len(llista)>1:      
            ncbi[llista[0]]=llista[1]
    #print ncbi
    
    sharedKeys = set(toxines.keys()).intersection(ncbi.keys())
#     print len(sharedKeys)
    out.write("Cluster name"+"\t"+"Accession number"+"\t"+"Toxin"+"\n")
    for key in sharedKeys:
        out.write(key+"\t"+ncbi[key]+"\t"+toxines[key].upper())
        #out.write(ncbi[key])
    out.close()
        
         
    print "Done"
except:
    print "No puc obrir l'arxiu"