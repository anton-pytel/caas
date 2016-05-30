package sk.anthony.restmpc;

public class ControlledSystem {
   public StateSpace ss;
   public TransferFcn tfcn;
   public double inputDelay;
   public double samplingTime = 0.1;
   public ControllerState ctrlState;
   
	public ControlledSystem(){
	}
	
	public ControlledSystem(StateSpace ss,
							TransferFcn tfcn,
							double inputDelay,
							double samplingTime,
							ControllerState ctrlState){
		this.ss = ss;
		this.tfcn = tfcn;
		this.inputDelay = inputDelay;
		this.samplingTime = samplingTime;
		this.ctrlState = ctrlState;
	}	
}
