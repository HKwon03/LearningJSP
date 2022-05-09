<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file = "dbconn_oracle.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	int eno = Integer.parseInt(request.getParameter("eno"));
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	int manager = Integer.parseInt(request.getParameter("manager"));
	String hiredate = request.getParameter("hiredate");
	int salary = Integer.parseInt(request.getParameter("salary"));
	int commission = Integer.parseInt(request.getParameter("commission"));
	int dno = Integer.parseInt(request.getParameter("dno"));

	Statement stmt = null;
	
	try {
		String sql = "insert into emp_copy(eno, ename, job, manager, hiredate, salary, commission, dno) values(" + eno + ", '" + ename + "', '" + job + "',"+ manager + ", '" + hiredate + "', "+ salary+"," +commission+","+ dno+")";
				
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		
		out.println("테이블 삽입에 성공하였습니다.");	
		
		
	} catch (Exception e) {
		out.println("emp_copy 테이블 삽입을 실패 했습니다.");
		out.println(e.getMessage());
	} finally {
		if (stmt != null) 
			stmt.close();
		if (conn != null)
			conn.close();
	}

%>

</body>
</html>