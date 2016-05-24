package sk.anthony;

public class CtrlComputedParam {
    public double[][] Ahat;  //V => Matica A^1, A^2, ..., horizont predikcie
    public double[][] Bhat;  //T =>  horizont predikcie (hp) 3 
                             //T  =   A^0 B           0          0
    					     //       A^1 B         A^0 B        0
    						 //       A^2 B         A^1 B      A^0 B  
    public double[][] qHat;  //matica vah vystupu podla hp 
    public double[][] quHat; //matica vah vstupuov podla hp
    public double[][] hHat;  //matica C podla  hp
    public double nx;        //pocet stavov
    public double nu;		 //pocet vstupov
    public double ny;    	 //pocet vystupov

  
	public CtrlComputedParam(){
	}
	
	public CtrlComputedParam(
						    double[][] Ahat,
						    double[][] Bhat,
						    double[][] qHat,
						    double[][] quHat,
						    double[][] hHat,
						    double nx,
						    double nu,
						    double ny
						    ){

		this.Ahat = Ahat;
		this.Bhat = Bhat;
		this.qHat = qHat;
		this.quHat = quHat;
		this.hHat = hHat;
		this.nx = nx;
		this.nu = nu;
		this.ny = ny;
	}
}
