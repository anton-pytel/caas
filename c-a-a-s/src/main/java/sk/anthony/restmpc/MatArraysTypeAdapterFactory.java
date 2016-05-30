package sk.anthony.restmpc;


import com.google.gson.Gson;
import com.google.gson.TypeAdapter;
import com.google.gson.TypeAdapterFactory;
import com.google.gson.reflect.TypeToken;

public class MatArraysTypeAdapterFactory implements TypeAdapterFactory {
	
	
	@SuppressWarnings("unchecked")
	public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
	    if (type.getRawType() == DoubleArrayMatlab.class){
	    	return (TypeAdapter<T>) new DoubleMatArrayTypeAdapter();
	    } else if (type.getRawType() == ArrayMatlab.class ) {
	    	return (TypeAdapter<T>) new MatArrayTypeAdapter();	    	
	    } else if (type.getRawType() == CellMatlab[][].class ) {
	    	return (TypeAdapter<T>) new MatCellArrTypeAdapter();
	    }	    
	    else {
	    	return null;
	    }
	    
	    	
	}
	
	 
}

