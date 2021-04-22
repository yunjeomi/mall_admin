<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookForm</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/main.css" />
	
	<!-- Scripts -->
	<script src="<%=request.getContextPath()%>/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath()%>/assets/js/util.js"></script>
	<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
</head>
<body>
<%
	//updateEbookForm

	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 - isbn
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("선택한 ebookISBN-> "+ebookISBN);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	
	//선택한 isbn의 ebook 정보 불러오기
	Ebook ebookOne = EbookDao.ebookOne(ebook);
	//state 판매중, 품절, 절판, 구편 설정
	String[] state = null;
	state = EbookDao.setEbookState();
	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
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
					<h2>update Ebook Form</h2>
				</header>
				
				<div class="table-wrapper">
					<form action="<%=request.getContextPath()%>/ebook/updateEbookAction.jsp" method="post">
						<table>
							<tr>
								<td>ebookTitle</td>
								<td>
									<input type="text" name="ebookTitle" value="<%=ebookOne.getEbookTitle()%>">
								</td>
							</tr>
							<tr>
								<td>categoryName</td>
								<td>
								<select name="categoryName">
							<%	
								for(String s : categoryNameList){
									if(ebookOne.getCategoryName().equals(s)){
							%>		
										<option value="<%=s%>" selected><%=s%></option>
							<%		
									} else{
							%>	
										<option value="<%=s%>"><%=s%></option>
							<%	
									}
								}
							%>	
								</select>
								</td>
							</tr>
							<tr>
								<td>ebookISBN</td> <!-- 수정x. but 값은 넘겨주자 -->
								<td>
									<input type="text" name="ebookISBN" value="<%=ebookOne.getEbookISBN()%>" readonly>
								</td>
							</tr>
							<tr>
								<td>ebookAuthor</td>
								<td>
									<input type="text" name="ebookAuthor" value="<%=ebookOne.getEbookAuthor()%>">
								</td>
							</tr>
							<tr>
								<td>ebookCompany</td>
								<td>
									<input type="text" name="ebookCompany" value="<%=ebookOne.getEbookCompany()%>">
								</td>
							</tr>
							<tr>
								<td>ebookSummary</td>
								<td>
									<textarea rows="5" cols="80" name="ebookSummary"><%=ebookOne.getEbookSummary()%></textarea>
								</td>
							</tr>
							<tr>
								<td>ebookImg</td><!-- 수정xx -->
								<td><img src="<%=request.getContextPath()%>/img/<%=ebookOne.getEbookImg()%>"></td>
							</tr>
							<tr>
								<td>ebookDate</td><!-- 수정xx -->
								<td><%=ebookOne.getEbookDate()%></td>
							</tr>
							<tr>
								<td>ebookState</td>
								<td>
								<select name="ebookState">
							<%	
								for(String s : state){
									if(ebookOne.getEbookState().equals(s)){
							%>		
										<option value="<%=s%>" selected><%=s%></option>
							<%		
									} else{
							%>	
										<option value="<%=s%>"><%=s%></option>
							<%	
									}
								}
							%>	
								</select>
								</td>
							</tr>
							<tr>
								<td>ebookPageCount</td>
								<td>
									<input type="text" name="ebookPageCount" value="<%=ebookOne.getEbookPageCount()%>">
								</td>
							</tr>
							<tr>
								<td>ebookPrice</td>
								<td>
									<input type="text" name="ebookPrice" value="<%=ebookOne.getEbookPrice()%>">
								</td>
							</tr>
						</table>
						<button type="submit">전체수정</button>
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