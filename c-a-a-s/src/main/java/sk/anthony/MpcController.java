package sk.anthony;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.google.gson.Gson;


@Document(collection = "controllers")
public class MpcController {
	@Id
	public String mpcid;
	public Date created;

	public ControlledSystem ctlSys;
	public ControllerParams ctlParam;
	public CtrlComputedParam ctlCptParam;

	public MpcController(){
	}
	
	public MpcController(ControlledSystem  ctlSys,
				  		 ControllerParams ctlParam,
				 		 CtrlComputedParam ctlCptParam){
		this.ctlSys = ctlSys;
		this.ctlParam = ctlParam;
		this.ctlCptParam = ctlCptParam;
	}
	
	public void setCreated(Date xDate){
		this.created = new Date();
	}
	
    public String getmpcid() {
        return mpcid;
    }
    
	public MpcController getMC(String mpcid){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		Query searchUserQuery = new Query(Criteria.where("_id").is(mpcid));
		// find the saved user again.
		MpcController lMC = mongoOperation.findOne(searchUserQuery, MpcController.class);
		return lMC;
	}
	
	public MpcController storeMC(MpcController xMC){
		xMC = store2Mongo(xMC);
		store2File(xMC);
		return xMC;
	}
	public MpcController store2Mongo(MpcController xMC){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		xMC.setCreated(new Date());
		mongoOperation.save(xMC);
		return xMC;		
	}
	
	public void store2File(MpcController xMC){
		PropertyFile.init(); 	
		Gson gson = new Gson(); // convert java object to JSON format, // and returned as JSON formatted string 
		String json = gson.toJson(xMC); 
		try {  
			FileWriter writer = new FileWriter(PropertyFile.prop.getProperty("matlabFS")+xMC.mpcid); 
			writer.write(json); 
			writer.close(); 
		} catch (IOException e) { 
				e.printStackTrace(); 
		} 
	}

	public void storeErr(Object e){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		mongoOperation.save(e);
	}

	public void runMatlab(MpcController xMC){
		PropertyFile.init(); 
		try {
	        ProcessBuilder pb = new ProcessBuilder(PropertyFile.prop.getProperty("pythonBin"), 
	        									   PropertyFile.prop.getProperty("matlabIfc"),
								 		           xMC.mpcid
								 		           );
			//Map<String, String> env = pb.environment();
	        // set environment variable u
	        //env.put("SystemRoot", "C:\\Windows");
			Process p = pb.start();	
			int exitVal = p.waitFor();
			/*try {
			    Thread.sleep(10000);                 //1000 milliseconds is one second.
			} catch(InterruptedException ex) {
			    Thread.currentThread().interrupt();
			}*/
			StringBuffer output = new StringBuffer();
			BufferedReader reader = 
                    new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";			
			while ((line = reader.readLine())!= null) {
				output.append(line + "\n");
			}
			StringBuffer err = new StringBuffer();
			reader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			line = "";			
			while ((line = reader.readLine())!= null) {
				err.append(line + "\n");
			}
			
			storeErr( new LogObj(xMC.mpcid + "\nExited with error code \n" +  exitVal + "\n" + output + "\n" + err));
		} catch (Exception e) {
			e.printStackTrace();
			storeErr(e);
		}

	}

}
