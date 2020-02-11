######################################### Creation d'index #######################################################

CREATE INDEX idx_siret ON etablissement_marseille (siret);
CREATE INDEX idx_etat_admin ON etablissement_marseille (etatAdministratifEtablissement);
CREATE INDEX idx_commune ON etablissement_marseille (libelleCommuneEtablissement);
CREATE INDEX idx_activite ON etablissement_marseille (activitePrincipaleEtablissement);
CREATE INDEX idx_nomencl ON etablissement_marseille (nomenclatureActivitePrincipaleEtablissement);
CREATE INDEX idx_codepostal ON etablissement_marseille (codePostalEtablissement);

CREATE INDEX idx_siret ON hist_etab_marseille (siret);
CREATE INDEX idx_chg_etat ON hist_etab_marseille (changementEtatAdministratifEtablissement);

CREATE INDEX idx_libelle ON niv1_2008 (libelle1);



##################################	Nombre d'établissement par secteurs		#############################################


select libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_2008
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_2008.activitePrincipaleEtablissement
			and codePostalEtablissement = '13013' and nomenclatureActivitePrincipaleEtablissement ='NAFRev2' and etatAdministratifEtablissement ='A'
	join niv1_2008
		on niv_enb_2008.niv1 = niv1_2008.niv1
	group by libelle1
    
union

select libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_2003
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_2003.activitePrincipaleEtablissement
			and codePostalEtablissement = '13013' and nomenclatureActivitePrincipaleEtablissement ='NAFRev1' and etatAdministratifEtablissement ='A'
	join niv1_2003
		on niv_enb_2003.niv1 = niv1_2003.niv1
	group by libelle1
    
union

select libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_1993
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_1993.activitePrincipaleEtablissement
			and codePostalEtablissement = '13013' and nomenclatureActivitePrincipaleEtablissement ='NAF1993' and etatAdministratifEtablissement ='A'
	join niv1_1993
		on niv_enb_1993.niv1 = niv1_1993.niv1
	group by libelle1
    
union

select libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_1973
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_1973.activitePrincipaleEtablissement
			and codePostalEtablissement = '13013' and nomenclatureActivitePrincipaleEtablissement ='NAF1993' and etatAdministratifEtablissement ='A'
    
order by nombre_d_etablissement desc
limit 5;


#####################################################   Nombre d'établissement par arrondissement   ####################################################


select libelleCommuneEtablissement, count(siret) as nombre_d_etablissement
	from etablissement_marseille
    group by libelleCommuneEtablissement order by nombre_d_etablissement desc limit 10;
    
    
####################################################  Nombre d'établissement par secteur + arrondissement   ########################################################


select libelleCommuneEtablissement, libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_2008
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_2008.activitePrincipaleEtablissement
			 and nomenclatureActivitePrincipaleEtablissement ='NAFRev2' and etatAdministratifEtablissement ='A'
	join niv1_2008
		on niv_enb_2008.niv1 = niv1_2008.niv1
	group by libelleCommuneEtablissement, libelle1
    
union

select libelleCommuneEtablissement, libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_2003
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_2003.activitePrincipaleEtablissement
			 and nomenclatureActivitePrincipaleEtablissement ='NAFRev1' and etatAdministratifEtablissement ='A'
	join niv1_2003
		on niv_enb_2003.niv1 = niv1_2003.niv1
	group by libelleCommuneEtablissement, libelle1
    
union

select libelleCommuneEtablissement, libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_1993
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_1993.activitePrincipaleEtablissement
			and nomenclatureActivitePrincipaleEtablissement ='NAF1993' and etatAdministratifEtablissement ='A'
	join niv1_1993
		on niv_enb_1993.niv1 = niv1_1993.niv1
	group by libelleCommuneEtablissement, libelle1
    
union

select libelleCommuneEtablissement, libelle1, count(siret) as nombre_d_etablissement
	from etablissement_marseille
	join niv_enb_1973
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_1973.activitePrincipaleEtablissement
			and nomenclatureActivitePrincipaleEtablissement ='NAP' and etatAdministratifEtablissement ='A'
	group by libelleCommuneEtablissement, libelle1
    
order by nombre_d_etablissement desc;




############################################   Duré de vie d’une entreprise (moyenne)   ######################################################


select libelleCommuneEtablissement, avg(TIMESTAMPDIFF(year, dateCreationEtablissement, hist_etab_marseille.dateDebut)) as duree
	from etablissement_marseille
    join hist_etab_marseille
		on etablissement_marseille.siret = hist_etab_marseille.siret
        and changementEtatAdministratifEtablissement ='1'
        and etablissement_marseille.etatAdministratifEtablissement = 'F'
	group by libelleCommuneEtablissement
    order by duree desc;


select libelle1, avg(TIMESTAMPDIFF(year, dateCreationEtablissement, hist_etab_marseille.dateDebut)) as duree
	from etablissement_marseille
    join hist_etab_marseille
		on etablissement_marseille.siret = hist_etab_marseille.siret
        and codePostalEtablissement = '13013'
        and etablissement_marseille.etatAdministratifEtablissement ='A'
        and changementEtatAdministratifEtablissement ='1'
        and etablissement_marseille.nomenclatureActivitePrincipaleEtablissement ='NAFRev2'
	join niv_enb_2008
		on etablissement_marseille.activitePrincipaleEtablissement = niv_enb_2008.activitePrincipaleEtablissement
	join niv1_2008
		on niv_enb_2008.niv1 = niv1_2008.niv1
	group by libelle1
    order by duree desc;
