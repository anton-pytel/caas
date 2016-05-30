package sk.anthony.restmpc;

public class ControllerParams {
	public double predictHorizon=5;
	public double qy = 1;    //vaha vystupu i<n
	public double sy = 1;    //vaha vystupu i=n
	public double qu = 0.01; //vaha vstupu
	public ControllerConstraints ctrlConstr; 
    public RefSignal[][] refSig; //TODO: doublematlabArray?

  
	public ControllerParams(){
	}
	
	public ControllerParams(double predictHorizon,
						    double qy,
						    double sy,
						    double qu,
						    ControllerConstraints ctrlConstr,
						    RefSignal[][] refSig
						    ){
		this.predictHorizon = predictHorizon;
		this.qy = qy;
		this.qu = qu;
		this.sy = sy;
		this.ctrlConstr = ctrlConstr;
		this.refSig = refSig;
	}
}
