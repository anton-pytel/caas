package sk.anthony.restmpc;

public class ControllerConstraints {
    public ArrayMatlab uMin;
    public ArrayMatlab uMax;
    public ArrayMatlab duMin;
    public ArrayMatlab duMax;
    public ArrayMatlab yMin;
    public ArrayMatlab yMax;
    public ArrayMatlab dyMin;
    public ArrayMatlab dyMax;
    
    public ControllerConstraints() {
    	
    }
    
	public ControllerConstraints(ArrayMatlab uMin, 
								 ArrayMatlab uMax, 
								 ArrayMatlab duMin, 
								 ArrayMatlab duMax,
								 ArrayMatlab yMin, 
								 ArrayMatlab yMax, 
								 ArrayMatlab dyMin, 
								 ArrayMatlab dyMax) {
		this.uMin = uMin;
		this.uMax = uMax;
		this.duMin = duMin;
		this.duMax = duMax;
		this.yMin = yMin;
		this.yMax = yMax;
		this.dyMin = dyMin;
		this.dyMax = dyMax;
	} 
	
	private double[] fillWtihVal(int arrSize, double value){
		double[] arr = new double[arrSize];
		for (int i=0;i<arrSize;i++){
			arr[i] = value;
		}
		return arr;
	}
	
	public ControllerConstraints (int ny,
			                      int nu,
			                      Double minvaly,
			                      Double maxvaly,
			                      Double minvaldy,
			                      Double maxvaldy,
			                      Double minvalu,
			                      Double maxvalu,
			                      Double minvaldu,
			                      Double maxvaldu){
		final double MAX_VAL = 100;
		final double MIN_VAL = -100;
		
		this.uMin = new ArrayMatlab(fillWtihVal(nu,(minvalu==null?MIN_VAL:minvalu)));
		this.uMax = new ArrayMatlab(fillWtihVal(nu,(maxvalu==null?MAX_VAL:maxvalu)));
		this.duMin = new ArrayMatlab(fillWtihVal(nu,(minvaldu==null?MIN_VAL:minvaldu)));
		this.duMax = new ArrayMatlab(fillWtihVal(nu,(maxvaldu==null?MAX_VAL:maxvaldu)));
		this.yMin = new ArrayMatlab(fillWtihVal(ny,(minvaly==null?MIN_VAL:minvaly)));
		this.yMax = new ArrayMatlab(fillWtihVal(ny,(maxvaly==null?MAX_VAL:maxvaly)));
		this.dyMin = new ArrayMatlab(fillWtihVal(ny,(minvaldy==null?MIN_VAL:minvaldy)));
		this.dyMax = new ArrayMatlab(fillWtihVal(ny,(maxvaldy==null?MAX_VAL:maxvaldy)));
	}
}
