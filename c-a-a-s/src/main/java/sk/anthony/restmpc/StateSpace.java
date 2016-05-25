package sk.anthony.restmpc;

public class StateSpace {
	public DoubleArrayMatlab sysA;
	public DoubleArrayMatlab sysB;
	public DoubleArrayMatlab sysC;
	public DoubleArrayMatlab sysD;
	
	public StateSpace(){
	}
	
	public StateSpace(DoubleArrayMatlab sysA, 
					  DoubleArrayMatlab sysB, 
					  DoubleArrayMatlab sysC, 
					  DoubleArrayMatlab sysD ){
		this.sysA = sysA;
		this.sysB = sysB;
		this.sysC = sysC;
		this.sysD = sysD;
	}	
}
