0. Was versteht ein Bioinformatiker unter der 'Cloud'?

0. RNA-Seq
    0. Welche Daten werden benötigt?
    
    0. In welchem Dateiformat liegen die Daten typischerweise vor? 
    
    0. Sind diese Dateiformate 'menschenlesbar' (nicht-binär)?
    
    0. Mit welchen Programmen kann man die Daten lesen?
    
	0. Beschreiben Sie kurz die wesentlichen Schritte, die nötig sind, RNA-Seq Daten zu prozessieren.
	
    0. Was brauche ich, um RNA-Seq Daten zu prozessieren?
    
    0. Was kostet eine solche Datenanalyse ungefähr?
    
    0. Was versteht man unter 'paired-end' reads?
    
    0. Quality Scores
        
        0. Angenommen, man soll RNA-Seq Daten prozessieren, kennt aber deren Quality Encoding nicht. Was kann ich tun?
      
        0. Aus wie viel Zeichen besteht typischerweise ein Quality String?
      
        0. Welche Information ist mit den Quality Scores abgebildet?
      
    0. 'TopHat' selbst ist kein Mapping Tool, sondern 'delegiert' diese Funktionalität an ein anderes Tool. Welches?
      
	  0. Welche Aufgabe übernimmt TopHat und warum ist das wichtig für RNA-Seq?

0. FASTA und FASTQ

    0. Was ist der Unterschied zwischen FASTA und FASTQ?
    
    0. Angenommen, man möchte einen FASTA Reader implementieren.
Auf welche zwingenden Formastspezifikationen kann man sich bei der Programmierung verlassen? 

    0. Wie sehen die Formastspezifikationen bei FASTQ aus?

    0. Wäre ein FASTA File denkbar, in dem Proteinsequenzen abgespeichert sind (Bitte begründen)? 
    
    0. Wäre ein FASTQ file denkbar, in dem Proteinsequenzen abgespeichert sind (Bitte begründen)?

0. Angenommen, wir erstellen eine Heatmap um eine Tabelle mit Expressionswerten zu visualisieren.

    0. Welche 'Schwirigkeiten' können wir dabei erwarten und wie können diese gelöst werden?

    0. Welche Informationen kann eine Heatmap liefern?
    
0. Was verstehen die meisten Programmiersprachen unter
    0. `\t`?
    0. `\n`?
    
0. R

    0. Gegeben ist folgende Tabelle `genes_diff_sig`:
    
                          gene_id sample_1 sample_2 status     value_1     value_2 log2_fold_change    test_stat p_value     q_value significant
    40584 ENSG00000241570     Lung    Heart     OK 1.20759e-93 4.32572e+00         310.7800  2.88573e-91 0.00005 0.000242192         yes
    8341  ENSG00000142615     Lung    Heart     OK 4.92158e-84 1.88555e+01         280.9800  2.62871e-81 0.00755 0.020652600         yes
    14026 ENSG00000175206     Lung    Heart     OK 1.45060e-01 3.07400e+04          17.6931  2.09519e+00 0.01435 0.035571100         yes
    52339 ENSG00000260908     Lung    Heart     OK 1.26567e+03 1.23424e-02         -16.6459 -1.25322e-01 0.01250 0.031678900         yes
    12516 ENSG00000168484     Lung    Heart     OK 2.03442e+04 3.06545e-01         -16.0182 -2.65728e+00 0.00005 0.000242192         yes
    53616 ENSG00000262304     Lung    Heart     OK 4.12227e-05 1.60871e+00          15.2521  1.08576e-02 0.01370 0.034227900         yes
    
    0. Mit welchem Befehl lässt sich aus dieser Tabelle
        0. die erste Zeile anzeigen?
        0. die erste Spalte anzeigen?
        
0. Ab welchem p-Wert spricht man üblicherweise von 'statistisch significant'?
    
0. Bash

    0. `ls`
    
        0. Welche Dateien wird mir deser Programmaufruf **nicht** anzeigen?
        0. Wie kann ich alle Dateien ausgeben lassen?
        
    0. Ein `mv --backup=numbered` hat einige Backupdateien angelgt. Die Endung ist `.~1~`, wobei die `1` einen fortlaufenden Zähler repräsentiert.
    
        0. Wie kann ich mir alle diese Backupdateien anzeigen lassen?
        
    0. Mit welcher Taste kann in der Bash eine Autovervollständigung ausgelöst werden?
    
    0. Von Ensembl wurde das menschliche Genom herunter geladen. Das Format ist FASTA (`.fa` als Dateiendung)
    Jedes Chromosom ist in einer eigenen Datei gespeichert, deren Name dem Chromosomnamen entspricht (`1.fa`, `x.fa`, `y.fa`, ...).
    Zur Datenprozessierung wird allerdings oft ein einziges FASTA File benötigt, dass alle Chromosomensequenzen enthält.
    Wie genau würde ein Programmaufruf in der Bash aussehen, diese Files in ein einziges File zu konkatenieren? 
    
    0. Ein Programm wird ausgeführt:
    `p1 my-input.txt `.
    Während der Laufzeit informiert das Programm über mehrere, nicht kritische Fehler. Es schreibt dazu auf Std Error. Das Ergebnis wird am Ende der Programmausführung nach Std Out geschrieben.
    Wie verändert sich dieses Verhalten bei einer Ausführung im Hintergrund (`p1 my-input.txt &`)?
    
    0. Ein Programm kann ein numerisches Feedback zu seiner Laufzeit geben, der sog. Exit Code.
    Mit welchem Exit Code wird typischerweise einn fehlerfreier Programmablauf signalisiert?
    
    