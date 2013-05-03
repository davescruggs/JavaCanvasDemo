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
	String consumerSecret = "2375073284614232409";
	String jsonRequest = SignedRequest.verifyAndDecodeAsJson(sRequest[0], consumerSecret);
%>
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
    Sfdc.canvas(function() {
    	sr = JSON.parse('<%=jsonRequest%>');
    	
    	//subrcribe event handler
    	j$("#mSubscribe").click(function(){
    		alert("subscribed")
	    	Sfdc.canvas.client.subscribe(sr.client,
	    	{name : "jrupreorg.message", onData : function (event) {
	    		j$("#rMsgBox").append("<li>"+event.message+"</li>");
	    	}});
    	});
    	
    	//unsubscribe event handler
    	j$("#mUnSubscribe").click(function(){
    		alert("unsubscribed");
    		Sfdc.canvas.client.unsubscribe(sr.client,{name: "jrupreorg.message"});
    	});
    });
    </script>
    
</head>
<body>
<img src="headset2.png" style="height:150px; width:150px; float:left;"><h1>Subscriber Application</h1>
<div id="msgReceiver">
	<label for="rMsgBox">Messages received:</label>
	<OL id ="rMsgBox"></OL>
</div>
<div id="buttonRow">
	<input type="button" id="mSubscribe" value="Subscribe to Publisher"/>
	<input type="button" id="mUnSubscribe" value="Unsubscribe to Publisher"/>
</div>
</body>
</html>