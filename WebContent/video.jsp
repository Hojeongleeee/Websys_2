<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="conn.*, bean.TestBean, java.sql.*, java.util.*" %>
<%
	TestBean testBean = new TestBean();
	TestPool testPool = new TestPool();
	String test_no=request.getParameter("test_no");
	ResultSet rs = null;
	Vector testList=testPool.getTestList(test_no);
	testBean = (TestBean)testList.get(0);
	String videoURL = testBean.getVideoURL();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= testBean.getTest_name() %> - 동영상 보기</title>
</head>
<body>

<div class="article">
	<h1><%= testBean.getTest_name() %> 동영상 보며 따라하기</h1>
	<iframe width="854" height="480" src="https://www.youtube.com/embed/<%= videoURL %>" frameborder="0"></iframe>
</div>

</body>
</html>