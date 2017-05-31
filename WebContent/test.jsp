<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="conn.*" %>
<%@ page import="bean.TestBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//DB Connection
	TestPool testPool = new TestPool();

	//Vector
	Vector testList;
	
	//Parameter: Test_no
	String test_no;
	test_no=request.getParameter("test_no"); //request객체로 넘어온 Test_no를 받음 - 정상!
	testList = testPool.getTestList(test_no); //test_no를 넣으면 그 test에 대한 정보가 testList에 저장됨
	TestBean testBean = (TestBean)testList.get(0); //Test_no에 해당하는 Test는 오직 하나 (0)
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= testBean.getTest_name()%> 자가진단</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js" ></script>
<script type="text/javascript" src="/script.js"></script>
<script type="text/javascript">

//결과보기 버튼을 누르면 결과가 나오는 스크립트
$(function(){
  $('.btn_show').click(function(){
    $('.btn_word').show();
  });
});

//자가진단 체크 개수를 알아내는 스크립트
function checkCount(obj) {
    var sum = 0;
    var count = document.form1.checkbox.length;
    for(var i=0; i < count; i++ ){
        if( document.form1.checkbox[i].checked == true ){
            sum += 1;
        }
    }
    document.getElementById("hidden_result").value=sum; //보낼값
    var result = document.getElementById("result");
    if (sum>obj) result.innerHTML="조심하셔야겠어요!"; else result.innerHTML="아직은 괜찮아요!";
}
</script>
</head>
<body>

<!--
Test 페이지

0. testMenu.jsp에서 test.jsp?test_no=___ 를 링크 누른다.
1. 누른 TEST에 해당하는 Test_no를 받아온다
2. Test_no에 해당하는 DB 레코드를 가져와서 뿌린다.
 - Test_name : Title, h1 (페이지 제목 Test_name), 테스트 리스트(Checklist), 테스트 설명 (Description), 심각성 기준값 (Count)
 - 뿌릴때 resultset을 DBConnector에서 받아서, 자바빈에 set
 - 제목: 자바빈에서 get해서 html에 뿌림
 - 체크리스트: 자바빈에서 get한다음 token (;)으로 나눠서 배열에 넣은다음 반복문으로 createElement, checkbox
 - 결과보기버튼: jquery로 더보기 버튼 구현
3. 결과보기 버튼을 누르면
 - Element가 hide되어있다가 더보기를 누르면 show 하는 자바스크립트를 실행한다
 - 결과표시: Description
 - 심각성진단: if(Check한 갯수가 Count보다 많다) 조심하셔야 합니다! else 아직은 나쁘지 않아요!
 - test_done 테이블에 올리기 : Mem_no, Test_no, Result(몇개 선택했는가) 를 insert하는 쿼리 실행
4. 결과보기 밑에
 - 동영상으로 가는 링크: test에 해당하는 (SELECT~WHERE) video 주소를 넘김 -> video.jsp
-->

<!-- article 시작 -->
<div class="article">
	<form name="form1">
		<h1><%= testBean.getTest_name() %></h1><br>
		<hr>
		해당되는 증상을 체크하고 결과보기를 눌러 내 상태를 진단해보세요!
		<div id="checklist">
			<%
				String[] checklist=testBean.getChecklist().split(";"); //체크리스트
				for(int i=0;i<checklist.length;i++){
			%>
			<input type="checkbox" name="checkbox" class="checkbox"><%=checklist[i]%><br>
			<%
				}
			%>
		</div>
		<br>
	
		<input type="button" class="btn_show" style="padding:3px" onclick="checkCount(<%= testBean.getCount() %>)" value="결과보기">
	</form>
<!-- 결과보기를 누르면 나오는 곳 -->
	<form action="testSubmit.jsp" method="get" name="form_test">
		<div class="btn_word" hidden="hidden">
			<h2><span id="result"></span></h2>
			<br><><br>
			<%= testBean.getDescription() %><br>
			<input type="hidden" id="hidden_result" name="result">
			<input type="hidden" name="test_no" value="<%= testBean.getTest_no()%>">
			<input type="submit" id="hidden_submit" value="결과 저장 후 동영상 보러가기">
		</div>
	</form>
</div>
<!-- article 끝 -->
</body>
</html>