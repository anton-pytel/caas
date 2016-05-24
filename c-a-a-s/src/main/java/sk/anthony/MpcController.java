package sk.anthony;

import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import matlabcontrol.MatlabConnectionException;
import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import matlabcontrol.MatlabProxyFactory;
import matlabcontrol.MatlabProxyFactoryOptions;


@Document(collection = "controllers")
public class MpcController {
	@Id
	public String mpcid;
	public Date created;
	
	public float[][] sysA;
	public float[][] sysB;
	public float[][] sysC;
	public float[][] sysD;
	public float inputDelay;
	

	public MpcController(){
	}
	
	public MpcController(float[][] sysA, 
						 float[][] sysB, 
						 float[][] sysC, 
						 float[][] sysD, 
						 float inputDelay ){
		this.sysA = sysA;
		this.sysB = sysB;
		this.sysC = sysC;
		this.sysD = sysD;
		this.inputDelay = inputDelay;
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
		final Long MATLAB_PROXY_TIMEOUT = 200000L;
		
		MatlabProxyFactoryOptions options = new MatlabProxyFactoryOptions.Builder()
	               .setHidden(false)
	               .setUsePreviouslyControlledSession(true)
	               .setProxyTimeout(MATLAB_PROXY_TIMEOUT)
	               .build();
		// setup the factory
		//builder.setCopyPasteCallback(null);  // connects to an existing MATLAB by copy-pasting a few lines into the command window
		//builder.setUsePreviouslyControlledSession(false); //starts a new MATLAB or connects to a previously started MATLAB without any user intervention
		MatlabProxyFactory factory = new MatlabProxyFactory(options);
		// get the proxy
		MatlabProxy proxy = null;
		try {
			proxy = factory.getProxy();
		} catch (MatlabConnectionException e) {
			e.printStackTrace();
			storeErr(e);
			return;
		}
		// do stuff over the proxy
		try {
			proxy.eval("disp('hello world!')");
		} catch (MatlabInvocationException e) {
			proxy.disconnect();
			e.printStackTrace();
			storeErr(e);
			
		}
		// disconnect the proxy
		proxy.disconnect();
	}

}
