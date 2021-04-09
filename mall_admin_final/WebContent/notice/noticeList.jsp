<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
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
	//noticeList
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//페이징 필요변수 - currentPage, rowPerPage, totalRow, lastPage, beginRow
	//초기화&수집 후 디버깅
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		currentPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int totalRow = 0;
	// totalRow 구하는 메소드 추가
	totalRow = NoticeDao.totalRow();
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	System.out.println("currentPage-> "+currentPage);
	System.out.println("rowPerPage-> "+rowPerPage);
	System.out.println("totalRow-> "+totalRow);
	System.out.println("lastPage-> "+lastPage);
	System.out.println("beginRow-> "+beginRow);
	System.out.println();
	
	
	//리스트 출력 메소드 - 여러 리스트 뽑아내야 하니 어레이 리스트로, no 내림차순으로
	//초기화 후 메소드 실행
	ArrayList<Notice> list = new ArrayList<>();
	list = NoticeDao.noticeList(beginRow, rowPerPage);
	System.out.println("*Notice List 출력*\n");
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
					<h2>공지 관리</h2>
				</header>
				<!-- 공지추가 버튼 -->
				<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp" class="button small">공지추가</a>
				
				<div class="table-wrapper">
					<table class="alt">
						<thead>
							<tr>
								<th>noticeNo</th>
								<th>noticeTitle</th>
								<th>noticeDate</th>
								<th>managerId</th>
							</tr>
						</thead>
						<tbody>
						<%	
							for(Notice c : list){
						%>	
							
							<tr>
								<td class="align-center"><%=c.getNoticeNo() %></td>
								<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=c.getNoticeNo() %>"><%=c.getNoticeTitle() %></a></td>
								<td class="align-center"><%=c.getNoticeDate().substring(0, 11) %></td>
								<td><%=c.getManagerId() %></td>
							</tr>
						<%	
							}
						%>
						</tbody>
					</table>
				</div>
				
				<!-- 다음 버튼 -->
				<!-- 
				경우의 수
				1. 다음, 맨끝 -> currentPage 1, lastPage 1이상
				2. -1- 현재페이지만 -> lastPage 1 혹은 데이터 없을 때
				3. 맨처음, 이전 -> currentPage랑 lastPage 같을 때
				4. 맨처음, 이전, 다음, 맨끝 -> 그 외
				 -->
<%
				if(currentPage == 1 && lastPage > 1){
%>		
					<span>[<%=currentPage %>]</span>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small">다음</a>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=lastPage%>" class="button alt small">&gt;&gt;</a>
					
<%		
				} else if(lastPage == 1 || currentPage == 0){
%>	
					<span>[<%=currentPage %>]</span>
<%		
				} else if(currentPage == lastPage){
%>	
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1" class="button alt small">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small">이전</a>
					<span>[<%=currentPage %>]</span>
<%	
				} else{
%>	
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=1" class="button alt small">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small">이전</a>
					<span>[<%=currentPage %>]</span>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small">다음</a>
					<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=lastPage%>" class="button alt small">&gt;&gt;</a>
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