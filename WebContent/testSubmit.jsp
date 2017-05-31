<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="conn.*, bean.TestDoneBean, java.sql.*, java.util.*" %>
<%  
	//DB Connection
	request.setCharacterEncoding("UTF-8");
	TestDonePool testDonePool = new TestDonePool();

	//request 받기 (get방식 parameter)
//	String mem_no = session.getAttribute("mem_no").toString();//현재 세션의 mem_no 속성의 값
	int mem_no = Integer.parseInt("123"); //임시
	int test_no = Integer.parseInt(request.getParameter("test_no"));
	int result = Integer.parseInt(request.getParameter("result"));
		
	//query 실행 메소드
	testDonePool.setTestDoneList(test_no, mem_no, result);

	//동영상으로 바로 이동 redirect
	response.sendRedirect("./video.jsp?test_no="+test_no);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자가진단 결과 Submit</title>
</head>
<body>
</body>
</html>