/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller_bean;

import aspect.db_connection.DBUpdate;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import javax.ejb.Stateless;

/**
 *
 * @author eneye380
 */
@Stateless
public class AspectImportance implements AspectImportanceLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private ArrayList<String> rankedAspects;
    private String path = "";
    private String msg;
    private String line = "";
    //private String msg = "{\"B00427Z7NM\":[";
    private boolean sentinel = false;
    private DBUpdate dbupdate;

    public static void main(String argv[]) {
        AspectImportance ai = new AspectImportance();
        ai.readRecommendations(null);
    }

    public AspectImportance() {
        this.readAspects("");
    }

    public ArrayList<String> getRankedAspects() {
        return rankedAspects;
    }

    public void setRankedAspects(ArrayList<String> rankedAspects) {
        this.rankedAspects = rankedAspects;
    }

    public void readAspects(String p) {
        rankedAspects = new ArrayList<>();
        int i = 1;
        int n = 0;
        path = "C:\\Users\\eneye380\\Documents\\NetBeansProjects\\Prototype_ESRS\\Prototype_ESRS-war\\web\\src\\DSLR Aspect Importance List.txt";
        //path += p;
        File aspects = new File(path);
        File count = new File(path);

        try {
            Scanner test = new Scanner(count);
            while (test.hasNext()) {
                n++;
                test.nextLine();
            }
        } catch (IOException e) {
            System.out.print("File does not exist");
        }
        //System.out.println(n);
        try {
            try (Scanner aspinput = new Scanner(aspects)) {

                while (aspinput.hasNext()) {

                    line = aspinput.nextLine();

                    //System.out.println(ln.length);
                    System.out.println("\nASPECT:" + line);
                    rankedAspects.add(line);
                    i++;
                    //break;
                }
            }
        } catch (IOException e) {
            System.out.println("File does not exist");
        }

        //System.out.println(line);
        //System.out.println(dataValue.length);
        /**
         * Inserts into ProductReview table
         */
        /*for (int nn = 0; nn < dataValue.length; nn++) {
         System.out.println(dataKey[nn] + " : " + dataValue[nn]);
         }*/
        //uncomment to use
        //dbupdate.insertRecordR(dataValue);
        System.out.println("LIST" + rankedAspects);
        path = "";

    }

    public void readRecommendations(String p) {
        rankedAspects = new ArrayList<>();
        int i = 1;
        int n = 0;
        path = "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\Dataset\\DSLR\\DSLR\\Recommended products DSLR.txt";
        //path += p;
        File aspects = new File(path);
        File count = new File(path);

        try {
            Scanner test = new Scanner(count);
            while (test.hasNext()) {
                n++;
                test.nextLine();
            }
        } catch (IOException e) {
            System.out.print("File does not exist");
        }
        //System.out.println(n);
        String qp="",pr="";
        try {
            try (Scanner aspinput = new Scanner(aspects)) {

                while (aspinput.hasNext()) {

                    line = aspinput.nextLine();

                    //System.out.println(ln.length);
                    if (!line.equalsIgnoreCase("")) {
                        String pre = line.substring(0, line.lastIndexOf(":"));
                        String id = line.substring(line.lastIndexOf(":") + 1, line.lastIndexOf(""));
                        if(pre.equalsIgnoreCase("qp")){
                            qp = id;
                            //System.out.println(i + "-queryproduct:" + id);
                        }else if(pre.equalsIgnoreCase("p")){
                            pr = id;
                            //System.out.println(i + "-productrecommended:" + id);
                            System.out.println(i+" -:- "+qp+" : "+pr);
                            
                        }                        
                    }                    
                    i++;
                    //break;
                }
            }
        } catch (IOException e) {
            System.out.println("File does not exist");
        }
        System.out.println(i);
        
        path = "";

    }

}
