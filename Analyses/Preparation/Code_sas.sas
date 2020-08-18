/*Création d’une bibliothèque stockant l’ensemble des tableaux créée*/
libname etude "chemin";


/*importation de la ou des tables de données*/
proc import
	datafile = "chemin\table_de_données"
	out = etude.table_1
	dbms = xlsx
	replace;
run;


/*Suppression des participants n’ayant pas complété le jeu*/
data etude.table_1 ;
set etude.table_1;
if participant__current_app_name ^= "payment_info_1_lab" then delete;
run;


/*Modification du nom des variables*/
data etude.table_1;
set etude.table_1;
rename public_goods_1_lab.1.group.type_S = type_S;
label public_goods_1_lab.1.group.type_S = "type_S";

rename public_goods_1_lab.1.group.type_W = type_W;
label public_goods_1_lab.1.group.type_W = "type_W";

rename session.code = code_session;
label session.code = "code_session";

rename participant.code = code_participant;
label participant.code = "code_participant";

rename dilemme_lab.1.player.choix_inconditionnel = choix_inconditionnel;
label dilemme_lab.1.player.choix_inconditionnel = "choix_inconditionnel";

rename dilemme_lab.1.player.choix_conditionnel = choix_conditionnel;
label dilemme_lab.1.player.choix_conditionnel = "choix_conditionnel";

rename dilemme_lab.1.player.type = type;
label dilemme_lab.1.player.type = " type ";

rename dilemme_lab.1.player.perso = premier_joueur;
label dilemme_lab.1.player.perso = "premier_joueur";

rename dilemme_lab.1.group.id_in_subsession = dilemme_groupe;
label dilemme_lab.1.group.id_in_subsession = "dilemme_groupe";

rename public_goods_1_lab.1.player.id_in_group = PGG_id_in_group;
label public_goods_1_lab.1.player.id_in_group = "PGG_id_in_group";

rename atl_Survey.1.player.sex = sexe;
label atl_Survey.1.player.sex = "sexe";

rename atl_Survey.1.player.sisters_brothers = fratrie;
label atl_Survey.1.player.sisters_brothers = "fraterie";

rename atl_Survey.1.player.student = etudiant;
label atl_Survey.1.player.student = "etudiant";

rename atl_Survey.1.player.field_of_studies = domaine_etude;
label atl_Survey.1.player.field_of_studies = "domaine_etude";

rename atl_Survey.1.player.level_of_study = diplome;
label atl_Survey.1.player.level_of_study = "diplome";

rename atl_Survey.1.player.couple = couple;
label atl_Survey.1.player.couple = "couple";

rename atl_Survey.1.player.previous_participation = premiere_participation;
label atl_Survey.1.player.previous_participation = "premiere_participation";

rename atl_Survey.1.player.confiance = confiance;
label atl_Survey.1.player.confiance = "confiance";

rename payment_info_1_lab.1.player.gain_1 = payoff_1;
label payment_info_1_lab.1.player.gain_1 = "payoff_1";

rename payment_info_1_lab.1.player.gain_2 = payoff_2;
label payment_info_1_lab.1.player.gain_2 = "payoff_2";

rename payment_info_1_lab.1.player.gain = payoff_total;
label payment_info_1_lab.1.player.gain = "payoff_total";

rename payment_info_1_lab.1.player.gain_t = payoff_euro;
label payment_info_1_lab.1.player.gain_t = "payoff_euro";


format _all_;
run;


