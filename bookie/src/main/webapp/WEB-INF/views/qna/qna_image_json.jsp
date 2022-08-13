<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	request.setCharacterEncoding("UTF-8");

	String url = (String)request.getAttribute("url");
	String filename = (String)request.getAttribute("filename");

	StringBuilder sbHtml = new StringBuilder();
	
	sbHtml.append("{");
	sbHtml.append("\"url\" : \""+url+"\",");
	sbHtml.append("\"filename\" : \""+filename+"\"");
	sbHtml.append("}");

	out.println(sbHtml);
%>