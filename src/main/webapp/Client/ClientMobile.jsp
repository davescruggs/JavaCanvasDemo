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
</head>
<body>

</body>
</html>