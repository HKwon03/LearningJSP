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
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	try {
		sql = "select eno, ename from emp_copy where eno = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, eno);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			int rEno = rs.getInt("eno");
			String rEname = rs.getString("ename");
			
			if(ename.equals(rEname)) {
				sql = "update emp_copy set job = ?, manager = ?, hiredate = ?, salary = ?, commission = ?, dno = ? where eno = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, job);
				pstmt.setInt(2, manager);
				pstmt.setString(3, hiredate);
				pstmt.setInt(4, salary);
				pstmt.setInt(5, commission);
				pstmt.setInt(6, dno);
				pstmt.setInt(7, eno);
				pstmt.executeUpdate();
				out.println("잘 수정되었습니다.");
			} else {
				out.println("사원명이 일치하지 않습니다.");
			}

		} else {
			out.println("사원번호가 존재하지 않습니다.");
		}		
		
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}

%>

</body>
</html>