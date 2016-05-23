package sk.anthony;

import java.util.Date;
import javax.xml.bind.annotation.XmlRootElement;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;


@Document(collection = "controllers")
@XmlRootElement
public class MpcController {
	@Id
	public String mpcid;
	public Date created;
	
	public String sysA;
	public String sysB;
	
	/*
	String sysC;
	String sysD;
	Number inputDelay;
	*/

	public MpcController(){
	}
	
	public MpcController(String sysA, String sysB){
		this.sysA = sysA;
		this.sysB = sysB;
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
	
	
}
