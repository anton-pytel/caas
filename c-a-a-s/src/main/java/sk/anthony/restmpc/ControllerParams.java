package sk.anthony.restmpc;

public class ControllerParams {
	public double predictHorizon=5;
	public double qy = 1;    //vaha vystupu i<n
	public double sy = 1;    //vaha vystupu i=n
	public double qu = 0.01; //vaha vstupu
	public ControllerConstraints ctrlConstr; 
    public RefSignal[][] refSig; 

  
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
	public void setRefSig(int ny){
		final double TIME_0 = 0;
		final double VAL_0 = 0;
		final double TIME_N = 1;
		final double VAL_N = 1;
		RefSignal[][] rs = new RefSignal[ny][2];
		for (int i=0;i<ny;i++) {
			rs[i][0] = new RefSignal(TIME_0, VAL_0);
			rs[i][1] = new RefSignal(TIME_N, VAL_N);
		}
		this.refSig = rs;
	}
}
