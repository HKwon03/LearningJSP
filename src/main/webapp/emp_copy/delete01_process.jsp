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
	ResultSet rs = null;
	String sql = null;
	
	try {
		sql = "select eno, ename from emp_copy where eno = '" + eno + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			int rEno = rs.getInt("eno");
			String rEname = rs.getString("ename");
			
			if (ename.equals(rEname)) {
				sql = "delete emp_copy where ename = '" + ename + "'";
				// out.println(sql);  sql 확인용
				stmt.executeUpdate(sql);
				
				out.println("테이블에서 해당 사원번호 : " + eno + " 가 잘 삭제되었습니다.");
				
			} else {
				out.println("사원명이 일치하지 않습니다.");	
			}

		} else {
			out.println("해당 사원번호는 존재하지 않습니다.");
		}
	
	} catch(Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (conn != null)
			conn.close();
	}

%>

</body>
</html>