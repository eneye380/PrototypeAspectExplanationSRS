/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.db_connection;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
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

    public ReadFromFilleToDB() throws SQLException {
        //this.path = path;
        dbupdate = new DBUpdate();

    }

    public static void main(String[] argv) throws SQLException, IOException {
        ReadFromFilleToDB r = new ReadFromFilleToDB();
        r.testReadFile();
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
        String name = "abdul'eneye";
        String nq = name.replaceAll("'", "''");
        System.out.println("name : " + name);
        System.out.println("name : " + nq);
        dbupdate.insertRecordR(dataValue);
        path = "";

    }

    public void readProductSentimentAspectFile() {

        //int i = 1;
        int n = 1;
        path += "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product Aspect Sentiment\\Product Aspect Sentiment\\AspectsScores-B00427Z7NM.txt";
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

                    line = aspinput.nextLine();
                    getAspect(line);
                    //break;
                }
            }
        } catch (IOException e) {
            System.out.println("File does not exist");
        }

        /**
         * Writes to Aspectsentiments score to text file in json format
         */
        //WriteToFile wtf = new WriteToFile(msg);
        //wtf.writeToJSON();
        System.out.println(msg);
    }

    public void readProductDetailFile() {

        int i = 1;
        int n = 1;
        path += "C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product details\\Product details\\B003VWDSJO.txt";
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

        System.out.println(line);
        System.out.println(dataValue.length);
        /**
         * Inserts into product details table
         */
        //dbupdate.insertRecordD(data);
        for (int nn = 0; nn < dataValue.length; nn++) {
            System.out.println(dataKey[nn] + " : " + dataValue[nn]);
        }

    }

    public void getAspect(String line) {
        String nm = "";
        String vl = "";
        String[] ln = line.split(";");
        data = new String[4];
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
        System.out.print(msg);
        System.out.print("data " + data.toString());
        /**
         * Inserts into productsentimentaspect table
         */
        //dbupdate.insertRecord(data);

    }

    public void testReadFile() throws IOException {
        File folder = new File("C:\\Users\\eneye380\\Documents\\MSc RGU Project\\New folder\\Product reviews\\Product reviews\\B00427Z7NM\\");
        File[] listOfFiles = folder.listFiles();

        for (int i = 0; i < listOfFiles.length; i++) {
            File file = listOfFiles[i];
            if (file.isFile() && file.getName().endsWith(".txt")) {
                //String content = FileUtils.readFileToString(file);
                System.out.println(i+1+":-");
                System.out.println(file.getName());
                System.out.println(file.getAbsolutePath());
                //System.out.println(file.getCanonicalPath());
                //System.out.println(file.getParent());
                //System.out.println(file.getPath());
                String p = file.getAbsolutePath();
                this.readProductReviewFile(p);
                
                /* do somthing with content */
            }
        }

    }
}
