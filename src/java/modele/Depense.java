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
@annotation.ColonneLister(ColonneaLister = {"id","nomdepense"})
@annotation.NomVue(VueJsp = "Crud_Depense")
@annotation.NomColonneRecherche(ColonneRecherche = {"nomdepense"})
public class Depense {
    int  id ;
    String nomdepense ;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomdepense() {
        return nomdepense;
    }

    public void setNomdepense(String nomdepense) {
        this.nomdepense = nomdepense;
    }
    
}
