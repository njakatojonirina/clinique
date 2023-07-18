/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import java.sql.Date;
import java.text.DecimalFormat;

/**
 *
 * @author Rabeasimbola
 */
public class V_actepatientdep {
    int id , idactepatient , idutilisateur , idacte , remboursement ;
    Date date ;   
    String nomacte ,  nom  ;
    double tarif;
    
    public String getStrTarif(){
        String reponse = "";
        try {
            DecimalFormat d = new DecimalFormat("0,000.00");
            reponse = d.format(this.getTarif());
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdactepatient() {
        return idactepatient;
    }

    public void setIdactepatient(int idactepatient) {
        this.idactepatient = idactepatient;
    }

    public int getIdutilisateur() {
        return idutilisateur;
    }

    public void setIdutilisateur(int idutilisateur) {
        this.idutilisateur = idutilisateur;
    }

    public int getIdacte() {
        return idacte;
    }

    public void setIdacte(int idacte) {
        this.idacte = idacte;
    }

    public int getRemboursement() {
        return remboursement;
    }

    public void setRemboursement(int remboursement) {
        this.remboursement = remboursement;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getNomacte() {
        return nomacte;
    }

    public void setNomacte(String nomacte) {
        this.nomacte = nomacte;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getTarif() {
        return tarif;
    }

    public void setTarif(double tarif) {
        this.tarif = tarif;
    }

    
    
}
