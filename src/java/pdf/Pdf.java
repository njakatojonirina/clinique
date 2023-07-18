/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pdf;

import annotation.AttrnotGive;
import annotation.ColonneLister;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import dao.DaoGeneric;
import java.awt.Desktop;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import javax.servlet.ServletContext;
import modele.V_actepatientdep;
//import modele.Personne;

/**
 *
 * @author Rabeasimbola
 */
public class Pdf {
    public String creerEntete(){
        String reponse = "";
        try {
            reponse="<link rel=\"stylesheet\" type=\"text/css\" href=\"C:\\Users\\Rabeasimbola\\Documents\\NetBeansProjects\\Clinique2.0\\web\\assets\\csspdf\\style.css\" />\n" +
//                        "<link rel=\"stylesheet\" type=\"text/css\" href=\"C:\\Users\\Rabeasimbola\\Documents\\NetBeansProjects\\Evaluation\\web\\assets\\bootstrap-icons\\bootstrap-icons.css\" />\n" +
                    "\n";
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    public void creerXML(String path,String nomfile,String contenue) throws Exception{
        try {
            String inputFile = path+"\\"+"..\\..\\src\\java\\xml\\"+nomfile+".xml";
            BufferedWriter file = new BufferedWriter(new FileWriter(inputFile));
            String c = creerEntete()+""+contenue;
            file.write(c);
            file.close();
        } catch (Exception e) {
            throw e;
        }
    }
    public String toUpper(String s)
    {
        return s.substring(0,1).toUpperCase()+s.substring(1);
    }
    public void genererPdf(String path,String nomfile,String contenue) throws Exception{
        //contenue = "<h1>NJAKA</h1>";
        creerXML(path, nomfile, contenue);
        String inputFile = path+"\\"+"..\\..\\src\\java\\xml\\"+nomfile+".xml";
        String outputFile = path+"\\..\\output.pdf";
        try {
            Document document = new Document();
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(outputFile));
            document.open();
            InputStream inputStream = new FileInputStream(inputFile);
            XMLWorkerHelper.getInstance().parseXHtml(writer, document, inputStream, StandardCharsets.UTF_8);
            document.close();
            Path downloadPath = Paths.get(path+"\\..\\"); 
            File pdfFile = new File(downloadPath.toFile(), "output.pdf");
            Desktop.getDesktop().open(pdfFile);
        } catch (Exception e) {
            //throw e;
        }
    }
    public String tablepdf(Object object,String requete) throws Exception, Exception{
        DaoGeneric dao = new DaoGeneric();
        String[] listeAttrb = {""};
        String reponse = "";
        try {
            ArrayList list = dao.find(requete, object);
            if(object.getClass().getAnnotation(ColonneLister.class)!= null){
                listeAttrb = object.getClass().getAnnotation(ColonneLister.class).ColonneaLister();
            }
                reponse+="<div class=\"table-wrapper\">\n";
                    reponse+="<h5>liste des "+object.getClass().getSimpleName()+"</h5>\n";
                    reponse+="<table class=\"table\" border=\"1\">\n";
                    reponse+="<thead>\n";  
                        reponse+="<tr>\n"; 
                            for (int i = 0; i < listeAttrb.length; i++) {
                                reponse+="<th>";
                                    reponse+=""+listeAttrb[i];
                                reponse+="</th>\n";
                            }
                        reponse+="</tr>\n"; 
                        reponse+="</thead>\n";
                        reponse+="<tbody>\n";  
                        for(int m=0;m<list.size();m++){
                            reponse+="<tr>\n";  
                            for (int i = 0; i < listeAttrb.length; i++) {
                                reponse+="<td>"; 
                                reponse+=list.get(m).getClass().getDeclaredMethod("get"+toUpper(listeAttrb[i])).invoke(list.get(m)).toString();
                                reponse+="</td>\n"; 
                            }
                            reponse+="</tr>\n";  
                        }
                        reponse+="</tbody>\n";  
                    reponse+="</table>\n";
                    /*reponse+="<img src=\"C:\\Users\\Rabeasimbola\\Pictures\\image\\IMG_2769(2).JPG\" />\n";
                    reponse+="<img src=\"C:\\Users\\Rabeasimbola\\Pictures\\image\\IMG_2769(2).JPG\" />\n";*/
            reponse+="</div>\n";
            //System.out.println(reponse);
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    
    public String genererFacturePDF(int idactepatient,String date) throws Exception{
        String reponse = "";
        DaoGeneric dao = new DaoGeneric();
        double total = 0.0;
        DecimalFormat d = new DecimalFormat("0,000.00");
        DateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        Date dat = dateformat.parse(date);
        DateFormat df = new SimpleDateFormat("dd MMMM yyyy",Locale.FRANCE);
        String string = df.format(dat);
        try {
            String sql = "select * from v_actepatientdep where idactepatient = "+idactepatient+" and date = '"+date+"'";
            ArrayList list = dao.find(sql, new V_actepatientdep());
            reponse+="<center><h2>Facture</h2></center>\n";
            reponse+="<h3>Date : "+string+"</h3>\n";
            if (list.size() != 0) {
                reponse+="<p>Facture numero  : 00"+((V_actepatientdep) list.get(0)).getIdactepatient()+"</p>\n";
                reponse+="<p>Nom Client   : "+((V_actepatientdep) list.get(0)).getNom()+"</p>\n";
            }
            reponse+="<p>...</p>\n";  
            reponse+="<table style='margin-top:\"10px\";' class=\"table\" border=\"1\">\n";
                    reponse+="<thead>\n";  
                        reponse+="<tr>\n"; 
                                reponse+="<th>\n";
                                reponse+="Acte\n";
                                reponse+="</th>\n";
                                reponse+="<th>\n";
                                reponse+="Tarif\n";
                                reponse+="</th>\n";
                        reponse+="</tr>\n"; 
                        reponse+="</thead>\n";
                        reponse+="<tbody>\n";  
                        for(int m=0;m<list.size();m++){
                            total+=((V_actepatientdep) list.get(m)).getTarif();
                            reponse+="<tr>\n";  
                                reponse+="<td>"; 
                                reponse+=""+((V_actepatientdep) list.get(m)).getNomacte();
                                reponse+="</td>\n"; 
                                reponse+="<td>"; 
                                reponse+=""+((V_actepatientdep) list.get(m)).getStrTarif();
                                reponse+="</td>\n"; 
                            reponse+="</tr>\n";  
                        }
                        reponse+="</tbody>\n"; 
            reponse+="</table>\n"; 
            String string1 = d.format(total).toString();
            System.out.println("aaaaaaaaaaaaa  "+string1);
            reponse+="<h3 style=\"text-align:'left' \" >Total : "+d.format(total)+" Ar\n"; 
            reponse+="</h3>\n"; 
            reponse+="";
        } catch (Exception e) {
            throw e;
        }
        return reponse;
    }
    /*public static void main(String[] args) throws Exception {
        Pdf p = new Pdf();
        p.tablepdf(new Personne(), "select * from personne");
    }*/
}
