/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import dao.DaoGeneric;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class Pagination {
    public int get_nb_ligne(Object object) throws Exception{
        int reponse = 0;
        try {
            DaoGeneric dao = new DaoGeneric();
          
            ArrayList liste = dao.find("select * from ligne", object);
            if (liste.size() != 0) {
                reponse = ((Ligne) liste.get(0)).getValeur();
            }
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public int get_nb_page(Object object,Object limite,int test,String mot,String[] anaovanrch,String sql) throws Exception{
        int reponse = 0;
        Statement stmt = null;
        ResultSet res = null;
        DaoGeneric dao = new DaoGeneric();
        Connection con = null;
        try {
            con = new connectBase.ConnectBase().getConnexion();
            stmt = con.createStatement();
            int nombre = 0;
            if (test == 0) {
                res = stmt.executeQuery("select count(id) id from "+object.getClass().getSimpleName());
                while(res.next()){
                    nombre = res.getInt("id");
                }
            }
            else if(test == 5){
                String requete = "";
                requete+="select * from "+object.getClass().getSimpleName()+"";
                if (anaovanrch.length != 0) {
                    requete+=" where lower ("+anaovanrch[0]+") like lower ('%"+mot+"%')";
                }
                for (int i = 1; i < anaovanrch.length; i++) {
                    requete+=" or lower ("+anaovanrch[i]+") like lower ('%"+mot+"%')";
                }
                ArrayList list = new ArrayList();
                list = dao.find(requete, object);
                nombre = list.size();
            }
            else if(test == 10){
                String requete = sql;
                ArrayList list = new ArrayList();
                list = dao.find(requete, object);
                nombre = list.size();
            }
            int ligne = get_nb_ligne(limite);
            reponse = (nombre/ligne);
            if( nombre%ligne != 0){
                reponse=reponse+1;
            }else{
                reponse=reponse;
            }
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public ArrayList pagination(Object object,Object limite,int test,String mot,String[] anaovanrch,String sql) throws Exception{
        ArrayList liste = new ArrayList();
        try {
            int nb_page = get_nb_page(object, limite, test, mot, anaovanrch,sql);
            for (int i=1; i <= nb_page; i++) { 
                liste.add(i);
            }
        } catch (Exception e) {
            throw e;
        }
        return liste;
    }
    public ArrayList paginationValeur(Object object,Object limite,int test,String mot,String[] anaovanrch,String sql) throws Exception{
        ArrayList liste = new ArrayList();
        try {
            int nb_page = 0;
            int ligne = 0;
            nb_page = get_nb_page(object, limite, test, mot, anaovanrch,sql);
            ligne = get_nb_ligne(limite);
            for (int i=1; i <= nb_page; i++) { 
                liste.add((i-1)*ligne);
            }
        } catch (Exception e) {
            throw e;
        }
        return liste;
    }
    public String requeteRecherche(Object object,Object limite,int test,String mot,String[] anaovanrch,String[] rch){
        String reponse = "";
        try {
            if (test == 5) {
                String requete = "";
                requete+="select * from "+object.getClass().getSimpleName()+"";
                if (anaovanrch.length != 0) {
                    requete+=" where (lower ("+anaovanrch[0]+") like lower ('%"+mot+"%')";
                }
                for (int i = 1; i < anaovanrch.length; i++) {
                    requete+=" or lower ("+anaovanrch[i]+") like lower ('%"+mot+"%'))";
                }
                reponse = requete;
            }else{
                String requete = "";
                requete+="select * from "+object.getClass().getSimpleName()+"";
                if (anaovanrch.length != 0) {
                    requete+=" where (lower ("+anaovanrch[0]+") like lower ('%"+rch[0]+"%')";
                }
                for (int i = 1; i < anaovanrch.length; i++) {
                    requete+=" and lower ("+anaovanrch[i]+") like lower ('%"+rch[i]+"%'))";
                }
                reponse = requete;
            }
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public String paginationgenerer(Object object,Object limite,int test,String mot,String[] anaovanrch,String controlleur,String sql,String modele) throws Exception{
        String table = "";
        try {
            ArrayList nombre_page = null;
            ArrayList offset = null;
            nombre_page = pagination(object, limite, test, mot, anaovanrch,sql);
            offset = paginationValeur(object, limite, test, mot, anaovanrch,sql);
            table+="<div class=\"btn-group\" role=\"group\" aria-label=\"Basic example\">";
            for (int i=0; i < nombre_page.size() ; i++) {  
                table+="<a href='"+controlleur+"?depart="+offset.get(i)+"&&mot="+mot+"&&sql="+sql+"&&modele="+modele+"' >";
                    table+="<button type=\"button\" class=\"btn btn-outline-secondary\">";
                        table+=""+nombre_page.get(i)+"";
                    table+="</button>";
                table+="</a>";
            }
            table+="</div>";
        } catch (Exception e) {
            throw e;
        }
        return table;
    }
}
