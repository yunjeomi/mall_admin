<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMenu</title>
</head>
<body>
<div>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");

%>
	<ul>
		<li><a href="<%=request.getContextPath()%>/adminIndex.jsp">운영자 홈</a></li>
		<li><a href="<%=request.getContextPath()%>/manager/managerList.jsp">운영자 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/client/clientList.jsp">고객 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/category/categoryList.jsp">상품 카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 관리</a></li>
		<!-- order라는 이름은 사용할 수 없다. -->
		<li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">주문 관리</a></li>
		<!-- R(list, one->레벨1이상)UD(->레벨2이상) -->
		<li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지 관리</a></li>
		<li><a href="<%=request.getContextPath() %>/manager/logoutManagerAction.jsp" class="button alt small logout">로그아웃</a></li>
	</ul>



</div>

</body>
</html>