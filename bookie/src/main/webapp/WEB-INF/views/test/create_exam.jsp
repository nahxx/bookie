<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookie</title>
    <link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/home/home.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/question/question_solve.css"/>" />
</head>
<body>
<div class="wrap sub">
    <header>
        <%@ include file="../incl/header.jsp"%>
    </header>
    <div class="container counts solve">
        <div class="category-wrap">
            <form:form method="get" modelAttribute="category" action="/bookie/question/solveProblem">
                <form:select path="cLevel" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${categoryProviderList }" class="opt"/>
                </form:select>
                <form:select path="grade" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${gradeProviderList }" class="opt"/>
                </form:select>
                <form:select path="subject" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${subjectProviderList }" class="opt"/>
                </form:select>
                <input type="submit" value="문제풀기" class="submit-btn search solve"/>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
