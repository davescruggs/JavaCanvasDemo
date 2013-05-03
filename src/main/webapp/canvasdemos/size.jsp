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
	String consumerSecret = "6637537438082773090";
			
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
    		var size = Sfdc.canvas.client.size();
        	var sr = JSON.parse('<%= jsonRequest %>');
    		j$("#sizeBox").append(JSON.stringify(size));
        	
    		//resize action
        	j$("#btnResize").click(function(){
        		j$("#sizeBox").val('');
        		var height = j$("#newHeight").val();
        		var width = j$("#newWidth").val();
        		//create resize json
        		var resizejson = {height: height, width: width};
        		alert("Setting size " + resizejson);
        		Sfdc.canvas.client.resize(sr.client, resizejson);
        		var size = Sfdc.canvas.client.size();
        		j$("#sizeBox").val('<p>'+JSON.stringify(size)+'</p>');
        	});
    				
    	});   	
    </script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<img src="tools.png" style="height:125x; width:125px; float: left; margin-right:10px"><h1> Sizing Application</h1>
<div id="SCurrentSize">
	<span><label for="sizeBox">Current Canvas size:</label>
	<textarea id="sizeBox" rows="3" style="vertical-align:top; width: 50%; margin-bottom:15px;"></textarea></span>
</div>
<div id="sResize">
 	<label for="newWidth">New Width:</label>
 	<input type="text" id="newWidth">&nbsp; &nbsp;
 	<label for="newHeight">New Height:</label>
 	<input type="text" id="newHeight">
 	<input type="button" id="btnResize" value="Resize">
</div>

</body>
</html>