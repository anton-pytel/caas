package sk.anthony;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;



/**
 * Root resource (exposed at "/mpccontrollers" path)
 */

@Path("/mpccontrollers")
public class JSONService {

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
    	MpcController lmc = xmc.storeMC(xmc);
        return lmc;
    }

    @GET
    @Path("/{mpcid}")
    @Produces(MediaType.APPLICATION_JSON)
    public MpcController ReadResource(@PathParam("mpcid") String mpcid) {
    	return (new MpcController()).getMC(mpcid);
    }
}
