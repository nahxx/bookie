<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <title>QNA - 쓰기</title>
  <!-- 디자인 수정용 CSS 추가 -->
  <link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" />
  <link rel="stylesheet" href="<c:url value="/resources/css/footer.css"/>" />
  <link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>" />
  <link rel="stylesheet" href="<c:url value="/resources/css/qna/write.css"/>" />

  <!-- jQuery CDN -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <!-- TOAST UI Editor CDN URL(CSS) -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <!-- TOAST UI Editor CDN URL(JS) -->
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
</head>

<body>
  <header>
    <%@ include file="../incl/header.jsp"%>
  </header>
  <div class="mh">
    <div class="table-wrap">
      <div class="title-wrap">
        <h3 class="title">QNA작성</h3>
      </div>
      <div class="cate-wrap">
        <div class="cate-inner">
          <span class="stitle">레벨 : </span>
          <input type="radio" id="middle" name="level" value="m"><label for="middle">중등</label>
          <input type="radio" id="high" name="level" value="h"><label for="high">고등</label>
        </div>
        <div class="cate-inner">
          <span class="stitle">학년 : </span>
          <input type="radio" id="one" name="grade" value="1"><label for="one">1학년</label>
          <input type="radio" id="two" name="grade" value="2"><label for="two">2학년</label>
          <input type="radio" id="three" name="grade" value="3"><label for="three">3학년</label>
        </div>
        <div class="cate-inner">
          <span class="stitle">과목 : </span>
          <input type="radio" id="korean" name="subject" value="국어"><label for="korean">국어</label>
          <input type="radio" id="english" name="subject" value="영어"><label for="english">영어</label>
          <input type="radio" id="math" name="subject" value="수학"><label for="math">수학</label>
          <input type="radio" id="etc" name="subject" value="기타"><label for="etc">기타</label>
        </div>
      </div>
    </div>
    <div class="content">
      <div class="content-inner">
        <p class="mini-header">제목</p>
        <input type="text" class="qnaTitle" id="qnaTitle" name="qnaTitle" placeholder="제목을 입력하세요.">
        <p class="mini-header">내용</p>
        <div id="editor"></div>
        <div class="write-btn">
          <a href="javascript:void(0);" onclick="javascript:sendPost('<c:url value='/add_qna'/>');" class="in-btn">글쓰기</a>
          <a href="<c:url value='/qna_board/${pagingNo}'/>" class="in-btn">취소</a>
        </div>
      </div>
    </div>
  </div>
  <footer id="footer">
    <%@ include file="../incl/footer.jsp"%>
  </footer>
  <!-- TOAST UI Editor 생성 JavaScript 코드 -->
  <script>
  let qnaImgArr = [];
  
    const editor = new toastui.Editor({
      el: document.querySelector('#editor'),
      previewStyle: 'tab',
      initialEditType: "markdown",
      previewHighlight: false,
      height: '500px',
      hooks: {
        addImageBlobHook: (blob, callback) => {
          const formData = new FormData();
          formData.append('image', blob);

          let url;
          $.ajax({
            type: 'POST',
            enctype: 'multipart/form-data',
            url: '/bookie/qna_write',
            data: formData,
            dataType: "json",
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function(data) {
              url = Object.values(data)[0] + Object.values(data)[1];
              qnaImgArr.push(Object.values(data)[1]);
              callback(url, '이미지');
            },
            error: function(e) {
              callback(url, '이미지등록 오류 발생!!');
            }
          });
        }
      }
    });

    function sendPost(url) {
      //1. 폼생성
      var form = document.createElement('form');
      form.setAttribute('method', 'post');
      form.setAttribute('action', url);
      document.charset = "UTF-8";

      //2. 제목 input Tag 가져오기
      let qnaTitle = document.getElementById('qnaTitle');
      qnaTitle.setAttribute('type', 'hidden');
      form.appendChild(qnaTitle);

      //3. 에디터 안에 있는 html 전체 가져오기
      var getHtml = editor.getHTML();

      //4. 변수 넘겨주는 hidden input tag 만들어서 에디터 안에 있는 콘
      var hf_1 = document.createElement('input');
      hf_1.setAttribute('type', 'hidden');
      hf_1.setAttribute('name', "content");
      hf_1.setAttribute('value', getHtml);
      form.appendChild(hf_1);

      //5. 라디오버튼으로 카테고리 선택한 값을 hiddenfrom으로 값 던져주기.
      let level = document.querySelector('input[name="level"]:checked').value;
      let grade = document.querySelector('input[name="grade"]:checked').value;
      let subject = document.querySelector('input[name="subject"]:checked').value;

      var hf_2 = document.createElement('input');
      hf_2.setAttribute('type', 'hidden');
      hf_2.setAttribute('name', "level");
      hf_2.setAttribute('value', level);
      form.appendChild(hf_2);

      var hf_3 = document.createElement('input');
      hf_3.setAttribute('type', 'hidden');
      hf_3.setAttribute('name', "grade");
      hf_3.setAttribute('value', grade);
      form.appendChild(hf_3);

      var hf_4 = document.createElement('input');
      hf_4.setAttribute('type', 'hidden');
      hf_4.setAttribute('name', "subject");
      hf_4.setAttribute('value', subject);
      form.appendChild(hf_4);
	  
      var hf_5 = document.createElement('input');
      hf_5.setAttribute('type', 'hidden');
      hf_5.setAttribute('name', "qnaImgArr");
      hf_5.setAttribute('value', qnaImgArr);
      form.appendChild(hf_5);
      
      document.body.appendChild(form);
      form.submit();
    };
  </script>
</body>

</html>