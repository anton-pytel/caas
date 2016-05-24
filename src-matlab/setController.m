function setController(mpcid, key, value)
javaaddpath 'c:\Program Files\MATLAB\R2015a\java\jar\mongo-java-driver-3.2.2.jar';
import com.mongodb.*;
import org.bson.types.ObjectId;
controller=getController(mpcid);
mongoClient = MongoClient('localhost', 27017);
db = mongoClient.getDB('caas-persist');
collection = db.getCollection('controllers');
controller.put(key, value);
collection.save(controller);
clear mongoClient;
clear db;
clear collection;
clear controller;
    

