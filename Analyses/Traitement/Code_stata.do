*Un premier traitement de la table a été effectué sous sas *
*installation du Package /extension nécessaire pour la création de tableau de type publication*
ssc install estout, replace

*Importation de la table*
import excel "C:\Users\Boris\Desktop\ECD\Mémoire\Sujet 2\Projet\Données\table_etude.xlsx", sheet("table_etude") firstrow


*Statistiques descriptives*
*statistiques descriptives générales*
sum 

*statistiques descriptives des variables à étudier*
by traitement, sort : summarize contribution, detail 
by traitement, sort : summarize seuil, detail
by traitement, sort : summarize transgression, detail

*histogramme de la répartition des contributions et des seuils au round 1 par traitement* 
histogram contribution if round=="01", discrete frequency xtitle(Contribution au compte collectif) by(, title(Distribution des contributions à la première période par traitement)) by(traitement) 
histogram seuil if round=="01", discrete frequency xtitle(seuil de contribution minimum au compte collectif) by(, title(Distribution des seuils à la première période par traitement)) by(traitement) 

*statistiques descriptives des variables à étudier par groupe*
by groupe, sort : summarize contribution if traitement==0, detail
by groupe, sort : summarize seuil if traitement==0, detail
by groupe, sort : summarize transgression if traitement==0, detail
by groupe, sort : summarize contribution if traitement==1, detail
by groupe, sort : summarize seuil if traitement==1, detail
by groupe, sort : summarize transgression if traitement==1, detail

*étude de l'ensemble des round*
destring round, replace
*création d'une variable faisant la moyenne des contributions au compte collectif par round et par traitement*
by traitement round, sort : egen float contribution_moy = mean(contribution)
*graphique d'évolution des contributions par round et traitement*
twoway (line contribution_moy round if traitement==0, connect(direct)) (line contribution_moy round if traitement==1, lcolor(blue)), scheme(economist)

*création d'une variable faisant la moyenne des seuils de contribution minimum au compte collectif par round et par traitement*
by traitement round, sort : egen float seuil_moy = mean(seuil)
*graphique d'évolution des contributions par round et traitement*
twoway (line seuil_moy round if traitement==0, connect(direct)) (line seuil_moy round if traitement==1, lcolor(blue)), scheme(economist)

*création d'une variable faisant la moyenne transgression au seuil par round et par traitement*
by traitement round, sort : egen float transgression_moy = mean(transgression)
*graphique d'évolution des contributions par round et traitement*
twoway (line transgression_moy round if traitement==0, connect(direct)) (line transgression_moy round if traitement==1, lcolor(blue)), scheme(economist)


*Comparaison des traitements avec test de Mann-Whitney*
*Création d’une variable représentant l’homogénéité, ainsi qu’une autre, représentant la coopération
generate int homogene = 0
generate int coop = 0

replace homogene = 1 if groupe==3 | groupe==4
replace coop = 1 if groupe==2 | groupe==3

*Contrôle des hypothèses posant les bases de notre étude*
*Seuil des superviseurs identiques selon les supervisés*
*Comparaison des seuils des traitements sans informations entre les groupes homogènes*
ranksum seuil if traitement == 0 & homogene == 0, by(groupe) 
* Comparaison des seuils des traitements sans informations entre les groupes hétérogènes *
ranksum seuil if traitement == 0 & homogene == 1, by(groupe)
*Comparaison des contributions des traitements sans informations entre les groupes homogènes*
ranksum contribution if traitement == 0 & homogene == 0, by(groupe)
* Comparaison des contributions des traitements sans informations entre les groupes hétérogènes *
ranksum contribution if traitement == 0 & homogene == 1, by(groupe)

*Comparaison des cas, groupe, traitement selon nos conjonctures*
*Comparaison des seuils des traitements sans informations entre les groupes homogènes et hétérogènes*
ranksum seuil if traitement == 0, by(homogene) 
*Comparaison des contributions des traitements sans informations entre les groupes homogènes et hétérogènes*
ranksum contribution if traitement == 0, by(homogene) 


*Comparaison des contributions des groupes homogènes coopératifs entre les deux traitements *
ranksum contribution if groupe==1, by(traitement) 
*Comparaison des contributions des groupes homogènes non coopératifs entre les deux traitements *
ranksum contribution if groupe==2, by(traitement) 
*Comparaison des contributions des groupes hétérogène avec supervisés non coopératifs entre les deux traitements *
ranksum contribution if groupe==3, by(traitement)
*Comparaison des contributions des groupes hétérogène avec supervisés coopératifs entre les deux traitements *
ranksum contribution if groupe==4, by(traitement)
*Comparaison des contributions des groupes homogènes entre les deux traitements*
ranksum contribution if homogene==0, by(traitement) 
*Comparaison des contribution des groupes hétérogènes entre les deux traitements*
ranksum contribution if homogene==1, by(traitement)


*Réalisation des régression économétrique*
*Etude au round 1 lorsque les données sont encore iid*
*Etudes des variables d’intérêt uniquement*
*Régréssion linéaire*
regress contribution groupe traitement session if round==1
*Tobit*
tobit contribution groupe traitement session if round==1, ll(0) ul(20)
*Probit*
probit contribution groupe traitement session if round==1
*Logit*
logit contribution groupe traitement session if round==1

*Ajout des variables de contrôle et des variables explicatives*
*Régression linéaire*
regress contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition if round==1
*Tobit*
tobit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition if round==1, ll(0) ul(20)
*Probit*
probit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition if round==1
*Logit*
logit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition if round==1


*extension à tous les rounds*
*Etudes des variables d’intérêt uniquement*
*Régréssion linéaire*
regress contribution groupe traitement session round
*Tobit*
tobit contribution groupe traitement session round, ll(0) ul(20)
*Probit*
probit contribution groupe traitement session round
*Logit*
logit contribution groupe traitement session round

*Ajout des variables de contrôle et des variables explicatives*
*Régression linéaire*
regress contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition round
*Tobit*
tobit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition round, ll(0) ul(20)
*Probit*
probit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition round 
*Logit*
logit contribution groupe traitement session homogene seuil sexe etudiant domaine_etude diplome couple premiere_participation confiance prediction_autre_contribution prediction_seuil punition if round

*extraction de la régression sous format latex*
*Après la ligne de code de la régression voulue réaliser les deux lignes suivante*
*Enregistrement de la régression sous un nom*
estimates store NOM
*Extraction du tableau en format .tex*
esttab NOM using "CH

