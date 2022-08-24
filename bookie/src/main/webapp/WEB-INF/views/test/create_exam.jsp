<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookie</title>
    <link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/home/home.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/question/question_solve.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/test/test_page.css"/>" />
</head>
<body>
<div class="wrap sub">
    <header>
        <%@ include file="../incl/header.jsp"%>
    </header>
    <div class="container counts solve">
        <div class="category-wrap testcate">
            <form:form method="get" modelAttribute="category" action="/bookie/test/createExamSelectPattern">
                <form:select path="cLevel" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${categoryProviderList }" class="opt"/>
                </form:select>
                <form:select path="grade" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${gradeProviderList }" class="opt"/>
                </form:select>
                <form:select path="subject" class="selec">
                    <form:options itemValue="categoryHost" itemLabel="categoryCode" items="${subjectProviderList }" class="opt"/>
                </form:select>
                <input type="submit" value="카테고리 선택" class="submit-btn search solve"/>
            </form:form>
            <div class="subjectPattern-wrap">
                <select id='bPattern' name='bPattern' onChange='javascript:checkingMPattern(this);' class="selec">
                    <option value="unknown" class="opt">---대분류---</option>
                    ${bigTag}
                </select>
                <select id='mPattern' name='mPattern' class="selec">
                    <option value="unknown" class="opt">---중분류---</option>
                    ${midTag}
                </select>
                <input type="button" value="선택" class="submit-btn search"/>
            </div>
        </div>
    </div>
</div>
<footer id="footer">
    <%@ include file="../incl/footer.jsp"%>
</footer>
<script>
    <c:if test="${not empty category}">

        let bp = document.querySelector('#bPattern');
        for(let i = 0; i < bp.length; i++) {
            if(bp.options[i].value === "${bigPattern}") {
                bp.options[i].selected = true;
                break;
            }
        }
    </c:if>

    function checkingMPattern(value) {
        let sCheck = document.getElementById("bPattern");
        let bpCheck = sCheck.options[sCheck.selectedIndex].value;
        if(bpCheck == "unknown") {
            return alert("대분류를 선택해주세요.");
        }

        let url = "createExamSelectPattern_m";
        // 폼 생성
        let form = document.createElement('form');
        form.setAttribute('type', 'hidden');
        form.setAttribute('method', 'get');
        form.setAttribute('action', url);
        document.charset = "UTF-8";

        // 대분류
        let s = document.getElementById("bPattern");
        let bp = s.options[s.selectedIndex].value;

        let input1 = document.createElement('input');
        input1.setAttribute('type', 'hidden');
        input1.setAttribute('name', 'bp');
        input1.setAttribute('value', bp);
        form.appendChild(input1);

        // 폼 추가
        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>
