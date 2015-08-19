/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.db_connection;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author eneye380
 */
public class ReadFromFilleToDB {

    private String path = "";
    private String msg;
    private String line = "";
    //private String msg = "{\"B00427Z7NM\":[";
    private boolean sentinel = false;
    private String[] data;
    private String[] dataKey;
    private String[] dataValue;
    private DBUpdate dbupdate;
    private int check = 0;

    public ReadFromFilleToDB() throws SQLException {
        //this.path = path;
        dbupdate = new DBUpdate();

    }

    public static void main(String[] argv) throws SQLException, IOException {
        ReadFromFilleToDB r = new ReadFromFilleToDB();
        //r.testReadFile();
        ArrayList<File> files = new ArrayList<>();
        // specify folder directory to load files and insert into the db
        String directory = "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\Dataset\\DSLR\\DSLR\\Product details";
        r.ReadFolderFiles(directory, files);
    }
    
    public void readRecommendations(String p) {
        
        int i = 1;
        int n = 0;
        //path = "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\Dataset\\DSLR\\DSLR\\Recommended products DSLR.txt";
        path += p;
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
                            dbupdate.insertRecommendation(qp, pr);
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


    public void readProductReviewFile(String p) {

        int i = 1;
        int n = 0;
        //path += "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product reviews\\Product reviews\\B003VWDSJO\\0_30.12.2010.txt";
        path += p;
        File aspects = new File(path);
        File count = new File(path);
        dataKey = new String[11];
        dataValue = new String[11];
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

                    String[] ln = line.split("=");
                    //System.out.println(ln.length);
                    if (i < 12) {
                        dataKey[i - 1] = ln[0];
                        if (ln.length == 1) {
                            dataValue[i - 1] = "";
                        } else if (ln.length == 2) {
                            dataValue[i - 1] = ln[1];
                        }
                    }
                    //dataKey[i - 1] = ln[0];
                    //dataValue[i - 1] = ln[1];

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
        for (int nn = 0; nn < dataValue.length; nn++) {
            System.out.println(dataKey[nn] + " : " + dataValue[nn]);
        }
        //uncomment to use
        dbupdate.insertRecordR(dataValue);
        path = "";

    }

    public void readProductSentimentAspectFile(String p, File file) {

        int i = 1;
        int n = 1;
        //path += "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product Aspect Sentiment\\Product Aspect Sentiment\\AspectsScores-B00427Z7NM.txt";
        path += p;
        File aspects = new File(path);
        File count = new File(path);
        data = new String[11];
        try {
            Scanner test = new Scanner(count);
            while (test.hasNext()) {
                n++;
                test.nextLine();
            }
        } catch (IOException e) {
            System.out.print("File does not exist");
        }
        System.out.println(n);
        try {
            try (Scanner aspinput = new Scanner(aspects)) {

                while (aspinput.hasNext()) {
                    
                    if(i==n-1){
                        sentinel  = true;
                    }
                    line = aspinput.nextLine();
                    processAspects(line, file);
                    check++;
                    i++;
                    //break;
                }
            }
        } catch (IOException e) {
            System.out.println("File does not exist");
        }

        /**
         * Writes the Aspectsentiments score to text file in json format
         */
        //WriteToFile wtf = new WriteToFile(msg);
        //wtf.writeToJSON();// writes converted aspect details to txt file
        System.out.println("\n\nASPECT :: "+check+ " aspect");
        System.out.println(msg);
        path = "";
        msg = "";
        check = 0;
    }

    public void readProductDetailFile(String p) {

        int i = 1;
        int n = 1;
        //path += "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product details\\Product details\\B003VWDSJO.txt";
        path += p;
        File aspects = new File(path);
        File count = new File(path);
        dataKey = new String[11];
        dataValue = new String[11];
        try {
            Scanner test = new Scanner(count);
            while (test.hasNext()) {
                n++;
                test.nextLine();
            }
        } catch (IOException e) {
            System.out.println("File does not exist");
        }
        System.out.println(n);
        try {
            try (Scanner aspinput = new Scanner(aspects)) {

                while (aspinput.hasNext()) {

                    line = aspinput.nextLine();
                    if (i < 12) {
                        String[] ln = line.split("=");
                        dataKey[i - 1] = ln[0];
                        dataValue[i - 1] = ln[1];
                    }
                    if (i == 12) {
                        System.out.println(i + " : " + line);
                        String[] l = line.split(",");
                        //int j = 1;
                        System.out.println(l.length);
                        for (int m = 0; m < l.length; m++) {
                            if (m != 0) {
                                /**
                                 * Inserts into productsboughtafter table
                                 */
                                //dbupdate.insertRecordV(l[m]);
                                System.out.println(l[m]);
                            } else if (m == 0) {
                                String s = l[m].substring(20);
                                /**
                                 * Inserts into productsboughtafter table
                                 */
                                //dbupdate.insertRecordV(s);
                                System.out.println(s);
                            }
                        }
                    }
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
         * Inserts into product details table
         */
        dbupdate.insertRecordD(dataValue);
        for (int nn = 0; nn < dataValue.length; nn++) {
           System.out.println(dataKey[nn] + " : " + dataValue[nn]);
        }
        path = "";

    }

    public void processAspects(String line, File file) {
        String nm = "";
        String vl = "";
        String[] ln = line.split(";");
        data = new String[4];
         String productid = file.getName().substring( file.getName().lastIndexOf("-")+1, file.getName().lastIndexOf("."));
         if(check == 0){
        msg = "{"+"\""+productid+"\""+":["; // variable msg stores aspect in json format
         }
        //System.out.println(ln[1]);
        for (int i = 0; i < ln.length; i++) {
            String[] u = ln[i].split(":");
            nm = u[0];
            vl = u[1];
            data[i] = vl;
            if (i == 0) {
                msg += "{\"" + nm + "\":" + "\"" + vl + "\",";
            } else if (i < ln.length - 1) {
                msg += "\"" + nm + "\":" + "\"" + vl + "\",";
            } else if (i == ln.length - 1) {
                msg += "\"" + nm + "\":" + "\"" + vl + "\"}";
            }

            //System.out.println(nm +" = "+vl);
        }

        //sentinel = true;
        if (sentinel == false) {
            msg += ",\n";
            //sentinel = true;
        } else {
            msg += "]}\n";
        }
        //msg+="";
        //System.out.print(msg);
        //System.out.print("data " + data.toString());
        /**
         * Inserts into productsentimentaspect table
         */
        dbupdate.insertRecordA(data, file);
        data = null;

    }
/**
 * Dont't use
 * @throws IOException 
 */
    public void testReadFile() throws IOException {
        File folder = new File("C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product reviews\\Product reviews\\B00427Z7NM\\");
        File[] listOfFiles = folder.listFiles();

        for (int i = 0; i < listOfFiles.length; i++) {
            File file = listOfFiles[i];
            if (file.isFile() && file.getName().endsWith(".txt")) {

                System.out.println(i + 1 + ":-");
                System.out.println(file.getName());
                System.out.println(file.getAbsolutePath());
                String p = file.getAbsolutePath();
                this.readProductReviewFile(p);

                /* do somthing with content */
            }
        }

    }
    private int iii = 0;

    /**
     * copied and edited from stackoverflow
     *
     * @param directoryName
     * @param files
     */
    public void ReadFolderFiles(String directoryName, ArrayList<File> files) {
        File directory = new File(directoryName);
        // get all the files from a directory
        File[] fList = directory.listFiles();
        for (File file : fList) {

            if (file.isFile() && file.getName().endsWith(".txt")) {
                files.add(file);
                String p = file.getAbsolutePath(); // file absolute path
                //System.out.println("name--"+file.getName().substring(0, file.getName().lastIndexOf(".")));
                //System.out.println("name--"+file.getName().substring( file.getName().lastIndexOf("-")+1, file.getName().lastIndexOf(".")));
                //only one methed can be used at a time(uncomment to use)
                this.readProductDetailFile(p); //for product details only
                //this.readProductReviewFile(p); //for product review only
                //this.readProductSentimentAspectFile(p, file); //for product sentiment aspects
                //this.readRecommendations(p);
                iii++;
            } else if (file.isDirectory()) {
                ReadFolderFiles(file.getAbsolutePath(), files);
                iii++;
            } else if (file.isFile()) {

                File fi = new File(file.getAbsolutePath() + ".txt"); //renames the file to with an extension of .txt
                if (file.renameTo(fi)) {
                    
                    //only one methed can be used at a time(uncomment to use)
                    this.readProductDetailFile(fi.getAbsolutePath()); //for product details only
                    //this.readProductReviewFile(fi.getAbsolutePath()); //for product review only
                    //this.readProductSentimentAspectFile(fi.getAbsolutePath(), file); //for product sentiment aspects
                    //this.readRecommendations(fi.getAbsolutePath());
                    iii++;
                }

            }
        }
        System.out.println("Total Files: " + iii);
    }
}