/*Conservation des variables d’intérêt selon le code de session*/
/*Afin de conserver uniquement les sessions d’expérimentation et de supprimer les sessions de test*/
data etude.table_1 (keep= code_participant code_session type_S type_W choix_inconditionnel choix_conditionnel type premier_joueur dilemme_groupe PGG_id_in_group sexe fraterie etudiant domaine_etude diplome couple premiere_participation confiance payoff_1 payoff_2 payoff_total payoff_euro public_goods_1_lab.1.player.contribution public_goods_1_lab.2.player.contribution public_goods_1_lab.3.player.contribution public_goods_1_lab.4.player.contribution public_goods_1_lab.5.player.contribution public_goods_1_lab.6.player.contribution public_goods_1_lab.7.player.contribution public_goods_1_lab.8.player.contribution public_goods_1_lab.9.player.contribution public_goods_1_lab.10.player.contribution public_goods_1_lab.1.group.seuil_info public_goods_1_lab.2.group.seuil_info public_goods_1_lab.3.group.seuil_info public_goods_1_lab.4.group.seuil_info public_goods_1_lab.5.group.seuil_info public_goods_1_lab.6.group.seuil_info public_goods_1_lab.7.group.seuil_info public_goods_1_lab.8.group.seuil_info public_goods_1_lab.9.group.seuil_info public_goods_1_lab.10.group.seuil_info public_goods_1_lab.1.player.prediction_W_autre public_goods_1_lab.2.player.prediction_W_autre public_goods_1_lab.3.player.prediction_W_autre public_goods_1_lab.4.player.prediction_W_autre public_goods_1_lab.5.player.prediction_W_autre public_goods_1_lab.6.player.prediction_W_autre public_goods_1_lab.7.player.prediction_W_autre public_goods_1_lab.8.player.prediction_W_autre public_goods_1_lab.9.player.prediction_W_autre public_goods_1_lab.10.player.prediction_W_autre public_goods_1_lab.1.player.prediction_W_seuil public_goods_1_lab.2.player.prediction_W_seuil public_goods_1_lab.3.player.prediction_W_seuil public_goods_1_lab.4.player.prediction_W_seuil public_goods_1_lab.5.player.prediction_W_seuil public_goods_1_lab.6.player.prediction_W_seuil public_goods_1_lab.7.player.prediction_W_seuil public_goods_1_lab.8.player.prediction_W_seuil public_goods_1_lab.9.player.prediction_W_seuil public_goods_1_lab.10.player.prediction_W_seuil public_goods_1_lab.1.player.prediction_S_puni public_goods_1_lab.2.player.prediction_S_puni public_goods_1_lab.3.player.prediction_S_puni public_goods_1_lab.4.player.prediction_S_puni public_goods_1_lab.5.player.prediction_S_puni public_goods_1_lab.6.player.prediction_S_puni public_goods_1_lab.7.player.prediction_S_puni public_goods_1_lab.8.player.prediction_S_puni public_goods_1_lab.9.player.prediction_S_puni public_goods_1_lab.10.player.prediction_S_puni public_goods_1_lab.1.player.urnA public_goods_1_lab.2.player.urnA public_goods_1_lab.3.player.urnA public_goods_1_lab.4.player.urnA public_goods_1_lab.5.player.urnA public_goods_1_lab.6.player.urnA public_goods_1_lab.7.player.urnA public_goods_1_lab.8.player.urnA public_goods_1_lab.9.player.urnA public_goods_1_lab.10.player.urnA public_goods_1_lab.1.player.punition public_goods_1_lab.2.player.punition public_goods_1_lab.3.player.punition public_goods_1_lab.4.player.punition public_goods_1_lab.5.player.punition public_goods_1_lab.6.player.punition public_goods_1_lab.7.player.punition public_goods_1_lab.8.player.punition public_goods_1_lab.9.player.punition public_goods_1_lab.10.player.punition public_goods_1_lab.1.player.autre_contri public_goods_1_lab.2.player.autre_contri public_goods_1_lab.3.player.autre_contri public_goods_1_lab.4.player.autre_contri public_goods_1_lab.5.player.autre_contri public_goods_1_lab.6.player.autre_contri public_goods_1_lab.7.player.autre_contri public_goods_1_lab.8.player.autre_contri public_goods_1_lab.9.player.autre_contri public_goods_1_lab.10.player.autre_contri public_goods_1_lab.1.player.payoff public_goods_1_lab.2.player.payoff public_goods_1_lab.3.player.payoff public_goods_1_lab.4.player.payoff public_goods_1_lab.5.player.payoff public_goods_1_lab.6.player.payoff public_goods_1_lab.7.player.payoff public_goods_1_lab.8.player.payoff public_goods_1_lab.9.player.payoff public_goods_1_lab.10.player.payoff public_goods_1_lab.1.group.id_in_subsession public_goods_1_lab.2.group.id_in_subsession public_goods_1_lab.3.group.id_in_subsession public_goods_1_lab.4.group.id_in_subsession public_goods_1_lab.5.group.id_in_subsession public_goods_1_lab.6.group.id_in_subsession public_goods_1_lab.7.group.id_in_subsession public_goods_1_lab.8.group.id_in_subsession public_goods_1_lab.9.group.id_in_subsession public_goods_1_lab.10.group.id_in_subsession public_goods_1_lab.1.group.total_contribution public_goods_1_lab.2.group.total_contribution public_goods_1_lab.3.group.total_contribution public_goods_1_lab.4.group.total_contribution public_goods_1_lab.5.group.total_contribution public_goods_1_lab.6.group.total_contribution public_goods_1_lab.7.group.total_contribution public_goods_1_lab.8.group.total_contribution public_goods_1_lab.9.group.total_contribution public_goods_1_lab.10.group.total_contribution public_goods_1_lab.1.group.urnB public_goods_1_lab.2.group.urnB public_goods_1_lab.3.group.urnB public_goods_1_lab.4.group.urnB public_goods_1_lab.5.group.urnB public_goods_1_lab.6.group.urnB public_goods_1_lab.7.group.urnB public_goods_1_lab.8.group.urnB public_goods_1_lab.9.group.urnB public_goods_1_lab.10.group.urnB public_goods_1_lab.1.group.seuil_info public_goods_1_lab.2.group.seuil_info public_goods_1_lab.3.group.seuil_info public_goods_1_lab.4.group.seuil_info public_goods_1_lab.5.group.seuil_info public_goods_1_lab.6.group.seuil_info public_goods_1_lab.7.group.seuil_info public_goods_1_lab.8.group.seuil_info public_goods_1_lab.9.group.seuil_info public_goods_1_lab.10.group.seuil_info public_goods_1_lab.1.group.puni public_goods_1_lab.2.group.puni public_goods_1_lab.3.group.puni public_goods_1_lab.4.group.puni public_goods_1_lab.5.group.puni public_goods_1_lab.6.group.puni public_goods_1_lab.7.group.puni public_goods_1_lab.8.group.puni public_goods_1_lab.9.group.puni public_goods_1_lab.10.group.puni);
set etude.table_1;
if code_session = "XXXXXXXX"| code_session = "YYYYYYYY" | code_session = "ZZZZZZZZ" ;
run;


