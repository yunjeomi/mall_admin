<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/main.css" />
	
	<!-- Scripts -->
	<script src="<%=request.getContextPath() %>/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/util.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/main.js"></script>
</head>
<body>
<%
	//insertCategoryForm
	
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//카테고리 이름 중복되지 않도록
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
					<h2>insert Category Form</h2>
				</header>
				
				<!-- 입력할 값 이름, 가중치. 날짜는 sql에서 자동으로 입력되도록 한다. -->
				<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
					<div class="table-wrapper">
						<table class="alt">	
							<tr>
								<td>categoryName</td>
								<td><input type="text" name="categoryName" required pattern="^[a-zA-Z가-힣]{2,20}$"></td>
							</tr>
							<tr>
								<td>categoryWeight</td>
								<td>
									<select name="categoryWeight">
									<%
										for(int i=0; i<10; i++){	//가중치는 0에서 9까지
									%>		
										<option value="<%=i %>"><%=i %></option>
									<%
										}
									%>
									</select>
								</td>
							</tr>
						</table>
					</div>	
					<button type="submit">추가</button>
					<a href="<%=request.getContextPath() %>/category/categoryList.jsp" class="button alt small">취소</a>
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