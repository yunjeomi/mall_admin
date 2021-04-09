<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/main.css" />
	
	<!-- Scripts -->
	<script src="<%=request.getContextPath() %>/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/util.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/main.js"></script>
</head>
<body>
<%
	//updateNoticeForm
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 -> no
	request.setCharacterEncoding("UTF-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	if(managerCk.getManagerLevel()==1){
		System.out.println("*공지 수정 권한이 없습니다.*\n");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		return;
	}
	
	System.out.println("선택한 noticeNo-> "+noticeNo);
	
	//메소드 실행 위해 값 넣어주기
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	//받아올 정보를 넣어줄 변수를 초기화
	Notice list = new Notice();
	
	//noticeOne 리스트를 실행하여 기존 값을 가져온다.
	list = NoticeDao.noticeOne(notice);
%>

<!-- Header -->
	<!-- 관리자메뉴 -->
		<header id="header">
			<h1><strong><a href="<%=request.getContextPath() %>/adminIndex.jsp">EbookMall</a></strong> for admin</h1>
			<nav id="nav">
				<ul>
					<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
				</ul>
			</nav>
		</header>
	
		<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>

	<!-- Main -->
		<section id="main" class="wrapper">
			<div class="container 75%">

				<header class="major special">
					<h2>update Notice Form</h2>
				</header>
				
				<!-- 수정할 값 : title, content -->
				<form action="<%=request.getContextPath() %>/notice/updateNoticeAction.jsp" method="post">
					<table class="alt">
						<tr>
							<th>noticeNo</th>
							<td><input type="text" name="noticeNo" value="<%=list.getNoticeNo()%>" readonly></td>
						</tr>
						<tr>
							<th>noticeTitle</th>
							<td><input type="text" name="noticeTitle" value="<%=list.getNoticeTitle()%>"></td>
						</tr>
						<tr>
							<th>noticeContent</th>
							<td><textarea rows="5" cols="80" name="noticeContent"><%=list.getNoticeContent()%></textarea></td>
						</tr>
						<tr>
							<th>managerId</th>
							<td><%=list.getManagerId()%></td>
						</tr>
						<tr>
							<th>noticeDate</th>
							<td><%=list.getNoticeDate()%></td>
						</tr>
					</table>
					<button type="submit">수정</button>
					<a href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeNo=<%=noticeNo %>" class="button alt small">취소</a>
				</form>
				
			</div>
		</section>

	<!-- Footer -->
		<footer id="footer">
			<div class="container">
				<ul class="icons">
					<li><a href="#" class="icon fa-facebook"></a></li>
					<li><a href="#" class="icon fa-twitter"></a></li>
					<li><a href="#" class="icon fa-instagram"></a></li>
				</ul>
				<ul class="copyright">
					<li>&copy; yunjeong</li>
					<li>Design: <a href="http://templated.co">TEMPLATED</a></li>
					<li>Images: <a href="http://unsplash.com">Unsplash</a></li>
				</ul>
			</div>
		</footer>
</body>
</html>