/*Obtention de dix lignes de choix par participants (correspondant aux nombres de période dans le PGG*/
data etude.round;
input round $;
cards;
01 
02 
03 
04 
05 
06 
07 
08 
09 
10
;
run;


proc sql;
create table etude.table_finale as
   select *
   from etude.table_1, etude.round;
quit;


/*Classement des données par code de participation*/
proc sort data = etude.table_finale ;
by code_participant;
run;


/*Modification de la base de données afin d’obtenir 10 lignes pour chaque participant (correspondant au nombre de choix réalisé dans le jeu de bien public)*/
data etude.table_finale;
set etude.table_finale;

if PGG_id_in_group=3 then do;
role=0;
end;
if PGG_id_in_group^=3 then do;
role=1;
end;

if type = "Type X" then do;
type = 0;
end;
if type = "Type Y" then do;
type = 1;
end;
if type_S = "Type X" then do;
type_S = 0;
end;
if type_S = "Type Y" then do;
type_S = 1;
end;
if type_W = "Type X" then do;
type_W = 0;
end;
if type_W = "Type Y" then do;
type_W = 1;
end;

if choix_inconditionnel = "Choix X" then do;
choix_inconditionnel = 0;
end;
if choix_inconditionnel = "Choix Y" then do;
choix_inconditionnel = 1;
end;
if choix_conditionnel = "Choix X" then do;
choix_conditionnel = 0;
end;
if choix_conditionnel = "Choix Y" then do;
choix_conditionnel = 1;
end;

if premier_joueur = "Moi" then do;
premier_joueur = 0;
end;
if premier_joueur = "Lui" then do;
premier_joueur = 1;
end;


