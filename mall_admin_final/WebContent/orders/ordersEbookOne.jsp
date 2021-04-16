<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersEbookOne</title>
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
	//ordersEbookOne
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//인코딩&수집 - ebookNo
	request.setCharacterEncoding("UTF-8");
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println("선택한 ebookNo-> "+ebookNo);

	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	
	//선택한 ebookList출력
	//EbookDao에 no만 알면 리스트 출력해주는 메소드가 있음.
	Ebook ebookOne = OrdersDao.ebookOne(ebook);
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
					<h2>ordersList(ebookOne)</h2>
					
				</header>
				<div class="table-wrapper">
					<table class="alt">
						<tr>
							<td>ebookTitle</td>
							<td><%=ebookOne.getEbookTitle()%></td>
						</tr>
						<tr>
							<td>categoryName</td>
							<td><%=ebookOne.getCategoryName()%></td>
						</tr>
						<tr>
							<td>ebookISBN</td>
							<td><%=ebookOne.getEbookISBN()%></td>
						</tr>
						<tr>
							<td>ebookAuthor</td>
							<td><%=ebookOne.getEbookAuthor()%></td>
						</tr>
						<tr>
							<td>ebookCompany</td>
							<td><%=ebookOne.getEbookCompany()%></td>
						</tr>
						<tr>
							<td>ebookSummary</td>
							<td><%=ebookOne.getEbookSummary()%></td>
						</tr>
						<tr>
							<td>ebookImg</td>
							<td><img src="<%=request.getContextPath()%>/img/<%=ebookOne.getEbookImg()%>"></td>
						</tr>
						<tr>
							<td>ebookDate</td>
							<td><%=ebookOne.getEbookDate().substring(0, 19)%></td>
						</tr>
						<tr>
							<td>ebookState</td>
							<td><%=ebookOne.getEbookState()%></td>
						</tr>
						<tr>
							<td>ebookPageCount</td>
							<td><%=ebookOne.getEbookPageCount()%></td>
						</tr>
						<tr>
							<td>ebookPrice</td>
							<td><%=ebookOne.getEbookPrice()%></td>
						</tr>
					</table>	
				</div>
				<div><a href="<%=request.getContextPath()%>/orders/ordersList.jsp" class="button small">목록</a></div>
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