package sk.anthony.restmpc;

import com.google.gson.Gson;
import com.google.gson.TypeAdapter;
import com.google.gson.TypeAdapterFactory;
import com.google.gson.reflect.TypeToken;

public class ArraysTypeAdapterFactory implements TypeAdapterFactory {
	
	
	@Override
	public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
	    if (type.getRawType() != ArrayMatlab.class && type.getRawType() != DoubleArrayMatlab.class ){
	    	return null;
	    }
	    return null;
	}

}
