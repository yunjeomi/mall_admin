<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerInsertForm</title>
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
	//insertManagerForm
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
					<h2>매니저 등록</h2>
					<p>승인 후 이용 가능합니다.</p>
				</header>
				
				<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
					<table class="alt">
						<tr>
							<td>manager_id</td>
							<td><input type="text" name="managerId" required pattern="^[a-z0-9]{4,15}$"></td>
						</tr>
						<tr>
							<td>manager_pw</td>
							<td><input type="password" name="managerPw" required pattern="^[a-zA-Z0-9\W]{4,15}$"></td>
						</tr>
						<tr>
							<td>manager_name</td>
							<td><input type="text" name="managerName" required pattern="^[a-zA-Z가-힣]{2,20}$"></td>
						</tr>
					</table>
					<button type="submit">등록</button>
					<a href="<%=request.getContextPath() %>/adminIndex.jsp" class="button alt small">취소</a>
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