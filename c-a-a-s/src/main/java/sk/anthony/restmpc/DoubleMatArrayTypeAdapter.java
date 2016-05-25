package sk.anthony.restmpc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

public class DoubleMatArrayTypeAdapter extends TypeAdapter<DoubleArrayMatlab> {

        public void write(JsonWriter out, DoubleArrayMatlab value) throws IOException {
          if (value == null) {
            out.nullValue();
          } else {
            //out.value(); //zapis do json nezmeneny
        	value=null;
          }
        }

        public DoubleArrayMatlab read(JsonReader in) throws IOException {
          if (in.peek() == JsonToken.NULL) {
            in.nextNull();
            return null;
          } else {
        	//ak je pole sprav double pole 
        	//ak je double pole, tak sprav double pole
    	    List<Object> rows = new ArrayList<Object>();
    	    int maxlist = 0;
    	    in.beginObject();
    	    in.nextName();
    	    try {
    	      in.beginArray();
    	    } catch (IllegalStateException e) {
    	    	
    	    }
    	    do {
        	    try {
          	      in.beginArray();
          	    } catch (IllegalStateException e) {
          	    	
          	    }
    	    	List<Number> list = new ArrayList<Number>();
	    	    while (in.hasNext()) {
	    	      double instance = in.nextDouble();
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
    	    in.endObject();
    	    double[][] array = new double[rows.size()][maxlist];
    	    for (int i = 0; i< rows.size(); i++ ) {
	    	    for (int j = 0; j < maxlist; j++) {
	    	      @SuppressWarnings("unchecked")
				  ArrayList<Number> list = (ArrayList<Number>) rows.get(i);	
	    	      array[i][j]= (Double) list.get(j);
	    	    }
    	    }
    	    DoubleArrayMatlab ldmat = new DoubleArrayMatlab();
    	    ldmat.val = array;
    	    return ldmat;         
          }
        }

}
