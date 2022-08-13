<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	request.setCharacterEncoding("UTF-8");
	StringBuilder sbHtml = new StringBuilder();

	sbHtml.append("{");
	sbHtml.append("\"result\": true,");
	sbHtml.append("\"data\": {");
	sbHtml.append("\"contents\": [{\"name\":\"박동근\", \"type\": \"B\", \"genre\": \"d\"}, {\"name\":\"박동근\", \"type\": \"B\", \"genre\": \"d\"}, {\"name\":\"박동근\", \"type\": \"B\", \"genre\": \"d\"}],");
	sbHtml.append("\"pagination\": {");
	sbHtml.append("\"page\": 1,");
	sbHtml.append("\"totalCount\": 100");
	sbHtml.append("}");
	sbHtml.append("}");
	sbHtml.append("}");
	
	out.println(sbHtml);
%>