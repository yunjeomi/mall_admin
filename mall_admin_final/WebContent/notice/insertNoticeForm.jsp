<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/main.css" />
	
	<!-- Scripts -->
	<script src="<%=request.getContextPath() %>assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>assets/js/util.js"></script>
	<script src="<%=request.getContextPath() %>assets/js/main.js"></script>
</head>
<body>
<%
	//insertNoticeForm
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	//꼭 return을 넣어줘야함. 안 넣으면 계속 실행됨
	} else if(managerCk.getManagerLevel() == 1){
		System.out.println("*공지 추가 권한 없음*\n");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	}
	
	//수집 없이 정보 입력후 폼을 액션으로 보내준다.
	//no, date는 자동입력
	//로그인 한 아이디가 레벨 2일경우에만 등록가능하니 등록id는 세션값 가져온다.

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
					<h2>insert Notice Form</h2>
				</header>
				
				<form action="<%=request.getContextPath() %>/notice/insertNoticeAction.jsp" method="post">
					<table class="alt">
						<tr>
							<td>noticeTitle</td>
							<td><input type="text" name="noticeTitle" required pattern="^[a-zA-Z가-힣0-9~!@#$%^&*(){}-=+/]{1,20}$"></td>
						</tr>
						<tr>
							<td>noticeContent</td>
							<td><textarea rows="5" cols="80" name="noticeContent"></textarea></td>
						</tr>
						<tr>
							<td>managerId</td>
							<td><%=managerCk.getManagerId() %></td>
						</tr>	
					</table>
					<button type="submit">공지 추가</button>
					<a href="<%=request.getContextPath() %>/notice/noticeList.jsp" class="button alt small">취소</a>
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