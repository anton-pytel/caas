package sk.anthony.restmpc;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;

import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;



/**
 * Root resource (exposed at "/mpccontrollers" path)
 */

@Path("/mpccontrollers")
public class JSONService extends ResourceConfig  {

   public JSONService() 
    {
        register(LoggingFilter.class);
        register(GsonMessageBodyHandler.class);
    }
	
    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public MpcController CreateResource(MpcController xmc) {
    	xmc = xmc.store2Mongo(xmc);
    	xmc = xmc.runMatlab(xmc);
    	xmc = xmc.update2Mongo(xmc);
        return xmc;
    }

    @GET
    @Path("/{mpcid}")
    @Produces(MediaType.APPLICATION_JSON)
    public MpcController ReadResource(@PathParam("mpcid") String mpcid) {
    	return (new MpcController()).getMC(mpcid);
    }
}