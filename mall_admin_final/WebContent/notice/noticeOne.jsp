<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
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
	//noticeOne
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//수집 - noticeNo 인트형->스트링변환
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	//vo 초기화 후 넣어주기. 
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	//one list 메소드 실행
	//하나의 값 부르기 위한 
	Notice noticeOne = new Notice();
	noticeOne = NoticeDao.noticeOne(notice);
	
	//수정, 삭제버튼
	
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
					<h2>notice One</h2>
				</header>
				
				<div class="table-wrapper">
					<table class="alt">
						<tr>
							<td style="width: 20%">noticeNo</td>
							<td><%=noticeOne.getNoticeNo() %></td>
						</tr>
						<tr>
							<td>noticeTitle</td>
							<td><%=noticeOne.getNoticeTitle() %></td>
						</tr>
						<tr>
							<td>noticeContent</td>
							<td><%=noticeOne.getNoticeContent() %></td>
						</tr>
						<tr>
							<td>managerId</td>
							<td><%=noticeOne.getManagerId() %></td>
						</tr>
						<tr>
							<td>noticeDate</td>
							<td><%=noticeOne.getNoticeDate().substring(0, 11) %></td>
						</tr>
					</table>
				</div>
				
				<!-- 수정/삭제 버튼 -->
				<a href="<%=request.getContextPath()%>/notice/updateNoticeForm.jsp?noticeNo=<%=noticeNo%>" class="button small">수정</a>
				<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>" class="button alt small">삭제</a>
				<a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="button alt small" style="float: right">목록</a>
				<br><br>	
				<br>
				
				<!-- 댓글 리스트 -->
<%
				ArrayList<Comment> commentList = CommentDao.commentList(noticeNo);
				for(Comment c : commentList){
%>
				<div class="table-wrapper">
					<table>
						<tr>
							<td style="width:10%"><%=c.getManagerId()%></td>
							<td><%=c.getCommentContent() %></td>
							<td style="text-align:right"><%=c.getCommentDate().substring(0, 19)%>
								<a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?noticeNo=<%=noticeNo%>&commentNo=<%=c.getCommentNo()%>&managerId=<%=c.getManagerId()%>">삭제</a>
							</td>
						</tr>
					</table>
				</div>
<%			
					}
%>	
				<br>
				<!-- 코멘트 란 -->
				<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
					<!-- 현재 공지글 넘버 -->
					<input type="hidden" name="noticeNo" value="<%=noticeOne.getNoticeNo() %>">
					<div>
						<!-- 세션에 저장된id 사용 -->
						댓글입력
						<input type="text" name="managerId" value="<%=managerCk.getManagerId() %>" readonly>
					</div>
					<div>
						<textarea name="commentContent" rows="2" cols="80"></textarea>
					</div>
					<button type="submit">댓글입력</button>
				</form>
				<br>
				
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