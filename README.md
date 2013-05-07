#Canvas Demo for Summer 13 Force.com New Features Webinar#

## Setup instructions ##

###There are three components that can be used in this demo.###
1.	Message publisher
2.	Message subscribes
3.	Canvas resizer

In order to run the demo you will need a pre-release org instance. It’s highly recommended that you use a Developer Edition (DE) instance as some of the other features of Canvas won’t be available unless you use a DE instance. You'll also have to create a few connected applications to include the application components but you'll need to research that on your own if you're unfamiliar with the concept.
There are two main citizens of this demo you will need. One requires a bit of extra effort, explained below. The first and simplest is the Visualforce page containing the Canvas components, the second and more detailed is the Java application containing the modules to be exposed in the Visualforce Canvas components.

###Getting the Java Application and making changes###
Currently the application is hosted on GitHub. You can clone or fork it from there. To clone it, make a new application directory on your local machine, open a command prompt at enter the following command

`$git clone git@github.com:rupton/JavaCanvasDemo.git`

Once the application is downloaded you can open its contents with your favorite editor. The main files you’ll work with are in the directory /src/main/webapp/canvasdemos.  
1. app1.jsp  
2. app2.jsp  
3. size.jsp  

In all three of these you will notice a scriplet at the top of the page 

    <%
	    //get signedrequest from Salesforce
		Map<String, String[]> parameters = request.getParameterMap();
		String[] sRequest = parameters.get("signed_request");
		if(sRequest == null){%>You must run this app in a Canvas<%	
		return;
		}	
		//only hard coded for demo purposes
		String consumerSecret = "8773966858026744077";
		String jsonRequest = SignedRequest.verifyAndDecodeAsJson(sRequest[0], consumerSecret);
    %>


You'll need to replace consumerSecret with the consumerSecret of the connected app you've created in your pre-release instance for each of these pages. 
That's the only change you **have** to make to the application, of course you are free to make any change that you *want* to make.

##Creating the Visualforce page##
The final step (other than creating connected applications explained above) is creating the visual force page. Here is the code from the page I created to use as a referece.

    <div id="msgapp1" style="border:solid blue 2px; margin-bottom: 10px;">
    <apex:canvasApp applicationName="msgapp1"
     height="250px" width="750px"/>
    </div>  

    <div id="msgapp2" style="border:solid blue 2px; margin-bottom: 10px;">
	<apex:canvasApp applicationName="msgapp2"
     height="250px" width="750px"/>
	</div>  

	<div id="sizeApp" style="border:solid blue 2px; margin-bottom: 10px;">
    <apex:canvasApp applicationName="sizingapp"
     height="250px" width="750px" scrolling="true"/>
    </div>`

Of course you will need to change the applicationName attribute to whatever you called your connected app.

You can run the Java app locally (localhost) or push it to Heroku. If you run it somewhere other than localhost remember you will have to use https in your urls.

