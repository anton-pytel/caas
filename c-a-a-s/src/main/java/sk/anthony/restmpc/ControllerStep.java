package sk.anthony.restmpc;

import java.util.Date;


public class ControllerStep {
	
	public double stepid;
	public Date created;	
	public ControllerConstraints ctrlConstr; 
    public RefSignal[][] refSig; //TODO: doublematlabArray?
	public ControllerState ctrlStateLast;
	public ControllerState ctrlStateNew;
    
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
    

    
}
