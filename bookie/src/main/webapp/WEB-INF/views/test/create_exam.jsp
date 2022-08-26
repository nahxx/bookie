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
    <div class="container counts solve sub-pag">
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
                <input type="text" name="questionCount" class="selec num" placeholder="해당 유형 문제 수"/>
                <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/test/createExamSelectPattern'/>');" class="submit-btn search s">선택</a>
            </div>
        </div>
        <div class="questionPatternSelec-wrap">
            <c:forEach var="lineItem" items="${lineSubjectPatterns}">
                <div class="selec-subp">
                    <span class="selec-subp-wrap">
                        <span class="clevel">${lineItem.category.CLevel}</span><span class="gradE">${lineItem.category.grade}</span><span class="pattern-script">${lineItem.category.subject} > ${lineItem.subjectPattern.bigPattern} > ${lineItem.subjectPattern.midPattern}</span><span class="qNum">${lineItem.questionCount}문제</span>
                        <span class="cencel-btn-wrap"><a href="/bookie/test/createExam/${lineItem.subjectPattern.bigPattern}_${lineItem.subjectPattern.midPattern}" class="cencel-btn"><span class="cross-right"></span><span class="cross-left"></span></a></span>
                    </span>
                </div>
            </c:forEach>
        </div>
        <div class="nextBtn-wrap">
            <div class="totalCount">${totalQuestionCount}</div>
            <a href="/bookie/test/examSolve" class="submit-btn search solve nextBtn">시험시작</a>
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
        let mp = document.querySelector('#mPattern');
        for(let i = 0; i < mp.length; i++) {
            if(mp.options[i].value === "${midPattern}") {
                mp.options[i].selected = true;
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

    function sendPost(url) {

        //1. 폼생성
        var form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', url);
        document.charset = "UTF-8";

        // 대분류
        let s = document.getElementById("bPattern");
        let bp = s.options[s.selectedIndex].value;

        // 중분류
        let sub = document.getElementById("mPattern");
        let mp = sub.options[sub.selectedIndex].value;

        let input1 = document.createElement('input');
        input1.setAttribute('type', 'hidden');
        input1.setAttribute('name', 'bp');
        input1.setAttribute('value', bp);
        form.appendChild(input1);

        let input2 = document.createElement('input');
        input2.setAttribute('type', 'hidden');
        input2.setAttribute('name', 'mp');
        input2.setAttribute('value', mp);
        form.appendChild(input2);

        // 문제 수
        let questionCount = document.getElementsByClassName("num")[0];
        form.appendChild(questionCount);

        // 폼 추가
        document.body.appendChild(form);
        form.submit();
    }
    let c = document.getElementsByClassName("clevel");

    Array.prototype.forEach.call(c, (item, i) => {

        if(item.innerText == 'm') {

            item.innerText = '중학교';
        } else if(item.innerText == 'h') {
            item.innerText = '고등학교';
        }
    });
    let g = document.getElementsByClassName("gradE");

    Array.prototype.forEach.call(g, (item, i) => {

        if(item.innerText == '1') {
            item.innerText = '1학년';
        } else if(item.innerText == '2') {
            item.innerText = '2학년';
        } else if(item.innerText == '3') {
            item.innerText = '3학년';
        }
    });
    <c:if test="${questionDuplicate eq 'y'}">
        window.alert("${questionDuplicateException}");
    </c:if>
</script>
</body>
</html>
