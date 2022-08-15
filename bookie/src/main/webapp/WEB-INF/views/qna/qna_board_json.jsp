<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	request.setCharacterEncoding("UTF-8");
	StringBuilder sbHtml = new StringBuilder();
String name = "박동근";
String type = "ㅁ";
String genre = "ㅁ";
	sbHtml.append("{");

	sbHtml.append("\"name\" : \""+name+"\",");
	sbHtml.append("\"type\" : \""+type+"\"");
	sbHtml.append("\"genre\" : \""+genre+"\"");
	sbHtml.append("}");
	
	out.println(sbHtml);
%>