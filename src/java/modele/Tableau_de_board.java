/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import java.text.DecimalFormat;

/**
 *
 * @author Rabeasimbola
 */
public class Tableau_de_board {
    int id ;
    String mois ;
    double annee , recette  ,  depence   ,  benefice ;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public double getAnnee() {
        return annee;
    }

    public void setAnnee(double annee) {
        this.annee = annee;
    }

    public double getRecette() {
        return recette;
    }

    public void setRecette(double recette) {
        this.recette = recette;
    }

    public double getDepence() {
        return depence;
    }

    public void setDepence(double depence) {
        this.depence = depence;
    }

    public double getBenefice() {
        return benefice;
    }

    public void setBenefice(double benefice) {
        this.benefice = benefice;
    }
    
    public String getStrRec(){
        String reponse = "";
        try {
            DecimalFormat d = new DecimalFormat("0,000.00");
            reponse = d.format(this.getRecette());
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public String getStrBen(){
        String reponse = "";
        try {
            DecimalFormat d = new DecimalFormat("0,000.00");
            reponse = d.format(this.getBenefice());
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public String getStrDep(){
        String reponse = "";
        try {
            DecimalFormat d = new DecimalFormat("0,000.00");
            reponse = d.format(this.getDepence());
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    
}
