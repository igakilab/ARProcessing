import com.mongodb.*;
import com.mongodb.annotations.*;
import com.mongodb.assertions.*;
import com.mongodb.async.*;
import com.mongodb.binding.*;
import com.mongodb.bulk.*;
import com.mongodb.client.*;
import com.mongodb.client.gridfs.*;
import com.mongodb.client.gridfs.codecs.*;
import com.mongodb.client.gridfs.model.*;
import com.mongodb.client.model.*;
import com.mongodb.client.model.geojson.*;
import com.mongodb.client.model.geojson.codecs.*;
import com.mongodb.client.result.*;
import com.mongodb.connection.*;
import com.mongodb.connection.netty.*;
import com.mongodb.diagnostics.logging.*;
import com.mongodb.event.*;
import com.mongodb.gridfs.*;
import com.mongodb.internal.*;
import com.mongodb.internal.async.*;
import com.mongodb.internal.authentication.*;
import com.mongodb.internal.connection.*;
import com.mongodb.internal.management.jmx.*;
import com.mongodb.internal.thread.*;
import com.mongodb.internal.validator.*;
import com.mongodb.management.*;
import com.mongodb.operation.*;
import com.mongodb.selector.*;
import com.mongodb.util.*;
import org.bson.*;
import org.bson.assertions.*;
import org.bson.codecs.*;
import org.bson.codecs.configuration.*;
import org.bson.conversions.*;
import org.bson.diagnostics.*;
import org.bson.io.*;
import org.bson.json.*;
import org.bson.types.*;
import org.bson.util.*;

MongoClient mongoClient = new MongoClient("150.89.234.253", 27018);

MongoDatabase database = mongoClient.getDatabase("artest");


MongoCollection<Document> collection = database.getCollection("sample");

Document doc = new Document("name", "MongoDB")
               .append("type", "darabase")
               .append("count", 1)
               .append("info", new Document("x", 203).append("y", 102));
           
collection.insertOne(doc);

int x = 10;
int i = 1;

for (Document cur : collection.find()) {
    System.out.println(cur.toJson());
    text(cur.toJson(), 50, 50+i*x);
    i++;
}

mongoClient.close();

  
  size(640, 480);