<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>

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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<script type="text/javascript" src="/scripts/jquery.js"></script>
	<script type="text/javascript" src="https://prerelna1.pre.salesforce.com/canvas/sdk/js/28.0/canvas-all.js"></script>
	<script type="text/javascript" src="/sdk/js/cookies.js"></script>
    <script type="text/javascript" src="/sdk/js/oauth.js"></script>
    <script type="text/javascript" src="/sdk/js/xd.js"></script>
    <script type="text/javascript" src="/sdk/js/client.js"></script>
    <script type="text/javascript" src="/scripts/json2.js"></script>
    <script type="text/javascript">    	
   		 var j$ = jQuery.noConflict();
    	Sfdc.canvas(function(){
    		alert("Page loaded, libraries ready");
    		console.log("Page loaded, libraries ready");
    		
    		//set up message publisher event handler
    		j$("#btnSend").click(function(){
    			var message = j$("#msgbox").val();
    			var sr = JSON.parse('<%= jsonRequest%>');
        		Sfdc.canvas.client.publish(sr.client,
        		{name: "jrupreorg.message", payload: {message:message}});
    		});
    				
    	});   	
    </script>
</head>
<body>
<img src="comments.png" style="height:150px; width:150px; float: left"><h1>Publisher Application</h1>
	<div id="messageGenerator">
		<label for="msgbox">Please enter a message to send to subscribers</label><br/>
		<input type="text" id="msgbox"/>
		<input type="button" id="btnSend" value="Send Message"/>
	</div>
</body>
</html>