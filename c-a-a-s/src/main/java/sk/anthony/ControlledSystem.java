package sk.anthony;

public class ControlledSystem {
   public StateSpace ss;
   public TransferFcn tfcn;
   public double inputDelay;
   public double samplingTime = 0.1;
   public double y0;
   public double x0;
   public double u0;
   public double[][] yOutput;
   public double[][] xState;
   public double[][] uAction;
   
	public ControlledSystem(){
	}
	
	public ControlledSystem(StateSpace ss,
							TransferFcn tfcn,
							double inputDelay,
							double samplingTime){
		this.ss = ss;
		this.tfcn = tfcn;
		this.inputDelay = inputDelay;
		this.samplingTime = samplingTime;
	}	
}
