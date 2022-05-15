<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "dbconn_oracle.jsp" %>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬럼의 특정 레코드를 읽는 페이지</title>
</head>
<body>
<center>
<%
	Vector name=new Vector();			//DB의 Name 값만 저장하는 벡터
	Vector email=new Vector();
	Vector inputdate=new Vector();	
	Vector subject=new Vector();
	Vector content=new Vector();	

	 // 페이징 처리 시작 부분
	  
	  int where=1;

	  int totalgroup=0;			// 출력할 페이징의 그룹핑의 최대 갯수
	  int maxpages=2;			// 최대 페이지 갯수(화면에 출력될 페이지 갯수)
	  int startpage=1;			// 처음 페이지
	  int endpage=startpage+maxpages-1;	// 마지막 페이지
	  int wheregroup=1;			// 현재 위치하는 그룹
	  
	  
		// go : 해당 페이지 번호로 이동.
		// freeboard_list.jsp?go=3
		// gogroup : 출력할 페이지의 그룹핑
		// freeboard_list.jsp?gogroup=2	(전체글수34, maxpage가 5일때 6, 7, 8, 9, 10)
		
		// go 변수 (페이지 번호) 를 넘겨 받아서 wheregroup, startpage,endpage 정보의 값을 알아낸다.
		
	  if (request.getParameter("go") != null) {		// go 변수의 값을 가지고 있을 때
	   where = Integer.parseInt(request.getParameter("go"));	// 현재 페이지 번호를 담은 변수
	   wheregroup = (where-1)/maxpages + 1;		// 현재 위치한 페이지의 그룹
	   startpage=(wheregroup-1) * maxpages+1;  
	   endpage=startpage+maxpages-1; 
	   
	  // gogroup 변수를 넘겨받아서 startpage, endpage, where(페이지 그룹의 첫번째 페이지)
	  } else if (request.getParameter("gogroup") != null) {	// gogroup 변수의 값을 가지고 올 때
	   wheregroup = Integer.parseInt(request.getParameter("gogroup"));
	   startpage=(wheregroup-1) * maxpages+1;  
	   where = startpage ; 
	   endpage=startpage+maxpages-1; 
	  }
	  
	  
	  
	  int nextgroup=wheregroup+1;		//다음 그룹 : 현재 그룹 + 1
	  int priorgroup= wheregroup-1;		//이전 그룹 : 현재 그룹 - 1

	  int nextpage=where+1;			//다음 페이지 : 현재 페이지 + 1			
	  int priorpage = where-1;		//이전 페이지 : 현재 페이지 - 1
	  int startrow=0;			//하나의 page에서 레코드 시작 번호
	  int endrow=0;				//하나의 page에서 레코드 마지막 번호
	  int maxrows=2;				// 출력할 레코드 수
	  int totalrows=0;			//총 레코드 갯수
	  int totalpages=0;			//총 페이지 갯수
	  
	  // 페이징 처리 마지막 부분



	String sql = null;
	String em = null;
	PreparedStatement pstmt= null;
	ResultSet rs = null;
	
	// String ind = request.getParameter("inputdate");
	
	// out.println(ind + "<p>");
	
	// if(true) return;	// 프로그램을 여기서 멈춤.(디버깅 시에 많이 사용)
	
	try {
		sql = "select * from guestboard order by inputdate desc";
		pstmt = conn.prepareStatement(sql);
		// pstmt.setString(1, ind);
		rs = pstmt.executeQuery();
		
		
		if(!(rs.next())) {	// 값이 존재하지 않는 경우
			out.println("데이터베이스에 해당 내용이 없습니다.");
		} else {			// 값이 존재하는 경우, rs 의 값들을 화면에 출력
			
			em = rs.getString("email");
			if((em != null) && (!(em.equals(" ")))) {	//DB의 email 컬럼의 값이 존재하면
				em = "<A href = mailto:" + em + ">" + rs.getString("name") + "</A>";
			} else {	//메일 주소의 값이 비어있을 때 이름만 출력
				em = rs.getString("name");
			}
			
	 		do {
			    name.addElement(rs.getString("name"));
			    email.addElement(rs.getString("email"));
			    inputdate.addElement(rs.getString("inputdate"));
			    subject.addElement(rs.getString("subject"));
			    content.addElement(rs.getString("content"));
	 		} while(rs.next());
	 		
	 		totalrows = inputdate.size();			// name vector에 저장된 값의 갯수, 총 레코드 수
	 		totalpages = (totalrows-1)/maxrows +1;
	 		startrow = (where-1) * maxrows;			//현재 페이지에서 시작 레코드 번호
	 		endrow = startrow+maxrows-1  ;			//현재 페이지에서 마지막 레코드 번호
	 		   
	 		   
	 		if (endrow >= totalrows)
	 		endrow=totalrows-1;
	 		  
	 		totalgroup = (totalpages-1)/maxpages +1;		//페이지의 그룹핑
	 		   
	 		   //out.println("토탈 페이지 그룹 : " + totalgroup + "<p>");
	 		   
	 		 if (endpage > totalpages) 
	 		 endpage=totalpages;
	 		
		//서블릿으로 출력, 서블릿 : JAVA에서 웹페이지를 출력할 수 있는 JAVA 페이지

		    for(int j=startrow;j<=endrow;j++) { 
		    		
		    	out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
			    out.println("<tr>");
			    out.println("<td height='22'>&nbsp;</td></tr>");
			    out.println("<tr align='center'>");
			    out.println("<td height='1' bgcolor='#1F4F8F'></td>");
			    out.println("</tr>");
			    out.println("<tr align='center' bgcolor='#DFEDFF'>");
			    out.println("<td class='button' bgcolor='#DFEDFF'>"); 
			    out.println("<div align='left'><font size='2'>"+subject.elementAt(j) + "</div> </td>");
			    out.println("</tr>");
			    out.println("<tr align='center' bgcolor='#FFFFFF'>");
			    out.println("<td align='center' bgcolor='#F4F4F4'>"); 
			    out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
			    out.println("<tr bgcolor='#F4F4F4'>");
			    out.println("<td width='13%' height='7'></td>");
			    out.println("<td width='51%' height='7'>글쓴이 : "+ name.elementAt(j) +"</td>");
			    out.println("<td width='25%' height='7'></td>");
			    out.println("<td width='11%' height='7'></td>");
			    out.println("</tr>");
			    out.println("<tr bgcolor='#F4F4F4'>");
			    out.println("<td width='13%'></td>");
			    out.println("<td width='51%'>작성일 : " + inputdate.elementAt(j) + "</td>");
			    out.println("<td width='11%'></td>");
			    out.println("</tr>");
			    out.println("</table>");
			    out.println("</td>");
			    out.println("</tr>");
			    out.println("<tr align='center'>");
			    out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			    out.println("</tr>");
			    out.println("<tr align='center'>");
			    out.println("<td style='padding:10 0 0 0'>");
			    out.println("<div align='left'><br>");
			    out.println("<font size='3' color='#333333'><PRE>"+content.elementAt(j) + "</PRE></div>");
			    out.println("<br>");
			    out.println("</td>");
			    out.println("</tr>");
			    out.println("<tr align='center'>");
			    out.println("<td class='button' height='1'></td>");
			    out.println("</tr>");
			    out.println("<tr align='center'>");
			    out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			    out.println("</tr>");
			    out.println("</table>");
			    out.println("<p>");
		    }   
		    
		}	
		rs.close();
		pstmt.close();
		conn.close();
	} catch (SQLException e) {
	out.println(e);
	} 
		
	  %>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr> 
			<td align="center" width="46" height="20" border="0"><A href="dbgb_write.htm"> 
			<img src="image/write.gif" border=0></a></td>
		</tr>
	</table>
	<p>
	<%    

	 if (wheregroup > 1) {	// 현재 나의 그룹이 1 이상일 때는 
		  out.println("[<A href=dbgb_show.jsp?gogroup=1>처음</A>]"); 
		  out.println("[<A href=dbgb_show.jsp?gogroup="+priorgroup +">이전</A>]");
		  
		 } else {	// 현재 나의 그룹이 1이상이 아닐때	
		  out.println("[처음]") ;
		  out.println("[이전]") ;
		 }
		 
		 if (inputdate.size() !=0) { 
		  for(int jj=startpage; jj<=endpage; jj++) {
		   if (jj==where) 
		    out.println("["+jj+"]") ;
		   else
		    out.println("[<A href=dbgb_show.jsp?go="+jj+">" + jj + "</A>]") ;
		   } 
		  }
		  if (wheregroup < totalgroup) {
		   out.println("[<A href=dbgb_show.jsp?gogroup="+ nextgroup+ ">다음</A>]");
		   out.println("[<A href=dbgb_show.jsp?gogroup="+ totalgroup + ">마지막</A>]");
		  } else {
		   out.println("<table width='100%' cellspacing='0' cellpadding='2' align='center'>");
		   out.println("[다음]");
		   out.println("[마지막]");
		   out.println("</table>");
		  }
		  
	%>
</center>
</BODY>
</HTML>