/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import annotation.AttrnotGive;
import annotation.ListeDeroulant;
import java.sql.Date;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
//import modele.Personne;

/**
 *
 * @author Rabeasimbola
 */
public class Utilitaire {
    public String getType(String attribut,Object object) throws Exception{
        try {
            return object.getClass().getMethod("get"+toUpper(attribut)).getReturnType().getSimpleName();
        } catch (Exception e) {
            throw e;
        }
    }
    public String[] getAttrGive(Object object){
        String[] reponse = new String[object.getClass().getDeclaredFields().length];
        String[] notgive = {""};
        String[] deroulant = {""};
        String[] rep = {""};
        Vector liste = new Vector();
        try {
            if(object.getClass().getAnnotation(AttrnotGive.class)!= null){
                notgive = object.getClass().getAnnotation(AttrnotGive.class).notGive();
            }
             if(object.getClass().getAnnotation(ListeDeroulant.class)!= null){
                deroulant = object.getClass().getAnnotation(ListeDeroulant.class).Deroulant();
            }
            for (int i = 0; i < object.getClass().getDeclaredFields().length; i++) {
                reponse[i] = object.getClass().getDeclaredFields()[i].getName();
                liste.add(reponse[i]);
            }
            for (int i = 0; i < notgive.length; i++) {
                liste.remove(notgive[i]);
            }
            for (int i = 0; i < deroulant.length; i++) {
                liste.remove(deroulant[i]);
            }
            rep = new String[liste.size()];
            for (int i = 0; i < liste.size(); i++) {
                rep[i] = liste.elementAt(i).toString();
            }
        } catch (Exception e) {
            throw e;
        }
        return rep;
    }
    public String [] getAttribut(Object object){
        String reponse = "";
        String [] retour = null;
        try {
            String [] lesAttributs=new String[object.getClass().getDeclaredFields().length];
            Vector typeretour = new Vector();
            for(int i=0;i<lesAttributs.length;i++)
            {
                lesAttributs[i]=object.getClass().getDeclaredFields()[i].getName();
                typeretour.add(lesAttributs[i]);
            }
            String [] notgive = null;
            if(object.getClass().getAnnotation(AttrnotGive.class)!= null){
                notgive = object.getClass().getAnnotation(AttrnotGive.class).notGive();
                for(int i = 0 ; i < typeretour.size() ; i++){
                    for(int j = 0 ; j < notgive.length ; j++){
                        typeretour.remove(notgive[j]);
                    }
                }
                retour = new String[typeretour.size()];
                for(int i = 0 ; i < typeretour.size() ; i++){
                    retour[i] = typeretour.elementAt(i).toString();
                    retour[i]=toUpper(retour[i]);
                }
            }else{
                retour = new String[typeretour.size()];
                for(int i = 0 ; i < typeretour.size() ; i++){
                    retour[i] = typeretour.elementAt(i).toString();
                    retour[i]=toUpper(retour[i]);
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return retour;
    }
    public String [] getAllAttribut(Object object){
        String [] lesAttributs = null;
        try {
            lesAttributs=new String[object.getClass().getDeclaredFields().length];
            for(int i=0;i<lesAttributs.length;i++)
            {
                lesAttributs[i]=toUpper(object.getClass().getDeclaredFields()[i].getName());
                System.out.println(lesAttributs[i]);
            }
        } catch (Exception e) {
            throw e;
        }
        return lesAttributs;
    }
    public String toUpper(String s)
    {
        return s.substring(0,1).toUpperCase()+s.substring(1);
    }
    public String toLower(String s)
    {
        return s.substring(0,1).toLowerCase()+s.substring(1);
    }
    public Object requestAuto(String[] attribut,HttpServletRequest request,Object object) throws Exception{
        try {
            for (int i = 0; i < attribut.length; i++) {
                String type = getType(attribut[i], object);
                Class returntype = object.getClass().getMethod("get"+toUpper(attribut[i])).getReturnType();
                String req = request.getParameter(attribut[i]);
                System.out.println("request    "+req);
                if (returntype.getSimpleName().equalsIgnoreCase("int")) {
                    object.getClass().getDeclaredMethod("set"+toUpper(attribut[i]), returntype).invoke(object, Integer.parseInt(req));
                    System.out.println(object.getClass().getDeclaredMethod("get"+toUpper(attribut[i])).invoke(object));
                }
                else if (returntype.getSimpleName().equalsIgnoreCase("double")) {
                    object.getClass().getDeclaredMethod("set"+toUpper(attribut[i]), returntype).invoke(object, Double.parseDouble(req));
                    System.out.println(object.getClass().getDeclaredMethod("get"+toUpper(attribut[i])).invoke(object));
                }
                else if (returntype.getSimpleName().equalsIgnoreCase("float")) {
                    object.getClass().getDeclaredMethod("set"+toUpper(attribut[i]), returntype).invoke(object, Float.parseFloat(req));
                    System.out.println(object.getClass().getDeclaredMethod("get"+toUpper(attribut[i])).invoke(object));
                }
                else if (returntype.getSimpleName().equalsIgnoreCase("Date")) {
                    object.getClass().getDeclaredMethod("set"+toUpper(attribut[i]), returntype).invoke(object, Date.valueOf(req));
                    System.out.println(object.getClass().getDeclaredMethod("get"+toUpper(attribut[i])).invoke(object));
                }
                else{
                    object.getClass().getDeclaredMethod("set"+toUpper(attribut[i]), returntype).invoke(object, req);
                    System.out.println(object.getClass().getDeclaredMethod("get"+toUpper(attribut[i])).invoke(object));
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return object;
    }
    /*public static void main(String[] args) throws Exception {
        Utilitaire utilitaire = new Utilitaire();
        utilitaire.getAllAttribut(new Personne());
    }*/
}
