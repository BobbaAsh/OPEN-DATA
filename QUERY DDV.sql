ALTER TABLE hist_etab_marseille
ADD INDEX idx_changeEtatAdminEtab (changementEtatAdministratifEtablissement);

ALTER TABLE hist_etab_marseille
ADD INDEX idx_etatAdminEtab (etatAdministratifEtablissement);

ALTER TABLE hist_etab_marseille
ADD INDEX idx_dateFin (dateFin);

ALTER TABLE hist_etab_marseille
ADD INDEX idx_dateDebut (dateDebut);

ALTER TABLE etablissement_marseille
ADD INDEX idx_dateCrea (dateCreationEtablissement);

ALTER TABLE etablissement_marseille
ADD INDEX idx_numSiret (siret);
CREATE TABLE ddv AS
select hist_etab_marseille.dateDebut, etablissement_marseille.codePostalEtablissement,etablissement_marseille.dateCreationEtablissement
FROM hist_etab_marseille
inner join etablissement_marseille
on hist_etab_marseille.siret = etablissement_marseille.siret AND hist_etab_marseille.changementEtatAdministratifEtablissement = 1 
AND hist_etab_marseille.etatAdministratifEtablissement = "F";