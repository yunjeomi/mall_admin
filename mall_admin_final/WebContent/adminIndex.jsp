<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/assets/css/main.css" />
	
	<!-- Scripts -->
	<script src="<%=request.getContextPath() %>/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/skel.min.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/util.js"></script>
	<script src="<%=request.getContextPath() %>/assets/js/main.js"></script>
</head>
<body class="landing">
<%
	if(session.getAttribute("sessionManager")==null){	//1. 관리자 로그인 폼
%>							
	<!-- Header -->
		<header id="header" class="alt">
			<h1><strong><a href="<%=request.getContextPath() %>/adminIndex.jsp">EbookMall</a></strong> for admin</h1>
			<nav id="nav">
				<ul>
					<li><jsp:include page="/inc/adminMenu.jsp"></jsp:include></li>
				</ul>
			</nav>
		</header>

		<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>
	
	<!-- Banner -->
		<section id="banner">
			<h2>AdminIndex</h2>
			
			<form action="<%=request.getContextPath() %>/manager/loginManagerAction.jsp" method="post">
				<div class="table-wrapper">
					<table class="alt">
						<tr>
							<td width="30%">Id</td>
							<td width="70%"><input type="text" name="managerId" required pattern="^[a-z0-9]{4,15}$"></td>
						</tr>
						<tr>
							<td>Pw</td>
							<td><input type="password" name="managerPw" required pattern="^[a-zA-Z0-9\W]{4,15}$"></td>
						</tr>
					</table>
				</div>
				
				
				<button type="submit" class="button special big">Login</button>
				<a href="<%=request.getContextPath() %>/manager/insertManagerForm.jsp" class="button alt big login">매니저등록</a>
				
			</form>
		</section>

	<!-- One -->
		<section id="one" class="wrapper style1">
			<div class="container 75%">
				<div class="row 200%">
					<div class="6u 12u$(medium)">
						<header class="major">
							<h3>승인대기 중인 매니저 목록</h3>
						</header>
					</div>
					<div class="6u$ 12u$(medium)">
						<div class="table-wrapper">
							<table class="alt">
								<thead>
									<tr>
										<th>managerId</th>
										<th>managerDate</th>
									</tr>
								</thead>
<%	
								ArrayList <Manager> list = ManagerDao.managerListByZero();
								for(Manager a : list){	
%>	
								<tbody>
									<tr>
										<td><%=a.getManagerId() %></td>
										<td><%=a.getManagerDate().substring(0, 11) %></td>
									</tr>
								</tbody>
<%			
								}	
%>	
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
<%			
	} else{	//2. 로그인에 성공한 매니저 화면
		Manager manager = (Manager)(session.getAttribute("sessionManager"));	//Manager형으로 형변환
		ArrayList<Manager> managerList = ManagerDao.managerList(0, 5);
		ArrayList<Notice> noticeList = NoticeDao.noticeList(0, 5);
		ArrayList<Client> clientList = ClientDao.clientListByPage(0, 5, "");
		ArrayList<Ebook> ebookList = EbookDao.ebookList(0, 5);
		ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.ordersList(0, 5);
%>
	<!-- Header -->
		<header id="header">
			<h1><strong><a href="<%=request.getContextPath() %>/adminIndex.jsp">EbookMall</a></strong> for admin</h1>
			<nav id="nav">
				<ul>
					<li><jsp:include page="/inc/adminMenu.jsp"></jsp:include></li>
				</ul>
			</nav>
		</header>

		<a href="#menu" class="navPanelToggle"><span class="fa fa-bars"></span></a>
	
	
	<section id="four" class="wrapper style3 special">
					<div class="container">
						<header class="major">
							<h2><%=manager.getManagerId() %>님 반갑습니다.</h2>
							<p>level : <%=manager.getManagerLevel() %></p>
						</header>
					</div>
				</section>
	
	<!-- Two -->
		<section id="two" class="wrapper style2 special">
			<div class="container">
				
				<!-- 1행 -->
				<div class="row 150%">
					<!-- 1행 1열 -->
					<div class="6u 12u$(xsmall)">
						<div>
							<h3>noticeList <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">[more]</a></h3>
							<div class="table-wrapper">
								<table class="alt">
								<tr>
									<th>noticeTitle</th>
									<th>managerId</th>
								</tr>
<%
								for(Notice n : noticeList){
%>
									<tr>
										<td><%=n.getNoticeTitle() %></td>
										<td><%=n.getManagerId() %></td>
									</tr>
<%
								}
%>	
							</table>
							</div>
						</div>
					</div>
					
					<!-- 1행 2열 -->
					<div class="6u$ 12u$(xsmall)">
						<div>
							<h3>ordersList <a href="<%=request.getContextPath()%>/orders/ordersList.jsp">[more]</a></h3>
							<div class="table-wrapper">
								<table class="alt">
									<tr>
										<th>ordersNo</th>
										<th>ebookTitle</th>
										<th>clientMail</th>
									</tr>
<%
									for(OrdersAndEbookAndClient n : oecList){
%>
										<tr>
											<td><%=n.getOrders().getOrdersNo()%></td>
											<td><%=n.getEbook().getEbookTitle()%></td>
											<td><%=n.getClient().getClientMail()%></td>
										</tr>
<%
									}
%>	
								</table>
							</div>
						</div>
					</div>
				</div>
				<br>
				<!-- 2행 -->
				<div class="row 120%">
					<!-- 2행 1열 -->
					<div class="6u 12u$(xsmall)">
						<div>
							<h3>ebookList <a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[more]</a></h3>
							<div class="table-wrapper">
								<table class="alt">
									<tr>
										<th>ebookTitle</th>
										<th>ebookISBN</th>
									</tr>
<%
									for(Ebook n : ebookList){
%>
										<tr>
											<td><%=n.getEbookTitle()%></td>
											<td><%=n.getEbookISBN()%></td>
										</tr>
<%
									}
%>	
								</table>
							</div>
						</div>
					</div>
					
					<!-- 2행 2열 -->
					<div class="6u$ 12u$(xsmall)">
						<div>
							<h3>clientList <a href="<%=request.getContextPath()%>/client/clientList.jsp">[more]</a></h3>
							<div class="table-wrapper">
								<table class="alt">
									<tr>
										<th>clientMail</th>
										<th>clientDate</th>
									</tr>
<%
									for(Client n : clientList){
%>
										<tr>
											<td><%=n.getClientMail()%></td>
											<td><%=n.getClientDate().substring(0, 11)%></td>
										</tr>
<%
									}
%>	
								</table>
							</div>
						</div>
					</div>
				</div>
				<br>
				<!-- 3행 -->
				<div class="row 120%">
					<!-- 3행 1열 -->
					<div class="6u 12u$(xsmall)">
						<div>
							<h3>managerList <a href="<%=request.getContextPath()%>/manager/managerList.jsp">[more]</a></h3>
							<div class="table-wrapper">
								<table class="alt">
									<tr>
										<th>managerId</th>
										<th>managerName</th>
									</tr>
<%
									for(Manager n : managerList){
%>
										<tr>
											<td><%=n.getManagerId()%></td>
											<td><%=n.getManagerName()%></td>
										</tr>
<%
									}
%>	
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
<%		
	}
%>		
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