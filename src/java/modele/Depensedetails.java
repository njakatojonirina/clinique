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
@annotation.ColonneLister(ColonneaLister = {"id","tarif","date","depense"})
@annotation.ListeDeroulant(Deroulant = {"utilisateur","depense"})
@annotation.NomVue(VueJsp = "Crud_Depensedetails")
@annotation.NomColonneRecherche(ColonneRecherche = {"utilisateur"})
public class Depensedetails {
    int  id , utilisateur , depense ;
    double tarif ;
    Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(int utilisateur) {
        this.utilisateur = utilisateur;
    }

    public int getDepense() {
        return depense;
    }

    public void setDepense(int depense) {
        this.depense = depense;
    }

    public double getTarif() {
        return tarif;
    }

    public void setTarif(double tarif) {
        this.tarif = tarif;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
}
