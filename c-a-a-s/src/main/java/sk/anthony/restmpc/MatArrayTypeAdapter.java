package sk.anthony.restmpc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

public class MatArrayTypeAdapter extends TypeAdapter<ArrayMatlab> {

        public void write(JsonWriter out, ArrayMatlab value) throws IOException {
          if (value == null) {
            out.nullValue();
          } else {
            //out.value(); //zapis do json nezmeneny
        	value=null;
          }
        }

        public ArrayMatlab read(JsonReader in) throws IOException {
          if (in.peek() == JsonToken.NULL) {
            in.nextNull();
            return null;
          } else {
        	//ak je pole sprav double pole 
        	//ak je double pole, tak sprav double pole
    	    int maxlist = 0;
    	    in.beginObject();
    	    in.nextName();
    	    List<Number> list = new ArrayList<Number>();
    	    while (in.hasNext()) {
    	      double instance = in.nextDouble();
    	      list.add(instance);
    	    }
    	    try {
      	      in.endArray();
      	    } catch (IllegalStateException e) {
      	    	
      	    }
	        if (maxlist<list.size()) {
	        	maxlist=list.size();
	        }
    	    in.endObject();
    	    double[] array = new double[maxlist];
    	    for (int i = 0; i< list.size(); i++ ) {
    	    	array[i]= (Double) list.get(i);
    	    }
    	    ArrayMatlab ldmat = new ArrayMatlab();
    	    ldmat.val = array;
    	    return ldmat;         
          }
        }

}
