package sk.anthony.restmpc;

public class ControllerState {
	   public ArrayMatlab y0;
	   public ArrayMatlab x0;
	   public ArrayMatlab x1;
	   public ArrayMatlab u0;
	   public ControllerState(){
		   
	   }
		
		public ControllerState(ArrayMatlab y0,
					  	       ArrayMatlab x0,
					  	       ArrayMatlab x1,
							   ArrayMatlab u0){

			this.y0 = y0;
			this.x0 = x0;
			this.x1 = x1;
			this.u0 = u0;	
		}
		
		private double[] fillWtihVal(int arrSize, double value){
			double[] arr = new double[arrSize];
			for (int i=0;i<arrSize;i++){
				arr[i] = value;
			}
			return arr;
		}
		
		
		public ControllerState(int nx, int nu, int ny){
		  final double Y_VAL = 0;
		  final double X_VAL = 0;
		  final double U_VAL = 0;
		  this.y0=new ArrayMatlab(fillWtihVal(ny, Y_VAL));
		  this.x0=new ArrayMatlab(fillWtihVal(nx, X_VAL));
		  this.x1=new ArrayMatlab(fillWtihVal(nx, X_VAL));
		  this.u0=new ArrayMatlab(fillWtihVal(nu, U_VAL));
		}
}
