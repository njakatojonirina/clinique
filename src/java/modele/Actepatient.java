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
@annotation.ColonneLister(ColonneaLister = {"id","date"})
@annotation.NomVue(VueJsp = "Crud_Actepatient")
@annotation.ListeDeroulant(Deroulant = {"patient"})
public class Actepatient {
    int id , patient , idutilisateur;
    Date date;

    public int getIdutilisateur() {
        return idutilisateur;
    }

    public void setIdutilisateur(int idutilisateur) {
        this.idutilisateur = idutilisateur;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPatient() {
        return patient;
    }

    public void setPatient(int idpatient) {
        this.patient = idpatient;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
}
