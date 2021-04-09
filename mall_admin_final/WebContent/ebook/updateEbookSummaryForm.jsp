<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookSummaryForm</title>
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
	//updateEbookSummaryForm
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("선택한 summary의 ebookISBN ->"+ebookISBN);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	
	//selectEbookOne메소드 실행하여 리스트를 가져오자.
	Ebook ebookSummary = new Ebook();
	ebookSummary = EbookDao.selectEbookOne(ebook);


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
					<h2>Summary 수정</h2>
				</header>
				<div class="table-wrapper">	
					<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp" method="post">
						<table class="alt">
							<tr>
								<td>ebookTitle</td>
								<td><%=ebookSummary.getEbookTitle()%></td>
							</tr>
							<tr>
								<td>categoryName</td>
								<td><%=ebookSummary.getCategoryName()%></td>
							</tr>
							<tr>
								<td>ebookISBN</td>
								<td>
									<input type="text" name="ebookISBN" value="<%=ebookSummary.getEbookISBN()%>" readonly>
								</td>
							</tr>
							<tr>
								<td>ebookSummary</td>
								<td>
									<textarea rows="5" cols="80" name="ebookSummary"><%=ebookSummary.getEbookSummary() %></textarea>
								</td>
							</tr>
							
						</table>
						<button type="submit">수정</button>
						<a href="<%=request.getContextPath() %>/ebook/ebookOne.jsp?ebookISBN=<%=ebookISBN %>" class="button alt small">취소</a>
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