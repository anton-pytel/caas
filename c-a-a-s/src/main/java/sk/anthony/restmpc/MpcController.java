package sk.anthony.restmpc;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;


@Document(collection = "controllers")
public class MpcController {
	
	public enum EnumStatus {
		@SerializedName("init")
		INIT,
		@SerializedName("computing")
	    COMPUTING,
	    @SerializedName("computed")
	    COMPUTED
	}
	
	@Id
	public String mpcid;
	public Date created;
	public Date updated;
	public ControlledSystem ctlSys;
	public ControllerParams ctlParam;
	public CtrlComputedParam ctlCptParam;
	public List<ControllerStep> ctlStep;
	public EnumStatus state;
	

	public MpcController(){
	}
	
	public MpcController(ControlledSystem  ctlSys,
				  		 ControllerParams ctlParam,
				 		 CtrlComputedParam ctlCptParam,
				 		 List<ControllerStep> ctlStep,
				 		 EnumStatus state){
		this.ctlSys = ctlSys;
		this.ctlParam = ctlParam;
		this.ctlCptParam = ctlCptParam;
		this.ctlStep = ctlStep;
		this.state = state;
	}
	public void addStep(ControllerStep xStep){
		this.ctlStep.add(xStep);
	}
	public void setCreated(Date xDate){
		this.created = xDate;
	}
	public void setUpdated(Date xDate){
		this.updated = xDate;
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
	
	public MpcController store2Mongo(MpcController xMC){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		xMC.setCreated(new Date());
		mongoOperation.save(xMC);
		return xMC;		
	}

	public MpcController update2Mongo(MpcController xMC){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		xMC.setUpdated(new Date());
		mongoOperation.save(xMC);
		return xMC;		
	}
	
	public void storeFile(MpcController xMC){
		PropertyFile.init(); 
		Gson gson = new Gson();  
		// convert java object to JSON format,
		String json = gson.toJson(xMC);  
		try {  
			FileWriter writer = new FileWriter(PropertyFile.prop.getProperty("matlabFS")+xMC.mpcid);
			writer.write(json); 
			writer.close(); 
		} catch (IOException e) { 
			e.printStackTrace(); 
			storeErr(e);
		} 
	}
	
	public MpcController loadFile(MpcController xMC){
		PropertyFile.init();
		GsonBuilder builder = new GsonBuilder();
		builder.registerTypeAdapterFactory(new MatArraysTypeAdapterFactory());
		Gson gson = builder.create(); 
		BufferedReader br = null;
		try {
			br = new BufferedReader( new FileReader(PropertyFile.prop.getProperty("matlabFS")+xMC.mpcid));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			storeErr(e);
		}
		//convert the json string back to object
		xMC = gson.fromJson(br, MpcController.class);
		
		return xMC;
	}

	public void storeErr(Object e){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		mongoOperation.save(e);
	}

	public MpcController runMatlab(MpcController xMC){
		storeFile(xMC);
		PropertyFile.init(); 
		try {
	        ProcessBuilder pb = new ProcessBuilder(PropertyFile.prop.getProperty("pythonBin"), 
	        									   PropertyFile.prop.getProperty("matlabIfc"),
								 		           xMC.mpcid
								 		           );
			Process p = pb.start();	
			int exitVal = p.waitFor();

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
		xMC = loadFile(xMC);
		return xMC;
	}

}
