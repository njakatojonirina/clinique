/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import annotation.AttrnotGive;
import annotation.NomColonne;
import annotation.NomTable;
import annotation.Primarykey;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Vector;
import modele.Ligne;
import modele.Pagination;

/**
 *
 * @author Rabeasimbola
 */
public class DaoGeneric{
    
    public ArrayList findWhere(Object object) throws Exception{
        Connection con = null;
        PreparedStatement stmt = null;
        int reponse = 0;
        ArrayList liste = new ArrayList();
        try{
            con = new connectBase.ConnectBase().getConnexion();
            String req="select * from  "+object.getClass().getSimpleName().toLowerCase();
            String [] attributsName=new String[object.getClass().getDeclaredFields().length];
            int count=0;
            req+=" where ";
            for(int i=0;i<attributsName.length;i++)
            {
                    attributsName[i]=object.getClass().getDeclaredFields()[i].getName();
                    attributsName[i]=toUpper(attributsName[i]);
                    Object attributsValues=object.getClass().getMethod("get"+attributsName[i]).invoke(object);

                    if((attributsValues instanceof String && attributsValues!=null) || 
                        (attributsValues instanceof Integer && (int)attributsValues!=0) ||
                        (attributsValues instanceof Date && (Date)attributsValues!=null)||
                        (attributsValues instanceof Double && (Double)attributsValues!=null)       
                            )
                    {
                            if(count==0) req+=attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            if(count>0)	req+=" and "+attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            count++;
                    }
            }
            System.out.println(req);
            liste = find(req, object);
        }catch(Exception ex){
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
        return liste;
    }
    public ArrayList findWherePaginer(Object object,String depart) throws Exception{
        Connection con = null;
        PreparedStatement stmt = null;
        int reponse = 0;
        ArrayList liste = new ArrayList();
        try{
            con = new connectBase.ConnectBase().getConnexion();
            String req="select * from  "+object.getClass().getSimpleName().toLowerCase();
            String [] attributsName=new String[object.getClass().getDeclaredFields().length];
            int count=0;
            req+=" where ";
            for(int i=0;i<attributsName.length;i++)
            {
                    attributsName[i]=object.getClass().getDeclaredFields()[i].getName();
                    attributsName[i]=toUpper(attributsName[i]);
                    Object attributsValues=object.getClass().getMethod("get"+attributsName[i]).invoke(object);

                    if((attributsValues instanceof String && attributsValues!=null) || (attributsValues instanceof Integer && (int)attributsValues!=0))
                    {
                            if(count==0) req+=attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            if(count>0)	req+=" and "+attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            count++;
                    }
            }
            Pagination pagination = new Pagination();
            int ligne = pagination.get_nb_ligne(new Ligne());
            DaoGeneric dao = new DaoGeneric();
            req+="offset "+depart+" limit "+ligne ;
            System.out.println(req);
            liste = find(req, object);
        }catch(Exception ex){
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
        return liste;
    }

    public void save(Object object) throws Exception {
        Connection con = null;
        PreparedStatement stmt = null;
        try{
            con = new connectBase.ConnectBase().getConnexion();
            String nomTable=object.getClass().getSimpleName();
            if(object.getClass().getAnnotation(NomTable.class)!= null){
                nomTable = object.getClass().getAnnotation(NomTable.class).Table();
            }
            String PrimaryKey = "test";
            if(object.getClass().getAnnotation(Primarykey.class)!= null){
                PrimaryKey = object.getClass().getAnnotation(Primarykey.class).nomPrymaryKey();
            }
            String [] lesAttributs = getAttr(object);
            String tousLesAtr=new String();
            String allValues=new String();

            for(int i=0;i<lesAttributs.length;i++)
            {
                if(lesAttributs[i].equals(toUpper(PrimaryKey)) == false){
                    Object attributValue=object.getClass().getMethod("get"+lesAttributs[i]).invoke(object);
                    tousLesAtr+=lesAttributs[i];
                    if(attributValue!=null)
                    {   
                        try {
                            if(((int)(attributValue))==0)
                            {
                                allValues+="null";
                            }else{
                                allValues+="'"+attributValue.toString()+"'";
                            }
                        } catch (Exception e) {
                            allValues+="'"+attributValue.toString()+"'";
                        }
                    }
                    else if(attributValue==null && i!=0)
                    {
                        allValues+="null";
                    }
                    if(i<lesAttributs.length-1)
                    {
                        tousLesAtr+=",";
                        allValues+=",";
                    }
                }else{
                    continue;
                }
            }
            Vector tous = listeColonne(object);
            tous.remove("Id");
            tous.remove("id");
            String[] notGive = {""};
            if(object.getClass().getAnnotation(AttrnotGive.class)!= null){
                notGive = object.getClass().getAnnotation(AttrnotGive.class).notGive();
            }
            for (int i = 0; i < notGive.length; i++) {
                tous.remove(notGive[i]);
            }
            String attr = "";
            if(tous.size() == 1){
                attr = tous.elementAt(0).toString();
            }else{
                attr = tous.elementAt(0).toString()+",";
                for(int i = 1 ; i < tous.size()-1 ; i++){
                    attr+=tous.elementAt(i)+",";
                }
                attr+=tous.elementAt(tous.size()-1);
            }
            String requete = "insert into "+nomTable+" ("+attr+") values ("+allValues+")";
            //System.out.println(requete);
            stmt = con.prepareStatement(requete);
            stmt.executeUpdate();
        }catch(Exception ex){
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
    }

    public ArrayList<Object> find(String requete,Object object) throws Exception {
        ArrayList DBTable = null;
        Connection con = null;
        java.sql.Statement stmt = null;
        ResultSet res = null;
        try {
            con = new connectBase.ConnectBase().getConnexion();
            stmt = con.createStatement();
            res = stmt.executeQuery(requete);
            DBTable = new ArrayList();
            while(res.next())
            {
                DBTable.add(getDbObject(res,object));
            }
        } catch (Exception ex) {
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
            if(res != null){
                res.close();
            }
        }
//        System.out.println(requete);
        return DBTable;
    }

    public void update(Object object) throws Exception {
        Connection con = null;
        PreparedStatement stmt = null;
        try{
            con = new connectBase.ConnectBase().getConnexion();
            String req="update "+object.getClass().getSimpleName().toLowerCase()+" set ";
            String [] attributsName=new String[object.getClass().getDeclaredFields().length];
            int count=0;

            for(int i=0;i<attributsName.length;i++)
            {
                    attributsName[i]=object.getClass().getDeclaredFields()[i].getName();
                    attributsName[i]=toUpper(attributsName[i]);
                    Object attributsValues=object.getClass().getMethod("get"+attributsName[i]).invoke(object);

                    if((attributsValues instanceof String && attributsValues!=null) 
                            || (attributsValues instanceof Integer && (int)attributsValues!=0) 
                            || (attributsValues instanceof Date && (Date)attributsValues!=null)
                            || (attributsValues instanceof Double && (Double)attributsValues!=null)
                            || (attributsValues instanceof Float && (Float)attributsValues!=null))
                    {
                            if(count==0) req+=attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            if(count>0)	req+=","+attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            count++;
                    }
            }
            req+=" where ";
        for(int i=0;i<attributsName.length;i++)
        {
                attributsName[i]=object.getClass().getDeclaredFields()[i].getName();
                attributsName[i]=toUpper(attributsName[i]);
                Object attributValue=object.getClass().getMethod("get"+attributsName[i]).invoke(object);
                String PrimaryKey = "Id";
                if(object.getClass().getAnnotation(Primarykey.class)!= null){
                    PrimaryKey = object.getClass().getAnnotation(Primarykey.class).nomPrymaryKey();
                }
                if(attributsName[i].equalsIgnoreCase(PrimaryKey))
                {
                        req+=attributsName[i]+"="; req+="'"+attributValue.toString()+"'";
                }
        }
            System.out.println("aaaaaaaaaaaaa      aaaaa"+req);
            stmt = con.prepareStatement(req);
            stmt.executeUpdate();
        }catch(Exception ex){
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
        
    }

    public void delete(Object object) throws Exception {
        Connection con = null;
        PreparedStatement stmt = null;
        try{
            con = new connectBase.ConnectBase().getConnexion();
            String req="delete from  "+object.getClass().getSimpleName().toLowerCase();
            String [] attributsName=new String[object.getClass().getDeclaredFields().length];
            int count=0;
            req+=" where ";
            for(int i=0;i<attributsName.length;i++)
            {
                    attributsName[i]=object.getClass().getDeclaredFields()[i].getName();
                    attributsName[i]=toUpper(attributsName[i]);
                    Object attributsValues=object.getClass().getMethod("get"+attributsName[i]).invoke(object);

                    if((attributsValues instanceof String && attributsValues!=null) || (attributsValues instanceof Integer && (int)attributsValues!=0))
                    {
                            if(count==0) req+=attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            if(count>0)	req+=" and "+attributsName[i]+"="+"'"+attributsValues.toString()+"'";
                            count++;
                    }
            }
            System.out.println(req);
            stmt = con.prepareStatement(req);
            stmt.executeUpdate();
        }catch(Exception ex){
            throw ex;
        }finally{
            if(con != null){
                con.close();
            }
            if(stmt != null){
                stmt.close();
            }
        }
    }
    public String toUpper(String s)
    {
        return s.substring(0,1).toUpperCase()+s.substring(1);
    }
    public String[] getAttr(Object object) throws Exception{
        String [] lesAttributs=new String[object.getClass().getDeclaredFields().length];
        Vector typeretour = new Vector();
        for(int i=0;i<lesAttributs.length;i++)
        {
            lesAttributs[i]=object.getClass().getDeclaredFields()[i].getName();
            typeretour.add(lesAttributs[i]);
        }
        String [] notgive = null;
        String [] retour = null;
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
        return retour;
        
    }
    public Vector listeColonne(Object object){
        Vector rep = new Vector();
        for(int i = 0 ; i < object.getClass().getDeclaredFields().length ; i++){
            try{
                rep.add(object.getClass().getDeclaredFields()[i].getAnnotation(NomColonne.class).Colonne());
            }catch(Exception e){
                rep.add(object.getClass().getDeclaredFields()[i].getName());
            }
        }
        return rep;
    }
    public Object getDbObject(ResultSet r,Object object)throws Exception{
        Object ObjetBdd = object.getClass().newInstance();
	Field [] attrObj = object.getClass().getDeclaredFields();
	String[] nomAttr=new String[object.getClass().getDeclaredFields().length];
        for(int i=0;i<attrObj.length;i++)
	{
            nomAttr[i]=attrObj[i].getName();
            Class classType=attrObj[i].getType();
            String allType=classType.getSimpleName();
            Object resultDb=new Object();
            try{
		resultDb=r.getString(nomAttr[i]);
		if(resultDb!=null)
		{
                if(allType.equalsIgnoreCase("int"))
                {
                        resultDb=Integer.parseInt((String)resultDb);
                }
                else if(allType.equalsIgnoreCase("double"))
                {
                        resultDb=Double.parseDouble((String)resultDb);
                }
                else if(allType.equalsIgnoreCase("timestamp"))
                {
                        resultDb=Timestamp.valueOf((String)resultDb);
                }
                else if(allType.equalsIgnoreCase("date"))
                {
                    resultDb=Date.valueOf((String)resultDb);
                }
                else if(allType.equalsIgnoreCase("float"))
                {
                    resultDb=Float.parseFloat((String)resultDb);
                }
                else
                {
                    resultDb=(String)resultDb;
                }
                    object.getClass().getMethod("set"+toUpper(nomAttr[i]),classType).invoke(ObjetBdd,resultDb);
		}
            }catch(java.sql.SQLException ee){throw ee;}
                
            }
	return (Object)ObjetBdd;
    }

}
