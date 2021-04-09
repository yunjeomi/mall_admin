<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertEbookForm</title>
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
	//insertEbookForm
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	//꼭 return을 넣어줘야함. 안 넣으면 계속 실행됨
	}


	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
	System.out.println("categoryNameList.size()->"+categoryNameList.size());

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
					<h2>insert Ebook Form</h2>
				</header>
				
				<div class="table-wrapper">
					<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
					<!-- 카테고리네임(셀렉트), isbn, title, author, price ... -->
						<table class="alt">
							<tr>
								<td>categoryName</td>
								<td>
									<select name="categoryName">
											<option value="">선택</option>
									<%
										for(String cn : categoryNameList){
									%>
											<option value="<%=cn%>"><%=cn%></option>
									<%	
										}	
									%>	
									</select>
								</td>
							</tr>
							<tr>
								<td>ebookISBN</td>
								<td><input type="text" name="ebookISBN" required pattern="^\d{9}-\d{1}$"></td>
							</tr>
							<tr>
								<td>ebookTitle</td>
								<td><input type="text" name="ebookTitle" required pattern="^[a-zA-Z가-힣0-9]{1,100}$"></td>
							</tr>
							<tr>
								<td>ebookAuthor</td>
								<td><input type="text" name="ebookAuthor" required pattern="^[a-zA-Z가-힣0-9]{1,50}$"></td>
							</tr>
							<tr>
								<td>ebookCompany</td>
								<td><input type="text" name="ebookCompany" required pattern="^[a-zA-Z가-힣0-9]{1,50}$"></td>
							</tr>
							<tr>
								<td>ebookPageCount</td>
								<td><input type="text" name="ebookPageCount" required pattern="^[0-9]+$"></td>
							</tr>
							<tr>
								<td>ebookPrice</td>
								<td><input type="text" name="ebookPrice" required pattern="^[0-9]+$"></td>
							</tr>
							<tr>
								<td>ebookSummary</td>
								<td><textarea rows="5" cols="80" name="ebookSummary" ></textarea></td>
							</tr>
						</table>
						<button type="submit">추가</button>
						<a href="<%=request.getContextPath() %>/ebook/ebookList.jsp" class="button alt small">취소</a>
					</form>
				</div>
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