<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>	<!-- 한글 처리 -->

<%@ include file = "dbconn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼의 값을 받아서 DataBase에 값을 넣어주는 파일</title>
</head>
<body>
<%
	// 폼에서 넘긴 변수를 받아서 저장.
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");

	int pos = 0;		
	if(cont.length() == 1) 
		cont = cont + " ";
	
	 //textarea 내에 ' 가 들어가면 DB에 insert, update시 문제 발생.
	
	
	while((pos = cont.indexOf("\'", pos)) != -1) {	// -1 : 값이 존재하지 않을 때
		String left = cont.substring (0,pos);
			// out.println("pos : " + pos + "<p>");
			// out.println("left : " + left + "<p>");
		
		String right = cont.substring(pos, cont.length());
			// out.println("right : " + right + "<p>");
		
		//cont = left + "\'" + right;
		pos += 2;
	}
	 
	// if(true) return;
	 
	
	// 오늘의 날짜 처리
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm:ss a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt = 0;		// Insert가 잘 되었는지 그렇지 않은지 확인하는 변수
	
	try {
		
		//값을 저장하기 전에 최신 글번호(max(id))를 가져와서 + 1 을 적용한다.
		//conn(Connection) : Auto commit; 이 작동된다.
			//commit을 명시하지 않아도 insert, update, delete 자동 커밋이 된다.
		
		
		
		sql = "INSERT INTO guestboard(name, email, inputdate, subject, content) values(?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, na);
		pstmt.setString(2, em);
		pstmt.setString(3, ymd);
		pstmt.setString(4, sub);
		pstmt.setString(5, cont);
		
		
		
		cnt = pstmt.executeUpdate(); 	//cnt > 0 : Insert 성공
		
		// out.println(sql);
		// if(true) return;	//
		
		
		if (cnt > 0) {
			out.println("데이터가 성공적으로 입력 되었습니다.");
		} else {
			out.println("데이터가 입력되지 않았습니다.");
		}
		
	} catch(Exception ex) {
		out.println(ex.getMessage()); 
	} finally {
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}

%>

<jsp:forward page = "dbgb_show.jsp" />  

</body>
</html>