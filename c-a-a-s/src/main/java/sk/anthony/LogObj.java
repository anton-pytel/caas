package sk.anthony;

import java.util.Date;

public class LogObj {
    public Date created;
    public String msg;
    
    public LogObj(String msg){
    	this.created = new Date();
    	this.msg = msg;
    }
}
