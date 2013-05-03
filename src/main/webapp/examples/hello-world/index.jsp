<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%@ page import="canvas.CanvasContext" %>
<%@ page import="canvas.CanvasRequest" %>
<%
    // Pull the signed request out of the request body and verify/decode it.
    Map<String, String[]> parameters = request.getParameterMap();
    String[] signedRequest = parameters.get("signed_request");
    if (signedRequest == null) {%>
        This App must be invoked via a signed request!<%
        return;
    }
    String yourConsumerSecret=System.getenv("CANVAS_CONSUMER_SECRET");
    //String yourConsumerSecret="1818663124211010887";
    String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
	CanvasRequest cRequest = SignedRequest.verifyAndDecode(signedRequest[0], yourConsumerSecret);
	CanvasContext cContext = cRequest.getContext();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Example</title>

    <link rel="stylesheet" type="text/css" href="/sdk/css/canvas.css" />

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>
	<script type="text/javascript" src="/scripts/jquery.js"></script>
    <script>
        var $j = jQuery.noConflict();
    	if (self === top) {
            // Not in Iframe
            alert("This canvas app must be included within an iframe");
        }

        Sfdc.canvas(function() {
            var sr = JSON.parse('<%=signedRequestJson%>');
            // Save the token
            Sfdc.canvas.oauth.token(sr.oauthToken);
            Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            var chatterUsersUrl = sr.context.links.chatterUsersUrl;
            showUrls(chatterUsersUrl);
        });
		
        function showUrls(url){
        	$j("#url").append("Chatter URL: " + url);
        }
    </script>
</head>
<body>
    <br/>
    <h1>Hello <span id='username'></span></h1>You da man!
	<h1><%= cContext.getUserContext().getEmail() %></h1>
	Rest URL = <%= cContext.getLinkContext().getRestUrl()
	%>
	<br/><h2>OAuth token=<%=cRequest.getClient().getOAuthToken() %></h2>
	
	<div id="url">
		
	</div>
	<div id="message">
		
	</div>
	<div id="contactsSection">
	
	<button id="contactGet" value="Get Contacts"></button>
	</div>
</body>
</html>
