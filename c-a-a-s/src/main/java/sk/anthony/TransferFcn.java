package sk.anthony;

import com.google.gson.annotations.SerializedName;

public class TransferFcn {
/* copied from matlab
   Data format:
     For SISO models, NUM and DEN are row vectors listing the numerator
     and denominator coefficients in descending powers of s,p,z,q or in
     ascending powers of z^-1 (DSP convention). For example,
        sys = tf([1 2],[1 0 10])
     specifies the transfer function (s+2)/(s^2+10) while
        sys = tf([1 2],[1 5 10],0.1,'Variable','z^-1')
     specifies (1 + 2 z^-1)/(1 + 5 z^-1 + 10 z^-2).
 
     For MIMO models with NY outputs and NU inputs, NUM and DEN are
     NY-by-NU cell arrays of row vectors where NUM{i,j} and DEN{i,j}
     specify the transfer function from input j to output i. For example,
        H = tf( {-5 ; [1 -5 6]} , {[1 -1] ; [1 1 0]})
     specifies the two-output, one-input transfer function
        [     -5 /(s-1)      ]
        [ (s^2-5s+6)/(s^2+s) ]
 
   Arrays of transfer functions:
     You can create arrays of transfer functions by using ND cell arrays
     for NUM and DEN above. For example, if NUM and DEN are cell arrays
     of size [NY NU 3 4], then
        SYS = tf(NUM,DEN)
     creates the 3-by-4 array of transfer functions
        SYS(:,:,k,m) = tf(NUM(:,:,k,m),DEN(:,:,k,m)),  k=1:3,  m=1:4.
     Each of these transfer functions has NY outputs and NU inputs.	
 */
	public enum EsysType {
		@SerializedName("sspace")
		SSPACE,
		@SerializedName("zspace")
	    ZSPACE,
	    @SerializedName("numden")
	    NUMDEN
	}
	
	public CellMatlab[][] sysNum; //bud toto
	public CellMatlab[][] sysDen; // a toto
	
	public EsysType sysType; //alebo toto
	public String sysString; // a toto
	
	public TransferFcn(){
	}
	
	public TransferFcn(CellMatlab[][]  sysNum, 
				       CellMatlab[][]  sysDen,
					   EsysType  	sysType,
					   String	 	sysString){
		this.sysNum = sysNum;
		this.sysDen = sysDen;
		this.sysType = sysType;
		this.sysString = sysString;
	}
}
