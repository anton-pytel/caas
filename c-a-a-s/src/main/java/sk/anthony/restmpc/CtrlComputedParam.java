package sk.anthony.restmpc;

public class CtrlComputedParam {
    public DoubleArrayMatlab aHat;  //V => Matica A^1, A^2, ..., horizont predikcie
    public DoubleArrayMatlab bHat;  //T =>  horizont predikcie (hp) 3 
                             //T  =   A^0 B           0          0
    					     //       A^1 B         A^0 B        0
    						 //       A^2 B         A^1 B      A^0 B  
    public DoubleArrayMatlab qHat;  //matica vah vystupu podla hp 
    public DoubleArrayMatlab quHat; //matica vah vstupuov podla hp
    public DoubleArrayMatlab hHat;  //matica C podla  hp
    public int nx;        //pocet stavov
    public int nu;		 //pocet vstupov
    public int ny;    	 //pocet vystupov

  
	public CtrlComputedParam(){
	}
	
	public CtrlComputedParam(
						    DoubleArrayMatlab aHat,
						    DoubleArrayMatlab bHat,
						    DoubleArrayMatlab qHat,
						    DoubleArrayMatlab quHat,
						    DoubleArrayMatlab hHat,
						    int nx,
						    int nu,
						    int ny
						    ){

		this.aHat = bHat;
		this.bHat = bHat;
		this.qHat = qHat;
		this.quHat = quHat;
		this.hHat = hHat;
		this.nx = nx;
		this.nu = nu;
		this.ny = ny;
	}
}