if round= "01" then do ;
contribution = public_goods_1_lab.1.player.contribution;
seuil = public_goods_1_lab.1.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.1.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.1.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.1.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.1.player.urnA;
punition = public_goods_1_lab.1.player.punition;
autre_contribution = public_goods_1_lab.1.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.1.player.payoff;
id_in_group = public_goods_1_lab.1.group.id_in_subsession;
compte_collectif = public_goods_1_lab.1.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.1.group.urnB;
seuil = public_goods_1_lab.1.group.seuil_info;
nombre_punition = public_goods_1_lab.1.group.puni ;
end;
if round= "02" then do;
contribution = public_goods_1_lab.2.player.contribution;
seuil = public_goods_1_lab.2.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.2.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.2.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.2.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.2.player.urnA;
punition = public_goods_1_lab.2.player.punition;
autre_contribution = public_goods_1_lab.2.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.2.player.payoff;
id_in_group = public_goods_1_lab.2.group.id_in_subsession;
compte_collectif = public_goods_1_lab.2.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.2.group.urnB;
seuil = public_goods_1_lab.2.group.seuil_info;
nombre_punition = public_goods_1_lab.2.group.puni ;
end;
if round= "03" then do;
contribution = public_goods_1_lab.3.player.contribution;
seuil = public_goods_1_lab.3.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.3.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.3.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.3.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.3.player.urnA;
punition = public_goods_1_lab.3.player.punition;
autre_contribution = public_goods_1_lab.3.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.3.player.payoff;
id_in_group = public_goods_1_lab.3.group.id_in_subsession;
compte_collectif = public_goods_1_lab.3.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.3.group.urnB;
seuil = public_goods_1_lab.3.group.seuil_info;
nombre_punition = public_goods_1_lab.3.group.puni ;
end;
if round= "04" then do;
contribution = public_goods_1_lab.4.player.contribution;
seuil = public_goods_1_lab.4.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.4.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.4.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.4.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.4.player.urnA;
punition = public_goods_1_lab.4.player.punition;
autre_contribution = public_goods_1_lab.4.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.4.player.payoff;
id_in_group = public_goods_1_lab.4.group.id_in_subsession;
compte_collectif = public_goods_1_lab.4.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.4.group.urnB;
seuil = public_goods_1_lab.4.group.seuil_info;
nombre_punition = public_goods_1_lab.4.group.puni ;
end;
if round= "05" then do;
contribution = public_goods_1_lab.5.player.contribution;
seuil = public_goods_1_lab.5.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.5.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.5.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.5.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.5.player.urnA;
punition = public_goods_1_lab.5.player.punition;
autre_contribution = public_goods_1_lab.5.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.5.player.payoff;
id_in_group = public_goods_1_lab.5.group.id_in_subsession;
compte_collectif = public_goods_1_lab.5.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.5.group.urnB;
seuil = public_goods_1_lab.5.group.seuil_info;
nombre_punition = public_goods_1_lab.5.group.puni ;
end;
if round= "06" then do;
contribution = public_goods_1_lab.6.player.contribution;
seuil = public_goods_1_lab.6.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.6.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.6.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.6.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.6.player.urnA;
punition = public_goods_1_lab.6.player.punition;
autre_contribution = public_goods_1_lab.6.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.6.player.payoff;
id_in_group = public_goods_1_lab.6.group.id_in_subsession;
compte_collectif = public_goods_1_lab.6.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.6.group.urnB;
seuil = public_goods_1_lab.6.group.seuil_info;
nombre_punition = public_goods_1_lab.6.group.puni ;
end;
if round= "07" then do;
contribution = public_goods_1_lab.7.player.contribution;
seuil = public_goods_1_lab.7.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.7.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.7.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.7.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.7.player.urnA;
punition = public_goods_1_lab.7.player.punition;
autre_contribution = public_goods_1_lab.7.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.7.player.payoff;
id_in_group = public_goods_1_lab.7.group.id_in_subsession;
compte_collectif = public_goods_1_lab.7.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.7.group.urnB;
seuil = public_goods_1_lab.7.group.seuil_info;
nombre_punition = public_goods_1_lab.7.group.puni ;
end;
if round= "08" then do;
contribution = public_goods_1_lab.8.player.contribution;
seuil = public_goods_1_lab.8.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.8.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.8.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.8.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.8.player.urnA;
punition = public_goods_1_lab.8.player.punition;
autre_contribution = public_goods_1_lab.8.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.8.player.payoff;
id_in_group = public_goods_1_lab.8.group.id_in_subsession;
compte_collectif = public_goods_1_lab.8.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.8.group.urnB;
seuil = public_goods_1_lab.8.group.seuil_info;
nombre_punition = public_goods_1_lab.8.group.puni ;
end;
if round= "09” then do;
contribution = public_goods_1_lab.9.player.contribution;
seuil = public_goods_1_lab.9.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.9.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.9.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.9.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.9.player.urnA;
punition = public_goods_1_lab.9.player.punition;
autre_contribution = public_goods_1_lab.9.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.9.player.payoff;
id_in_group = public_goods_1_lab.9.group.id_in_subsession;
compte_collectif = public_goods_1_lab.9.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.9.group.urnB;
seuil = public_goods_1_lab.9.group.seuil_info;
nombre_punition = public_goods_1_lab.9.group.puni ;
end;
if round= "10" then do;
contribution = public_goods_1_lab.10.player.contribution;
seuil = public_goods_1_lab.10.group.seuil_info;
prediction_autre_contribution = public_goods_1_lab.10.player.prediction_W_autre;
prediction_seuil = public_goods_1_lab.10.player.prediction_W_seuil;
prediction_puni = public_goods_1_lab.10.player.prediction_S_puni;
gain_compte_prive = public_goods_1_lab.10.player.urnA;
punition = public_goods_1_lab.10.player.punition;
autre_contribution = public_goods_1_lab.10.player.autre_contri;
PGG_payoff_round = public_goods_1_lab.10.player.payoff;
id_in_group = public_goods_1_lab.10.group.id_in_subsession;
compte_collectif = public_goods_1_lab.10.group.total_contribution;
gain_compte_collectif = public_goods_1_lab.10.group.urnB;
seuil = public_goods_1_lab.10.group.seuil_info;
nombre_punition = public_goods_1_lab.10.group.puni ;
end;
run;


