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
@annotation.ColonneLister(ColonneaLister = {"id","genre"})
@annotation.NomVue(VueJsp = "Crud_Sexe")
@annotation.NomColonneRecherche(ColonneRecherche = {"genre"})
public class Sexe {
    int id;
    String genre;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String nom) {
        this.genre = nom;
    }
    
}
