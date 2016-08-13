function [controller]=getController(mpcid)
javaaddpath 'c:\Program Files\MATLAB\R2015a\java\jar\mongo-java-driver-3.2.2.jar';
import com.mongodb.*;
import org.bson.types.*;
mongoClient = MongoClient('localhost', 27017);
db = mongoClient.getDB('caas-persist');
collection = db.getCollection('controllers');
query = BasicDBObject('_id', ObjectId(mpcid));

doc = collection.find(query);
if doc.hasNext() 
   controller = doc.next();
else
    json = '';
end 
clear mongoClient;
clear db;
clear collection;
clear query;
clear doc;
    

