package sk.anthony.restmpc;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertyFile {
	public static Properties prop;
	
	public static void init() {
		prop = new Properties();
		InputStream input = null;

		try {
			
			input = PropertyFile.class.getClassLoader().getResourceAsStream("config.properties");

			// load a properties file
			prop.load(input);

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	
  }
}