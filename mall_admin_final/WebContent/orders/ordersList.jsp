<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
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
	//ordersList
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//페이징 currentPage, rowPerPage, totalRow, beginRow, lastPage
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage")!=null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int totalRow = 0;
	//totalRow 메소드 실행
	totalRow = OrdersDao.totalCnt();
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	
	System.out.println("currentPage-> "+currentPage);
	System.out.println("rowPerPage-> "+rowPerPage);
	System.out.println("totalRow-> "+totalRow);
	System.out.println("beginRow-> "+beginRow);
	System.out.println("lastPage-> "+lastPage);
	System.out.println();
	
	
	//리스트 출력 메소드 실행
	ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
	//페이징 시 괄호 안에 beginRow, rowPerPage 넣어준다.
	list = OrdersDao.ordersList(beginRow, rowPerPage);
	
	//ordersStateList 메소드 실행
	String[] stateList = OrdersDao.ordersStateList();
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
					<h2>주문 관리</h2>
				</header>
				
				<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
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
							<th>ordersNo</th>
							<th>ebookISBN</th>
							<th>ebookTitle</th>
							<th>clientNo</th>
							<th>clientMail</th>
							<th>ordersDate</th>
							<th>ordersState</th>
						</tr>
					</thead>
					<tbody>
<%		
					for(OrdersAndEbookAndClient oec : list){
%>		
						<tr>
							<td class="align-center"><%=oec.getOrders().getOrdersNo() %></td>
							<td class="align-center"><%=oec.getOrders().getEbookISBN() %></td>
							<td><a href="<%=request.getContextPath()%>/orders/ordersEbookOne.jsp?ebookISBN=<%=oec.getOrders().getEbookISBN() %>"><%=oec.getEbook().getEbookTitle() %></a></td>
							<td class="align-center"><%=oec.getClient().getClientNo() %></td>
							<td><%=oec.getClient().getClientMail() %></td>
							<td class="align-center">
								<div><%=oec.getOrders().getOrdersDate().substring(0, 11) %></div>
								<div><%=oec.getOrders().getOrdersDate().substring(11, 19) %></div>
							</td>
							<td class="align-center">
								<form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp" method="post">
									<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo() %>">
									<input type="hidden" name="beginRow" value="<%=beginRow%>">
									<input type="hidden" name="currentPage" value="<%=currentPage%>">
									<select name="ordersState" class="choice">
<%					
									for(String s : stateList){
										if(s.equals(oec.getOrders().getOrdersState())){
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
									<button type="submit">수정</button>
								</form>
							</td>
						</tr>
<%			
					}	
%>			
					</tbody>
				</table>
				</div>
				
				<!-- 페이징 -->
				<!-- 경우의 수
				1. 다음, >> : currentPage == 1 && currentPage<lastPage
				2. [1] : currentPage == 1 또는 lastPage == 1
				3. <<, 이전 : currentPage == lastPage
				4. <<, 이전, 다음, >> : else~
				 -->
<%
				if(currentPage == 1 && currentPage < lastPage){
%>		
					<span>[<%=currentPage%>] </span>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>" class="button alt small paging">다음</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>" class="button alt small paging">&gt;&gt;</a>
				
<%
				} else if(currentPage == 1 || lastPage == 1){
%>	
					<span>[<%=currentPage%>]</span>
<%		
				} else if(currentPage == lastPage){
%>			
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1" class="button alt small paging">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>" class="button alt small paging">이전</a>
					<span>[<%=currentPage%>]</span>
<%		
				} else{
%>			
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1" class="button alt small paging">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>" class="button alt small paging">이전</a>
					<span>[<%=currentPage%>]</span>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>" class="button alt small paging">다음</a>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>" class="button alt small paging">&gt;&gt;</a>
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