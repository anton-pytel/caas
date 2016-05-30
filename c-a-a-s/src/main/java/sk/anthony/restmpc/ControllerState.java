package sk.anthony.restmpc;

public class ControllerState {
	   public double y0 = 0;
	   public double x0 = 0;
	   public double x1 = 0;
	   public double u0 = 0;
	   public ControllerState(){
		   
	   }
		
		public ControllerState(double y0,
							   double x0,
							   double x1,
							   double u0){

			this.y0 = y0;
			this.x0 = x0;
			this.x1 = x1;
			this.u0 = u0;	
		}
}
