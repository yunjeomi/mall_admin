<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
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
	//categoryList	

	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//메소드 실행 후 값을 넘겨줄 변수 초기화
	ArrayList<Category> list = new ArrayList<>();
	
	//categoryList 불러오기 메소드 실행 후 변수에 담아주기
	list = CategoryDao.categoryList();
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
					<!-- 페이징x, 검색어x -->
					<h2>상품 카테고리 관리</h2>
				</header>
				
				<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp" class="button small">카테고리 추가</a>
				<br>
				<div class="table-wrapper">
					<table>
						<thead>
							<tr>
								<th>categoryName</th>
								<th>categoryUpdate</th><!-- 수정 가능하도록 한다. -->
							</tr>
						</thead>
						<tbody>
						<%
							for(Category s : list){
						%>
							<tr>
								<td class="align-center"><%=s.getCategoryName() %></td>
								<td class="align-center">
									<form action="<%=request.getContextPath()%>/category/updateCategoryWeight.jsp" method="post">
										<!-- 수정할 때 행(where)을 특정해야함. weight와 다른 값을 같이 넘겨줘야 하는데 여기선 name을 넘겨준다. -->
										<input type="hidden" name="categoryName" value="<%=s.getCategoryName() %>">
										<select name="categoryWeight" class="choice">
								<%	
										for(int i=0; i<10; i++){
											if(i==s.getCategoryWeight()){
								%>
												<option value="<%=i %>" selected><%=i %></option>
								<%		
										} else{
								%>
												<option value="<%=i %>"><%=i %></option>
								<%		
										}
									}
								%>	
									</select>
									<button type="submit">수정</button>
									<a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=s.getCategoryName()%>" class="button alt small">삭제</a>
									</form>
								</td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
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