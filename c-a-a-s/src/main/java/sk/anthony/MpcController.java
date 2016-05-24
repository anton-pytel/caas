package sk.anthony;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;


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
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		xMC.setCreated(new Date());
		mongoOperation.save(xMC);
		return xMC;
	}

	public void storeErr(Object e){
		@SuppressWarnings("resource")
		ApplicationContext ctx = new GenericXmlApplicationContext("SpringConfig.xml");
		MongoOperations mongoOperation = (MongoOperations) ctx.getBean("mongoTemplate");
		mongoOperation.save(e);
	}

	public void run(){
		
	}

}
