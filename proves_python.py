#! /usr/bin/python3
# coding=utf-8

#dict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
f1=open('/home/bec2-jcalvete/Documents/Dociencia/salutacio.txt', 'w+')
noms={"Carme":"cnavarro", "Elena":"egomez", "María Victoria":"vherreras", "Rosa":"rblasco", "María Dolores":"dnavarro", 
      "Amparo María":"apiquer", "Isabel":"imunuera", "María José":"mjhernandez","Laura":"lpla","Rosalia":"rvila",
      "Mª Gema":"gcarramiñana","Adela":"avillanueva","Núria":"ngonzalez","Asunción":"azaragoza","Raúl":"respilez", 
      "Manuel":"mcardeñosa"}

for key in noms:
#     print key, 'corresponds to', noms[key]

    carta= """Hola %s,
tal i com pots veure en el següent enllaç (http://bit.ly/2mzY8Bz) has estat admés de forma definitiva a DoCiència 2017.
Per tal de poder gaudir de determinades avantatges des de la nostra pàgina web (www.dociencia.cat) com l'accés al material de classe, un fòrum d'intercanvi d'idees / informació i a la nostra llista de correu, t'enviem el teu usuari i contrasenya, que recomanem que canvies en iniciar la sessió.
Un cop fet això t'apareixerà un nou menú amb l'opció d'accedir al fòrum, als documents del curs, i l'opció de subscriure't a la llista de correu.
Esperem que aquest canal de comunicació siga útil per exposar qualsevol tema del vostre interés. Qualsevol problema no dubtes a fer-nos-ho saber a informacio@dociencia.cat.

Et donem la benvinguda i t'esperem veure a la conferència inaugural que tindrà lloc el divendres dia 10 de març a la Biblioteca Eduard Boscà (Campus de Burjassot) de la Universitat de València.

Una salutació i fins divendres.


Usuari / usuària: %s
Password: 123456
""" % (key, noms[key])

    f1.write(carta)

