<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerList</title>
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
	//managerList

	//이 페이지는 주소창에서 주소 검색하면 바로 올 수 있으므로,
	//이 페이지에 도달하면 다른 곳으로 강제로 보내버리자
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<2){
		System.out.println("*접근 권한이 없습니다.*");	//디버깅
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	
	//페이징 - currentPage, rowPerPage, beginRow, lastPage, totalRow
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int totalRow = 0;
	//totalRow 메소드 실행
	totalRow = ManagerDao.totalRow();
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	
	System.out.println("currentPage-> "+currentPage);
	System.out.println("rowPerPage-> "+rowPerPage);
	System.out.println("totalRow-> "+totalRow);
	System.out.println("lastPage-> "+lastPage);
	System.out.println("beginRow-> "+beginRow);
	System.out.println();
	
	//list 메소드 실행
	ArrayList<Manager> list = ManagerDao.managerList(beginRow, rowPerPage);
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
			<div class="container">
				<header class="major special">
					<h2>운영자 관리</h2>
				</header>
				
				<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
					<select name="rowPerPage" class="choice">
<%
							for(int i=10; i<=30; i+=5){
								if(rowPerPage == i){
%>
									<option value="<%=i%>" selected><%=i %></option>
<%		
								} else{
%>
									<option value="<%=i%>"><%=i %></option>
<%
								}
							}
%>
					</select>
					<button type="submit">보기</button>
				</form>
				
				<div class="table-wrapper">
				<table class="alt">
					<thead>
						<tr>
							<th>managerNo</th>
							<th>managerId</th>
							<th>managerName</th>
							<th>managerDate</th>
							<th style="width:20%">managerUpdate</th>
						</tr>
					</thead>
					<tbody>
<%
						for(Manager m : list){
%>
							<tr>
								<td class="align-center"><%=m.getManagerNo() %></td>
								<td><%=m.getManagerId() %></td>
								<td><%=m.getManagerName() %></td>
								<td class="align-center"><%=m.getManagerDate().substring(0, 19) %></td>
								<td class="align-center">
									<form action="<%=request.getContextPath()%>/manager/updateManagerLevel.jsp" method="post">
										<!-- 수정하려면 no&level값을 같이 넘겨줘야함. 1열에 no가 있지만 form안에 없으므로 no를 form안에 다시 넣어준다.  -->
										<!-- no&level 같이 넘겨주는 여러방법이 있음. 여기서는 hidden을 사용 -->
										<!-- hidden; 텍스트상자에 no 넣어놓고 안 보이게 숨겨놓음 -->
										<input type="hidden" name="managerNo" value="<%=m.getManagerNo() %>">
										<select name="managerLevel" class="choice">
<%
											for(int i=0; i<3; i++){	//선택지 3개를 for문으로
												if(m.getManagerLevel()==i){	//내가 선택한 값(selected)을 보여주기 위해 if문 사용
%>
													<option value="<%=i%>" selected><%=i%></option>
<%		
												} else{
%>
													<option value="<%=i%>"><%=i%></option>
<%
												}
											}
%>
										</select>
										<button type="submit">수정</button>
										<a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>" class="button alt small">삭제</a>
									</form>
								</td>
							</tr>
<%
						}
%>
					</tbody>
				</table>
			</div>
<%
				if(currentPage == 1 && currentPage < lastPage){
%>		
					<span>[<%=currentPage%>] </span>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>" class="button alt small">다음</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>" class="button alt small">&gt;&gt;</a>
<%
				} else if(currentPage == 1 || lastPage == 1){
%>	
					<span>[<%=currentPage%>]</span>
<%		
				} else if(currentPage == lastPage){
%>		
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1" class="button alt small">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>" class="button alt small">이전</a>
					<span>[<%=currentPage%>]</span>
<%		
				} else{
%>		
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1" class="button alt small">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>" class="button alt small">이전</a>
					<span>[<%=currentPage%>]</span>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>" class="button alt small">다음</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>" class="button alt small">&gt;&gt;</a>
<%		
				}
%>
				
				
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