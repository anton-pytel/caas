package sk.anthony;

public class ControllerParams {
	public double predictHorizon;
	public double qy = 1;    //vaha vystupu i<n
	public double sy = 1;    //vaha vystupu i=n
	public double qu = 0.01; //vaha vstupu
    public double[] uMin;
    public double[] uMax;
    public double[] duMin;
    public double[] duMax;
    public double[] yMin;
    public double[] yMax;
    public double[] dyMin;
    public double[] dyMax;  
    public RefSignal[][] refSig;

  
	public ControllerParams(){
	}
	
	public ControllerParams(double predictHorizon,
						    double qy,
						    double sy,
						    double qu,
						    double[] uMin,
						    double[] uMax,
						    double[] duMin,
						    double[] duMax,
						    double[] yMin,
						    double[] yMax,
						    double[] dyMin,
						    double[] dyMax,
						    RefSignal[][] refSig
						    ){
		this.predictHorizon = predictHorizon;
		this.qy = qy;
		this.qu = qu;
		this.sy = sy;
		this.uMin = uMin;
		this.uMax = uMax;
		this.duMin = duMin;
		this.duMax = duMax;
		this.yMin = yMin;
		this.yMax = yMax;
		this.dyMin = dyMin;
		this.dyMax = dyMax;
		this.refSig = refSig;
	}
}
