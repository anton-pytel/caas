function setController(mpcid, key, value)
controller=getController(mpcid);
import com.mongodb.*;
import org.bson.types.*;
mongoClient = MongoClient('localhost', 27017);
db = mongoClient.getDB('caas-persist');
collection = db.getCollection('controllers');
controller.put(key, value);
collection.save(controller);
clear mongoClient;
clear db;
clear collection;
clear controller;
    

