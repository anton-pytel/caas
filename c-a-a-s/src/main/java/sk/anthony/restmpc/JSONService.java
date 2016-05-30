package sk.anthony.restmpc;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
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
    public MpcController CreateCtrl(MpcController xmc) {
    	xmc.init();
    	xmc.store2Mongo();
    	xmc = xmc.runMatlab(xmc, xmc.MATLAB_CONTROLLER);
    	xmc.afterMatlab();
    	xmc.update2Mongo();
        return xmc;
    }

    @GET
    @Path("/{mpcid}")
    @Produces(MediaType.APPLICATION_JSON)
    public MpcController ReadCtrl(@PathParam("mpcid") String mpcid) {
    	return (new MpcController()).getMC(mpcid);
    }

    /*
     *  Create Resource for step of control
     */
    @POST
    @Path("/{mpcid}/steps")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public ControllerStep CreateStep(@PathParam("mpcid") String mpcid, ControllerStep xStep) {
    	MpcController mc = new MpcController().getMC(mpcid);
    	if (mc != null) {
    		xStep = xStep.init(xStep, mc);
    		return xStep;
    	}
    	Response.status(Response.Status.NO_CONTENT);
        return null;
    }
    
    /*
     *  Get Resource for step of control
     */
    @GET
    @Path("/{mpcid}/steps/")
    @Produces(MediaType.APPLICATION_JSON)
    public ControllerStep[] ReadSteps(@PathParam("mpcid") String mpcid) {
    	MpcController mc = new MpcController().getMC(mpcid);
    	ControllerStep[] cs = mc.getSteps();
    	if (cs == null) {
    		Response.status(Response.Status.NO_CONTENT);
    	}
    	return cs;
    }

    /*
     *  Get Resource for step of control
     */
    @GET
    @Path("/{mpcid}/steps/{stepid}")
    @Produces(MediaType.APPLICATION_JSON)
    public ControllerStep ReadStep(@PathParam("mpcid") String mpcid, 
    							   @PathParam("stepid") Double stepid) {
    	MpcController mc = new MpcController().getMC(mpcid);
    	ControllerStep cs = mc.getStep(stepid);
    	if (cs == null) {
    		Response.status(Response.Status.NO_CONTENT);
    	}
    	return cs;
    }
}
