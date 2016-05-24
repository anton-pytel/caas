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
							double samplingTime,
							double y0,
							double x0,
							double u0,
							double[][] yOutput,
							double[][] xState,
							double[][] uAction){
		this.ss = ss;
		this.tfcn = tfcn;
		this.inputDelay = inputDelay;
		this.samplingTime = samplingTime;
		this.y0 = y0;
		this.x0 = x0;
		this.u0 = u0;
		this.yOutput = yOutput;
		this.xState = xState;
		this.uAction = uAction;
	}	
}