/*Création de la variable de transgréssion*/
data etude.table_finale(drop= public_goods_1_lab.1.player.contribution public_goods_1_lab.2.player.contribution public_goods_1_lab.3.player.contribution public_goods_1_lab.4.player.contribution public_goods_1_lab.5.player.contribution public_goods_1_lab.6.player.contribution public_goods_1_lab.7.player.contribution public_goods_1_lab.8.player.contribution public_goods_1_lab.9.player.contribution public_goods_1_lab.10.player.contribution public_goods_1_lab.1.group.seuil_info public_goods_1_lab.2.group.seuil_info public_goods_1_lab.3.group.seuil_info public_goods_1_lab.4.group.seuil_info public_goods_1_lab.5.group.seuil_info public_goods_1_lab.6.group.seuil_info public_goods_1_lab.7.group.seuil_info public_goods_1_lab.8.group.seuil_info public_goods_1_lab.9.group.seuil_info public_goods_1_lab.10.group.seuil_info public_goods_1_lab.1.player.prediction_W_autre public_goods_1_lab.2.player.prediction_W_autre public_goods_1_lab.3.player.prediction_W_autre public_goods_1_lab.4.player.prediction_W_autre public_goods_1_lab.5.player.prediction_W_autre public_goods_1_lab.6.player.prediction_W_autre public_goods_1_lab.7.player.prediction_W_autre public_goods_1_lab.8.player.prediction_W_autre public_goods_1_lab.9.player.prediction_W_autre public_goods_1_lab.10.player.prediction_W_autre public_goods_1_lab.1.player.prediction_W_seuil public_goods_1_lab.2.player.prediction_W_seuil public_goods_1_lab.3.player.prediction_W_seuil public_goods_1_lab.4.player.prediction_W_seuil public_goods_1_lab.5.player.prediction_W_seuil public_goods_1_lab.6.player.prediction_W_seuil public_goods_1_lab.7.player.prediction_W_seuil public_goods_1_lab.8.player.prediction_W_seuil public_goods_1_lab.9.player.prediction_W_seuil public_goods_1_lab.10.player.prediction_W_seuil public_goods_1_lab.1.player.prediction_S_puni public_goods_1_lab.2.player.prediction_S_puni public_goods_1_lab.3.player.prediction_S_puni public_goods_1_lab.4.player.prediction_S_puni public_goods_1_lab.5.player.prediction_S_puni public_goods_1_lab.6.player.prediction_S_puni public_goods_1_lab.7.player.prediction_S_puni public_goods_1_lab.8.player.prediction_S_puni public_goods_1_lab.9.player.prediction_S_puni public_goods_1_lab.10.player.prediction_S_puni public_goods_1_lab.1.player.urnA public_goods_1_lab.2.player.urnA public_goods_1_lab.3.player.urnA public_goods_1_lab.4.player.urnA public_goods_1_lab.5.player.urnA public_goods_1_lab.6.player.urnA public_goods_1_lab.7.player.urnA public_goods_1_lab.8.player.urnA public_goods_1_lab.9.player.urnA public_goods_1_lab.10.player.urnA public_goods_1_lab.1.player.punition public_goods_1_lab.2.player.punition public_goods_1_lab.3.player.punition public_goods_1_lab.4.player.punition public_goods_1_lab.5.player.punition public_goods_1_lab.6.player.punition public_goods_1_lab.7.player.punition public_goods_1_lab.8.player.punition public_goods_1_lab.9.player.punition public_goods_1_lab.10.player.punition public_goods_1_lab.1.player.autre_contri public_goods_1_lab.2.player.autre_contri public_goods_1_lab.3.player.autre_contri public_goods_1_lab.4.player.autre_contri public_goods_1_lab.5.player.autre_contri public_goods_1_lab.6.player.autre_contri public_goods_1_lab.7.player.autre_contri public_goods_1_lab.8.player.autre_contri public_goods_1_lab.9.player.autre_contri public_goods_1_lab.10.player.autre_contri public_goods_1_lab.1.player.payoff public_goods_1_lab.2.player.payoff public_goods_1_lab.3.player.payoff public_goods_1_lab.4.player.payoff public_goods_1_lab.5.player.payoff public_goods_1_lab.6.player.payoff public_goods_1_lab.7.player.payoff public_goods_1_lab.8.player.payoff public_goods_1_lab.9.player.payoff public_goods_1_lab.10.player.payoff public_goods_1_lab.1.group.id_in_subsession public_goods_1_lab.2.group.id_in_subsession public_goods_1_lab.3.group.id_in_subsession public_goods_1_lab.4.group.id_in_subsession public_goods_1_lab.5.group.id_in_subsession public_goods_1_lab.6.group.id_in_subsession public_goods_1_lab.7.group.id_in_subsession public_goods_1_lab.8.group.id_in_subsession public_goods_1_lab.9.group.id_in_subsession public_goods_1_lab.10.group.id_in_subsession public_goods_1_lab.1.group.total_contribution public_goods_1_lab.2.group.total_contribution public_goods_1_lab.3.group.total_contribution public_goods_1_lab.4.group.total_contribution public_goods_1_lab.5.group.total_contribution public_goods_1_lab.6.group.total_contribution public_goods_1_lab.7.group.total_contribution public_goods_1_lab.8.group.total_contribution public_goods_1_lab.9.group.total_contribution public_goods_1_lab.10.group.total_contribution public_goods_1_lab.1.group.urnB public_goods_1_lab.2.group.urnB public_goods_1_lab.3.group.urnB public_goods_1_lab.4.group.urnB public_goods_1_lab.5.group.urnB public_goods_1_lab.6.group.urnB public_goods_1_lab.7.group.urnB public_goods_1_lab.8.group.urnB public_goods_1_lab.9.group.urnB public_goods_1_lab.10.group.urnB public_goods_1_lab.1.group.seuil_info public_goods_1_lab.2.group.seuil_info public_goods_1_lab.3.group.seuil_info public_goods_1_lab.4.group.seuil_info public_goods_1_lab.5.group.seuil_info public_goods_1_lab.6.group.seuil_info public_goods_1_lab.7.group.seuil_info public_goods_1_lab.8.group.seuil_info public_goods_1_lab.9.group.seuil_info public_goods_1_lab.10.group.seuil_info public_goods_1_lab.1.group.puni public_goods_1_lab.2.group.puni public_goods_1_lab.3.group.puni public_goods_1_lab.4.group.puni public_goods_1_lab.5.group.puni public_goods_1_lab.6.group.puni public_goods_1_lab.7.group.puni public_goods_1_lab.8.group.puni public_goods_1_lab.9.group.puni public_goods_1_lab.10.group.puni PGG_id_in_group);
set etude.table_finale;
if contribution < seuil then do;
transgression = seuil - contribution;
end;
if contribution >= seuil then do;
transgression = 0 ;
end;

if LAG(contribution) < LAG(seuil) then do;
puni = 1;
end; 
if LAG(contribution) >= LAG(seuil) then do;
puni = 0;
end;
run;

/*Création des variables d’identification*/
data etude.table_finale;
set etude.table_finale;
if code_session = "XXXXXXXX" then do;
traitement = 1;
session = 1;
end;
if session_code = "ZZZZZZZZ" then do;
traitement = 1;
session = 2;
end;

if session_code = "YYYYYYYY" then do;
traitement = 2;
session = 5;
end; 
if session_code = "WWWWWWWW" then do;
traitement = 2;
session = 6;
end;


if type_S = type_W & type_W = 0 then do; 
groupe= 1;
end; 
if type_S = type_W & type_W = 1 then do; 
groupe= 2;
end;
if type_S ^= type_W & type_W = 0 then do; 
groupe= 3;
end;
if type_S ^= type_W & type_W = 1 then do; 
groupe= 4;
end;
run;

data etude.table_finale;
set etude.table_finale;
caracteristique = catx('-',traitement,session,groupe,round);
run;


/*Récupération de la table créée afin de réaliser l’analyse sur Stata*/
proc export data=etude.table_finale
outfile = "chemin\table_etude"
dbms = xlsx replace;
run;
