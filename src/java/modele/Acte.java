/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

/**
 *
 * @author Rabeasimbola
 */
@annotation.AttrnotGive(notGive = {"id"})
@annotation.ColonneLister(ColonneaLister = {"id","nomacte"})
@annotation.NomVue(VueJsp = "Crud_Acte")
@annotation.NomColonneRecherche(ColonneRecherche = {"nomacte"})
public class Acte {
    int id ;
    String nomacte;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomacte() {
        return nomacte;
    }

    public void setNomacte(String nomacte) {
        this.nomacte = nomacte;
    }
    
}
