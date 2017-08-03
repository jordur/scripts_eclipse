#!/bin/bash

EXPECTED_ARGS=2 # Number of arguments expected in the script call
E_BADARGS=65    # Error code in case of bad arguments  

## Check que enviem els resultats a un directori en concret ##
if [ ${#} -ne $EXPECTED_ARGS ]
    then
    echo ''
    echo 'ERROR : Check input parameters: falta directori de sortida o fitxer d'entrada'
    echo 'Usage: sh script_class DIRECTORI fitxer_d'entrada'
    echo ''
    exit $E_BADARGS
fi

cd $1

## Creem estructura de directoris ##

if [ ! -d class_script ]
	then
	mkdir -p class_script/final
	else
	echo "Ja existeix el directori class_script"
fi

### Grep de totes les toxines ##
#grep -i kunitz $2 > ./class_script/kunitz

#limpiamos all_hits
#grep -v -i dehydrogenase $2 |grep -v  -i gPL1 |grep -v -i  gPLI |grep -v -i ribosomal |grep -v -i inhibitor |grep -v -i glutaminyl |grep -v -i TATA |grep -v -i reverse|grep -v -i mitochond| grep -v -i microsatellite | grep -v -i cytochr > blast_clean

#general
#grep -i atrolysin blast_clean > ./class_script/reprolysin
#grep -i disintegrin blast_clean >> ./class_script/reprolysin
#grep -i c-type blast_clean | grep lectin > ./class_script/c-type
#grep -i metalloprot blast_clean >> ./class_script/reprolysin
#grep -i l-amino blast_clean > ./class_script/l-amino
#grep -i l_amino blast_clean > ./class_script/l-amino
#grep -i phospholipase blast_clean > ./class_script/pla2
#grep -i vascular blast_clean | grep  endothelial > ./class_script/growth_factors
#grep -i vascular blast_clean | grep apoptosis  >> ./class_script/reprolysin
#grep -i plasminogen blast_clean > ./class_script/serine_protease
#grep -i venom blast_clean > ./class_script/venom
#grep -i VEGF blast_clean >> ./class_script/growth_factors
#
#classifiquem platelet
#grep -i platelet blast_clean | grep -i peptidase >> ./class_script/serine_protease
#grep -i platelet blast_clean | grep -i convulxin >> ./class_script/c-type
#grep -i platelet blast_clean | grep -i proteinase >> ./class_script/serine_protease
#grep -i platelet blast_clean | grep -i botrocetin >> ./class_script/c-type
#grep -i platelet blast_clean | grep -i IB-binding >> ./class_script/c-type
#
# classifiquem serine_prot
#grep -i serine blast_clean | grep -i protease >> ./class_script/serine_protease
#grep -i serine blast_clean | grep -i proteinase >> ./class_script/serine_protease
#grep -i serine blast_clean | grep -i peptidase >> ./class_script/serine_protease
#grep -i serine blast_clean | grep -i thrombin >> ./class_script/serine_protease
#grep -i serine blast_clean | grep -i "threonine-protein_kinase" >> ./class_script/serine_protease
#grep -i fibrinogenase blast_clean | grep -i serine >> ./class_script/serine_protease
#grep -i fibrinogenase blast_clean | grep -i brevinase >> ./class_script/serine_protease
#
#classifiquem bothrops
#grep -i bothrops blast_clean | grep  growth >> ./class_script/growth_factors
#grep -i bothrops blast_clean | grep  KN-BJ2 >> ./class_script/serine_protease
#grep -i bothrops blast_clean | grep   bothropasin >> ./class_script/reprolysin
#grep -i bothrops blast_clean | grep   M1-3-3 >> ./class_script/pla2
#grep -i bothrops blast_clean | grep   bothrostatin >> ./class_script/reprolysin
#grep -i bothrops blast_clean | grep   berythractivase >> ./class_script/reprolysin
#grep -i bothrops blast_clean | grep   insularinase >> ./class_script/reprolysin
#grep -i bothrops blast_clean | grep   bothojaracin >> ./class_script/c-type
#grep -i bothrops blast_clean | grep   -i serine | grep -i protease >> ./class_script/serine_protease
#grep -i bothrops blast_clean | grep  -i myotoxin >> ./class_script/pla2
#grep -i bothrops blast_clean | grep  batroxobin >> ./class_script/serine_protease
#grep -i bothrops blast_clean | grep   hypothetical >> ./class_script/serine_protease
#grep -i bothrops blast_clean | grep -v KN-BJ2 | grep -v bothojaracin | grep -v insularinase | grep -v berythractivase | grep -v bothrostatin | grep -v M1-3-3 | grep -v bothropasin | grep -v -i C-type | grep -v growth | grep -v -i phospholipase |grep -v serine | grep -v bradykinin | grep -v metalloprot | grep -v myotoxin | grep -v batroxobin | grep -v hypothetical | grep -v -i L-amino | grep -v thrombin-like > ./class_script/002bothrops
#
#classifiquem crotalus
#grep -i crotalus blast_clean | grep  growth >> ./class_script/growth_factors
#grep -i crotalus blast_clean | grep  crotamine > ./class_script/sbmp
#grep -i crotalus blast_clean | grep  crotasin >> ./class_script/sbmp
#grep -i crotalus blast_clean | grep  catrocollastatin >> ./class_script/reprolysin
#grep -i crotalus blast_clean | grep  catroriarin >> ./class_script/reprolysin
#grep -i crotalus blast_clean | grep  catroriarin >> ./class_script/reprolysin
#grep -i crotalus blast_clean | grep  crotastatin >> ./class_script/reprolysin
#grep -i crotalus blast_clean | grep  crotocetin >> ./class_script/c-type
#grep -i crotalus blast_clean | grep  viristiarin >> ./class_script/reprolysin
#grep -i crotalus blast_clean | grep PLA2 >> ./class_script/pla2
#grep -i crotalus blast_clean | grep -i cysteine >> ./class_script/c-type
#grep -i crotalus blast_clean | grep -i crisp > ./class_script/crisp
#grep -i crotalus blast_clean | grep -i Cathelicidin >> ./class_script/022toxin
#grep -i crotalus blast_clean | grep -i kallikrein >> ./class_script/serine_protease
#
#classifiquem trimeresurus
#grep -i trimeresurus blast_clean | grep flavoridin >> ./class_script/reprolysin
#grep -i trimeresurus blast_clean | grep elegantin >> ./class_script/reprolysin
#grep -i trimeresurus blast_clean | grep trimutase >> ./class_script/reprolysin
#grep -i trimeresurus blast_clean | grep  serpentokallikrein >> ./class_script/serine_protease
#grep -i trimeresurus blast_clean | grep  triflin >> ./class_script/crisp
#grep -i trimeresurus blast_clean | grep  trimubin >> ./class_script/serine_protease
#grep -i trimeresurus blast_clean | grep  growth >> ./class_script/growth_factors
#grep -i trimeresurus blast_clean | grep  flavocetin >> ./class_script/c-type
#grep -i trimeresurus blast_clean | grep  jerdonitin >> ./class_script/reprolysin
#grep -i trimeresurus blast_clean | grep  phosphlipase >> ./class_script/pla2
#grep -i trimeresurus blast_clean | grep  stejaggregin >> ./class_script/c-type
#grep -i trimeresurus blast_clean | grep  cysteine-rich >> ./class_script/crisp
#grep -i trimeresurus blast_clean | grep  IX >> ./class_script/c-type
#
#grep -i  trimeresurus blast_clean | grep -v serpentokallikrein | grep -v -i C-type | grep -v triflin  | grep -v metalloprot | grep -v trimubin| grep -v plasminogen| grep -v growth | grep -v trimutase | grep -v phospholipase |grep -v apoptosis | grep -v elegantin | grep -v flavoridin | grep -v serine | grep -v flavocetin | grep -v jerdonitin | grep -v stejaggregin | grep -v cysteine-rich | grep -v -i L-amino | grep -v -i IX | grep -v phosphlipase > ./class_script/023trimeresurus
#
#classifiquem vipera
#grep -i vipera blast_clean | grep VLAIP >> ./class_script/reprolysin
#grep -i vipera blast_clean | grep  disintegrin >> ./class_script/reprolysin
#grep -i vipera blast_clean | grep  cysteine-rich >> ./class_script/crisp
#grep -i vipera blast_clean | grep  factor | grep activator >> ./class_script/reprolysin
#grep -i vipera blast_clean | grep ammodytin  >> ./class_script/pla2
#grep -i vipera blast_clean | grep -v phospholipase | grep -v VLAIP | grep -v metalloprot | grep -v disintegrin | grep -v stejnihagin | grep -v cysteine-rich | grep -v ammodytin > ./class_script/026vipera.sort
#
#classifiquem bpp
#grep -i bpp blast_clean > ./class_script/bpp
#grep -i c-type blast_clean | grep natriuretic >> ./class_script/bpp
#grep -i bradykinin blast_clean >> ./class_script/bpp
#grep -i c-type blast_clean | grep bradykinin >> ./class_script/bpp
#
#classifiquem thrombin
#grep -i thrombin blast_clean | grep -i like >> ./class_script/serine_protease
#grep -i thrombin blast_clean | grep AY091755 >> ./class_script/c-type
#grep -i thrombin blast_clean | grep AY091762 >> ./class_script/c-type
#grep -i thrombin blast_clean | grep -i trocarin >> ./class_script/serine_protease
#grep -i thrombin blast_clean | grep AY261531 >> ./class_script/reprolysin
#grep -i thrombin blast_clean | grep DQ377325 >> ./class_script/reprolysin
#
#classifiquem toxin
#grep -i toxin blast_clean | grep -i myotoxin >> ./class_script/pla2
#grep -i toxin blast_clean | grep -i three > ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i weak >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i Mojave >> ./class_script/pla2
#grep -i toxin blast_clean | grep -i crotoxin >> ./class_script/pla2
#grep -i toxin blast_clean | grep -i cardiotoxin >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i denmotoxin >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i cobrotoxin >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i neurotoxin | grep -v TR2997AY425950.1 >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i neurotoxin | grep -i AY425950.1 >> ./class_script/pla2
#grep -i toxin blast_clean | grep -i gamma >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -i kappa >> ./class_script/snake_domain
#grep -i toxin blast_clean | grep -v three | grep -v myotoxin | grep -v atrolysin | grep -v weak | grep -v Mojave| grep -v crotoxin | grep -v cardiotoxin | grep -v -i denmotoxin | grep -v -i cobrotoxin | grep -v -i neurotoxin | grep -v -i gamma | grep -v -i kappa > ./class_script/022toxin
#
#classifiquem venom
#grep -i venom blast_clean | grep -i cysteine-rich  >> ./class_script/crisp
#grep -i venom blast_clean | grep -i cobra  > ./class_script/cvf
#
#classifiquem CRISP
#grep -i tigrin blast_clean >> ./class_script/crisp
#grep -i Q8UW25 blast_clean >> ./class_script/crisp
#grep -i pseudech blast_clean >> ./class_script/crisp
#grep -i Serotriflin blast_clean >> ./class_script/crisp
#grep -i latisemin blast_clean >> ./class_script/crisp
#grep -i ophanin blast_clean >> ./class_script/crisp
#grep -i opharin blast_clean >> ./class_script/crisp
#grep -i pseudechetoxin blast_clean >> ./class_script/crisp
#grep -i Pseudechin blast_clean >> ./class_script/crisp
#
#
#altres
#grep -i stejnihagin blast_clean >> ./class_script/reprolysin
#grep -i fibrinogenase blast_clean | grep -v serine | grep -v brevinase >> ./class_script/reprolysin
#grep -i brevinase blast_clean  >> ./class_script/serine_protease
#grep -i acurhagin blast_clean >> ./class_script/reprolysin
#grep -i ablomin blast_clean >> ./class_script/crisp
#grep -i agkihagin blast_clean >> ./class_script/reprolysin
#grep -i halystatin blast_clean >> ./class_script/reprolysin
#grep -i halysetin blast_clean >> ./class_script/reprolysin
#grep -i acostatin blast_clean >> ./class_script/reprolysin
#grep -i piscivorin blast_clean >> ./class_script/crisp
#grep -i calobin blast_clean >> ./class_script/serine_protease
#grep -i apiscin blast_clean >> ./class_script/growth_factors
#grep -i halyxin blast_clean >> ./class_script/c-type
#grep -i mamushigin blast_clean >> ./class_script/c-type
#grep -i alboaggregin blast_clean >> ./class_script/c-type
#grep -i natrin blast_clean >> ./class_script/crisp
#grep -i kaouthin blast_clean >> ./class_script/crisp
#grep -i ecarin blast_clean >> ./class_script/reprolysin
#grep -i dislicrin blast_clean >> ./class_script/reprolysin
#grep -i contortrostatin blast_clean >> ./class_script/reprolysin
#grep -i agkicetin blast_clean >> ./class_script/c-type
#grep -i defiberase blast_clean >> ./class_script/serine_protease
#grep -i agglucetin blast_clean >> ./class_script/c-type
#grep -i piscivostatin blast_clean >> ./class_script/reprolysin
#grep -i jararhagin blast_clean >> ./class_script/reprolysin
#grep ctx blast_clean >> ./class_script/snake_domain
#grep -i salmobin blast_clean >> ./class_script/serine_protease
#grep -i LAO blast_clean >> ./class_script/l-amino
#grep -i permeability blast_clean >> ./class_script/serine_protease
#grep -i trigramin blast_clean >> ./class_script/reprolysin
#grep -i acutolysin blast_clean >> ./class_script/reprolysin
#grep -i aggretin blast_clean >> ./class_script/c-type
#grep -i catrin blast_clean >> ./class_script/crisp
#grep -i coagulation blast_clean | grep IX-binding >> ./class_script/c-type
#grep -i coagulation blast_clean | grep Tropidechis >> ./class_script/serine_protease
#grep -i convulxin blast_clean >> ./class_script/c-type
#grep -i hemorrhagic blast_clean | grep -v atroxase | grep -v antihemo >> ./class_script/reprolysin
#grep -i hemorrhagic blast_clean | grep -i atroxase >> ./class_script/serine_protease
#grep -i ophiophagus  blast_clean | grep -i L-amino >> ./class_script/l-amino
#grep -i ophiophagus  blast_clean | grep -i ohanin > ./class_script/ohanin
#grep -i ohanin blast_clean >> ./class_script/ohanin
#grep -i vespryn blast_clean >> ./class_script/ohanin
#grep -i lipocalin blast_clean >> ./class_script/novel
#grep -i vitelline blast_clean >> ./class_script/novel
#grep -i vitellogenin blast_clean >> ./class_script/novel
#grep -i veficolin blast_clean >> ./class_script/novel
#grep -i ficolin blast_clean >> ./class_script/novel
#grep -i pseutarin blast_clean >> ./class_script/novel
#grep -i fusin blast_clean >> ./class_script/novel
#grep -i candoxin blast_clean >> ./class_script/3ftx
#grep -i ryncolin blast_clean >> ./class_script/novel
#grep -i lebein blast_clean >> ./class_script/reprolysin
#grep -i pictobin blast_clean >>./class_script/novel
#grep -i defensin blast_clean >>./class_script/novel
#
#classifiquem SVSPs
#grep -i acubin blast_clean >> ./class_script/serine_protease
#grep -i gyroxin blast_clean >> ./class_script/serine_protease
#grep -i ussurase blast_clean >> ./class_script/serine_protease
#grep -i nikobin blast_clean >> ./class_script/serine_protease
#grep -i gloshedobin blast_clean >> ./class_script/serine_protease
#grep -i gussurobin blast_clean >> ./class_script/serine_protease
#grep -i pallabin blast_clean >> ./class_script/serine_protease
#grep -i pallase blast_clean >> ./class_script/serine_protease
#
#classifiquem SVMPS
#grep -i mocarhagin blast_clean >> ./class_script/reprolysin
#grep -i scutatease blast_clean >> ./class_script/reprolysin
#grep -i austrelease blast_clean >> ./class_script/reprolysin
#grep -i "atrase b" blast_clean >> ./class_script/reprolysin
#
#classifiquem SVGFs
#grep -i barietin blast_clean >> ./class_script/growth_factors
#grep -i cratrin blast_clean >> ./class_script/growth_factors
#grep -i vammin blast_clean >> ./class_script/growth_factors
#grep -i thaicobrin blast_clean >> ./class_script/ohanin
#
####Toxines minoritàries
#egrep -i "nucleotidase|118151735|211926753|211926755" blast_clean > ./class_script/5-nucleotidase
#
#egrep -i "15991079|glutaminyl|110264413|3868930|89242376" blast_clean > ./class_script/glutaminyl
#
#egrep -i "113203666|113203668|113203672|113203674|113203682|113203686|113203690|113203692|hyaluro*"  blast_clean > ./class_script/hyaluronidase
#
#egrep -i "159146285|kunitz|185534801|185534856"  blast_clean >> ./class_script/kunitz
#
#egrep -i "109254993|phosphodiesterase" blast_clean > ./class_script/phosphosdiest
#
#egrep -i "waprin|Phi3|156485571|156485577" blast_clean > ./class_script/waprin
#
#egrep -i "sarafo|222783" blast_clean > ./class_script/sarafo
#
####SwissProt
#grep "Q06ZW0" blast_clean >> ./class_script/3ftx
#grep "AY142323" blast_clean >> ./class_script/3ftx
#grep "AAO62994" blast_clean >> ./class_script/crisp
#grep "AAO62995" blast_clean >> ./class_script/crisp
#grep "AAM45664" blast_clean >> ./class_script/crisp
#grep "Q8JGT9" blast_clean >> ./class_script/crisp
#grep "ACH73167" blast_clean >> ./class_script/crisp
#grep "ACH73168" blast_clean >> ./class_script/crisp
#grep "Q7T1K6" blast_clean >> ./class_script/crisp
#grep "Q8UW25" blast_clean >> ./class_script/crisp
#grep "Q8UW11" blast_clean >> ./class_script/crisp
#grep "Q8AVA4" blast_clean >> ./class_script/crisp
#grep "Q8AVA3" blast_clean >> ./class_script/crisp
#grep "P0CB15" blast_clean >> ./class_script/crisp
#grep "Q8JI38" blast_clean >> ./class_script/crisp
#grep "AAO62996" blast_clean >> ./class_script/crisp
#grep "ACN93671" blast_clean >> ./class_script/crisp
#grep "ACE73577" blast_clean >> ./class_script/crisp
#grep "ACE73578" blast_clean >> ./class_script/crisp
#grep "ADK46899" blast_clean >> ./class_script/crisp
#grep "D8VNS7" blast_clean >> ./class_script/novel
#grep "D8VNT0" blast_clean >> ./class_script/novel
#grep "CAB46431" blast_clean >> ./class_script/serine_protease
#grep "B0FXM3" blast_clean >> ./class_script/serine_protease
#grep "AAL48222" blast_clean >> ./class_script/serine_protease
#grep "AAG27254" blast_clean >> ./class_script/serine_protease
#grep "AAC61838" blast_clean >> ./class_script/serine_protease
#grep "AAA48553" blast_clean >> ./class_script/serine_protease
#grep "CBW30778" blast_clean >> ./class_script/serine_protease
#grep "POC5B4" blast_clean >> ./class_script/serine_protease
#grep "Q8UVX" blast_clean >> ./class_script/serine_protease
#grep "CAA04612" blast_clean >> ./class_script/serine_protease
#grep "AAC34898" blast_clean >> ./class_script/serine_protease
#grep "ABA40759" blast_clean >> ./class_script/reprolysin
#grep "AAC61986" blast_clean  >> ./class_script/reprolysin
#grep "ADG02948" blast_clean >> ./class_script/reprolysin
#grep "AAM51550" blast_clean >> ./class_script/reprolysin
#grep "ABQ01138" blast_clean >> ./class_script/reprolysin
#grep "ABQ01134" blast_clean >> ./class_script/reprolysin
#grep "ACN22038" blast_clean >> ./class_script/growth_factors
#grep "ACN22040" blast_clean >> ./class_script/growth_factors
#grep "ACN22039" blast_clean >> ./class_script/growth_factors
#grep "ACN22045" blast_clean >> ./class_script/growth_factors
#grep "AAR07992" blast_clean >> ./class_script/ohanin
#grep "P82885" blast_clean >> ./class_script/ohanin
#grep "B5L5N" blast_clean >> ./class_script/waprin
#grep "B5G6H3" blast_clean >> ./class_script/waprin
#grep "B5L5P5" blast_clean >> ./class_script/waprin
#grep "B5G6H5" blast_clean >> ./class_script/waprin
#grep "B5L5P0" blast_clean >> ./class_script/waprin
grep -i veficolin blast_clean >> ./class_script/veficolin
grep -i calglandulin blast_clean >> ./class_script/calglandulin

echo "Done"
cd class_script
#find ./ -name "*" -size 0 -exec rm {} \; ## Eliminem arxius buits
#find  ./ -empty -type f -delete
#for file in `ls -al | grep ^- | awk '{print $NF}'`; do sort $file | uniq > final/${file}.class.txt; done
