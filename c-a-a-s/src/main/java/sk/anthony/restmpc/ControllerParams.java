package sk.anthony.restmpc;

public class ControllerParams {
	public double predictHorizon;
	public double qy = 1;    //vaha vystupu i<n
	public double sy = 1;    //vaha vystupu i=n
	public double qu = 0.01; //vaha vstupu
    public ArrayMatlab uMin;
    public ArrayMatlab uMax;
    public ArrayMatlab duMin;
    public ArrayMatlab duMax;
    public ArrayMatlab yMin;
    public ArrayMatlab yMax;
    public ArrayMatlab dyMin;
    public ArrayMatlab dyMax;  
    public RefSignal[][] refSig; //TODO: doublematlabArray?

  
	public ControllerParams(){
	}
	
	public ControllerParams(double predictHorizon,
						    double qy,
						    double sy,
						    double qu,
						    ArrayMatlab uMin,
						    ArrayMatlab uMax,
						    ArrayMatlab duMin,
						    ArrayMatlab duMax,
						    ArrayMatlab yMin,
						    ArrayMatlab yMax,
						    ArrayMatlab dyMin,
						    ArrayMatlab dyMax,
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
