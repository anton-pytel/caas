package sk.anthony;

public class StateSpace {
	public double[][] sysA;
	public double[][] sysB;
	public double[][] sysC;
	public double[][] sysD;
	
	public StateSpace(){
	}
	
	public StateSpace(double[][] sysA, 
					  double[][] sysB, 
					  double[][] sysC, 
					  double[][] sysD ){
		this.sysA = sysA;
		this.sysB = sysB;
		this.sysC = sysC;
		this.sysD = sysD;
	}	
}
