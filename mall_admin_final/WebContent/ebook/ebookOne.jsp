<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
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
	//ebookOne
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	//꼭 return을 넣어줘야함. 안 넣으면 계속 실행됨
	}

	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("선택한 title의 ebookISBN ->"+ebookISBN);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	
	
	//ebookOne 보기 메소드 실행
	Ebook ebookOne = EbookDao.ebookOne(ebook);
	
	System.out.println("ebookTitle-> "+ebookOne.getEbookTitle());
	System.out.println("categoryName-> "+ebookOne.getCategoryName());
	System.out.println("ebookISBN-> "+ebookOne.getEbookISBN());
	System.out.println("ebookAuthor-> "+ebookOne.getEbookAuthor());
	System.out.println("ebookCompany-> "+ebookOne.getEbookCompany());
	System.out.println("ebookSummary-> "+ebookOne.getEbookSummary());
	System.out.println("ebookState-> "+ebookOne.getEbookState());
	System.out.println("ebookPageCount-> "+ebookOne.getEbookPageCount());
	System.out.println("ebookPrice-> "+ebookOne.getEbookPrice());

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
					<h2>ebookOne</h2>
					
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
							<td><%=ebookOne.getEbookSummary()%><a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebookOne.getEbookISBN()%>"><button type="button" class="button alt" style="float: right;">책요약 수정</button></a></td>
						</tr>
						<tr>
							<td>ebookImg</td>
							<td><img src="<%=request.getContextPath()%>/img/<%=ebookOne.getEbookImg()%>"><a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebookOne.getEbookISBN()%>"><button type="button" class="button alt" style="float: right;">이미지 수정</button></a></td>
						</tr>
						<tr>
							<td>ebookDate</td>
							<td><%=ebookOne.getEbookDate().substring(0, 19)%></td>
						</tr>
						<tr>
							<td>ebookState</td>
							<td><%=ebookOne.getEbookState()%> <a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebookOne.getEbookISBN()%>"><button type="button" class="button alt" style="float: right;">책상태 수정</button></a></td>
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
				<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=ebookISBN%>" class="button small">전체수정(이미지 제외)</a>
				<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>" class="button alt small">삭제</a>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp" class="button alt small" style="float: right">목록</a>
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