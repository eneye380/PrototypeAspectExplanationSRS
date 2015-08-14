/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.db_connection;
import java.io.*;
import javax.swing.*;

/**
 *
 * @author 1409777
 */
public class WriteToFile {
	
	private String write;
	
	public WriteToFile(String write){
		
		this.write = write;
	}
	
	public void writeToJSON() throws FileNotFoundException{
		boolean OK = true;
		File file = new File("B00427Z7NM.json");
		if (file.exists()){
			int ans = JOptionPane.showConfirmDialog(null,
				"File already exists\n"+
				"Contents will be overwritten\nOK to proceed?");
			if(ans != JOptionPane.YES_OPTION) OK = false;
		}
		if(OK){ PrintWriter output = new PrintWriter(file);
			output.print(write);
			output.close();
		}
		
	}
	
}
