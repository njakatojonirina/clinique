/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import java.sql.Date;

/**
 *
 * @author Rabeasimbola
 */
@annotation.AttrnotGive(notGive = {"id"})
@annotation.ColonneLister(ColonneaLister = {"id","nom","datenaissance","sexe","remboursement"})
@annotation.NomVue(VueJsp = "Crud_Patient")
@annotation.NomColonneRecherche(ColonneRecherche = {"nom"})
@annotation.ListeDeroulant(Deroulant = {"sexe"})
public class Patient {
    int  id , sexe , remboursement;
    String nom ;
    Date datenaissance;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSexe() {
        return sexe;
    }

    public void setSexe(int idsexe) {
        this.sexe = idsexe;
    }

    public int getRemboursement() {
        return remboursement;
    }

    public void setRemboursement(int remboursement) {
        this.remboursement = remboursement;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }
    
}
