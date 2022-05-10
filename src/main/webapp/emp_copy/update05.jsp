<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form method = "post" action = "update05_process.jsp">
		<p> 사원번호	: <input type = "number" name = "eno">
		<p> 사원명	: <input type = "text" name = "ename">
		<p> 직책		: <input type = "text" name = "job">
		<p> 직속상관	: <input type = "number" name = "manager">
		<p> 입사일	: <input type = "number" name = "hiredate">
		<p> 월급		: <input type = "number" name = "salary">
		<p> 보너스	: <input type = "number" name = "commission">
		<p> 부서번호	: <input type = "number" name = "dno">
		<p> <input type = "submit" value = "전송">	
	
	</form>

</body>
</html>