package sk.anthony.restmpc;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class ControllerStep {
		
	public double stepid;
	public Date created;
	public ControllerState ctrlStateLast;
	public ControllerState ctrlStateNew;	
	public ControllerConstraints ctrlConstr; 
    public RefSignal[][] refSig; 
    
    public ControllerStep(){
    	
    }
    
	public ControllerStep(double stepid, 
						  Date created, 
						  ControllerConstraints ctrlConstr,
						  RefSignal[][] refSig,
						  ControllerState ctrlStateLast,
						  ControllerState ctrlStateNew
						  ) {
		this.stepid = stepid;
		this.created = created;
		this.ctrlConstr = ctrlConstr;
		this.refSig = refSig;

	}
	
	public ControllerStep init(MpcController xMC){
		ControllerStep lstep = new ControllerStep();
		lstep.ctrlStateLast = xMC.ctlSys.ctrlState;
		lstep.ctrlConstr = xMC.ctlParam.ctrlConstr;
		return lstep;
	}
	
	public void setCreated(Date xDate){
		this.created = xDate;
	}
	
	public void setStepId(double xid){
		this.stepid = xid+1;
		new MpcController().storeErr( new LogObj(String.valueOf(xid)));
	}
	
	
	public ControllerStep init(ControllerStep xStep, MpcController xMC){
		xStep.setCreated(new Date());
		//ak nie je na vstupe Ref signal zoberiem z MPcontrolera 
		if (xStep.refSig == null) {
			xStep.refSig = xMC.ctlParam.refSig;
		}
		//ak nie su na vstupe obmedzenia zoberieme z MPcontrolera
		if (xStep.ctrlConstr == null) {
			xStep.ctrlConstr = xMC.ctlParam.ctrlConstr;
		}
		// ak uz existuje krok tak pridame nakoniec inak vytvorim kolekciu a vlozim prvy prvok
		if (xMC.ctlStep != null) {
			xStep.setStepId(xMC.getLastStepId());
			//ak nemame posledny stav zo vstupu, tak precitame NEW z posledneho
			if (xStep.ctrlStateLast == null ){
				xStep.ctrlStateLast = xMC.getStep(xMC.getLastStepId()).ctrlStateNew;
			}			
			xMC.ctlStep.add(xStep);
		} else {
			xStep.stepid = 1;
			xMC.ctlStep = new ArrayList<ControllerStep>();
			//ak nemame posledny stav zo vstupu, tak precitame z controllera
			if (xStep.ctrlStateLast == null ){
				xStep.ctrlStateLast = xMC.ctlSys.ctrlState;
			}			
			xMC.ctlStep.add(xStep);
		}
		ControllerState cs = runMatlab(xMC, xStep.stepid);
		xStep.ctrlStateNew = cs;
		xMC.update2Mongo();
		return xStep;
	}
	
	private String getSuffix(double stepid){
		return "_" + String.format("%.0f",stepid);
	}

	public ControllerState loadFile(MpcController xMC, double stepid){
		final String LOG_OPTION = "Y";
		PropertyFile.init();
		GsonBuilder builder = new GsonBuilder();
		builder.registerTypeAdapterFactory(new MatArraysTypeAdapterFactory());
		Gson gson = builder.create(); 
		BufferedReader br = null;
		String filename = PropertyFile.prop.getProperty("matlabFS")+xMC.mpcid+getSuffix(stepid);
		String filename1 = PropertyFile.prop.getProperty("matlabFS")+xMC.mpcid;
		try {
			br = new BufferedReader( new FileReader(filename));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			xMC.storeErr(e);
		}
		//convert the json string back to object
		ControllerState cs = gson.fromJson(br, ControllerState.class);
		if (PropertyFile.prop.getProperty("logging").toString() != LOG_OPTION) {
			new File(filename).delete();
			new File(filename1).delete();
		}
		return cs;
	}

	public ControllerState runMatlab(MpcController xMC, double stepid){
		xMC.storeFile(xMC);
		PropertyFile.init(); 
		try {
	        ProcessBuilder pb = new ProcessBuilder(PropertyFile.prop.getProperty("pythonBin"), 
	        									   PropertyFile.prop.getProperty("matlabIfc"),
								 		           xMC.mpcid,
								 		           String.format("%.0f",stepid)
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
			
			xMC.storeErr( new LogObj(xMC.mpcid + "_" + String.format("%.0f",stepid) + "\nExited with error code \n" +  
									 exitVal + "\n" + output + "\n" + err));
		} catch (Exception e) {
			e.printStackTrace();
			xMC.storeErr(e);
		}
		ControllerState cs = loadFile(xMC, stepid);
		return cs;
	}
    
}
