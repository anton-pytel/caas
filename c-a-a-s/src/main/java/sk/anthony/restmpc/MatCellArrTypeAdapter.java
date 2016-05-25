package sk.anthony.restmpc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;


public class MatCellArrTypeAdapter extends TypeAdapter<CellMatlab[][]> {

        public void write(JsonWriter out, CellMatlab[][] value) throws IOException {
          if (value == null) {
            out.nullValue();
          } else {
            //out.value(); //zapis do json nezmeneny
        	value=null;
          }
        }
        
        private CellMatlab readCell(JsonReader in) throws IOException{
        	// parusujeme uz hodnotu CellMatlab 
	    	in.beginObject();
	    	in.nextName();
	    	List<Number> list = new ArrayList<Number>();
	    	try {
    	      in.beginArray(); //ak je jedna hodnota matlab nas odingoruje aj tu
    	    } catch (IllegalStateException e) {
    	    }
    	    while (in.hasNext()) {
    	    	double instance = in.nextDouble();
    	    	list.add(instance);
    	    }
    	    try {
      	      in.endArray();
      	    } catch (IllegalStateException e) {
      	    }
    	    in.endObject();
    	    double[] array = new double[list.size()];
    	    for (int i = 0; i< list.size(); i++ ) {
    	    	array[i] = (Double) list.get(i);
    	    }
    	    CellMatlab ldmat = new CellMatlab();
    	    ldmat.val = array;
    	    return ldmat; 
        }

        public CellMatlab[][] read(JsonReader in) throws IOException {
          if (in.peek() == JsonToken.NULL) {
            in.nextNull();
            return null;
          } else {
        	//ak je pole sprav double pole 
        	//ak je double pole, tak sprav double pole
    	    List<Object> rows = new ArrayList<Object>();
    	    int maxlist = 0;
    	    boolean isArray = true;
    	    try {
    	      in.beginArray(); //ak je jedna hodnota matlab nas odingoruje
    	    } catch (IllegalStateException e) {
    	    	isArray = false;
    	    }
    	    if (!isArray) {
    	    	List<Object> list = new ArrayList<Object>();
    	    	CellMatlab instance = readCell(in);
    	    	list.add(instance);
    	    	rows.add(list);
    	        if (maxlist<list.size()) {
    	        	maxlist=list.size();
    	        }    	    	
    	    } else {
	    	    do {
	        	    try {
	          	      in.beginArray(); //ak je jedna hodnota matlab nas odingoruje aj tu
	          	    } catch (IllegalStateException e) {
	          	    }
	    	    	List<Object> list = new ArrayList<Object>();
		    	    while (in.hasNext()) {
		    	    	// parusujeme uz hodnotu CellMatlab 
		    	    	CellMatlab instance = readCell(in);
		    	    	list.add(instance);
		    	    }
		    	    rows.add(list);
		    	    try {
		      	      in.endArray();
		      	    } catch (IllegalStateException e) {
		      	    	
		      	    }
		    	    
		    	    
	    	        if (maxlist<list.size()) {
	    	        	maxlist=list.size();
	    	        }
	    	    } while (in.hasNext());
	    	    try {
	    	      in.endArray();
	    	    } catch (IllegalStateException e) {
	    	    	
	    	    }
    	    }
    	    CellMatlab[][] array = new CellMatlab[rows.size()][maxlist];
    	    for (int i = 0; i< rows.size(); i++ ) {
	    	    for (int j = 0; j < maxlist; j++) {
	    	      @SuppressWarnings("unchecked")
				  ArrayList<Object> list = (ArrayList<Object>) rows.get(i);	
	    	      array[i][j]= (CellMatlab) list.get(j);
	    	    }
    	    }
    	    return array;         
          }
        }

}
