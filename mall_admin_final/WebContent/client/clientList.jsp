<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>clientList</title>
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
	//clientList
	
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}


	//현재 페이지값 초기화
	//넘겨받을 경우, 값 가져오기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	//페이지 당 행의 수 초기화
	//넘겨받을 경우, 값 가져오기
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	//시작 페이지
	int beginRow = (currentPage-1)*rowPerPage; 
	
	//+)검색값 넘겨주기
	String searchWord = "";
	if(request.getParameter("searchWord")!=null){
		searchWord = request.getParameter("searchWord");
	}
	
	//고객 목록 페이징 메소드 실행
	ArrayList<Client> list = ClientDao.clientListByPage(beginRow, rowPerPage, searchWord);
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
					<h2>고객 관리</h2>
				</header>
				<!-- 고객 list 10/15/20/25/30개씩 나눠서 보기-->
				<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post" >
					<!-- n개씩 보기 버튼 클릭시 검색어도 같이 넘어가도록 hidden을 사용해서 searchWord를 같이 넘긴다. -->
					<input type="hidden" name="searchWord" value="<%=searchWord%>">
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
					<button type="submit" >보기</button>
				</form>
				
				<div class="table-wrapper">
				<table>
					<thead>
						<tr>
							<th>clientMail</th>
							<th style="width:20%">clientDate</th>
							<th style="width:20%">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
<%
						for(Client cl : list){
%>	
						<tr>	
							<td><%=cl.getClientMail() %></td>
							<td style="text-align: center"><%=cl.getClientDate().substring(0, 11) %></td> <!-- substring(0, 11)년/월/일만 출력 -->
							<td style="text-align: center">
								<a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=cl.getClientMail() %>"><button type="button">수정</button></a>
								<a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=cl.getClientMail() %>"><button type="button" class="button alt">삭제</button></a>
							</td>
						</tr>
<%		
						}
%>
					</tbody>
				</table>
				</div>
				
<%
			
				//전체 고객 수
				int totalRow = ClientDao.totalCount(searchWord);
			
				//마지막 페이지
				int lastPage = totalRow/rowPerPage;
				
				if(totalRow%rowPerPage != 0){	//lastPage가 나머지 값이 0이 아니면 페이지 한 장 더 추가한다.
					lastPage = lastPage+1;
				}
				
				System.out.printf("total -> %d\n", totalRow);
				System.out.printf("현재 페이지 -> %d\n", currentPage);
				System.out.printf("rowPerPage -> %d\n", rowPerPage);
				System.out.printf("마지막 페이지 -> %d\n\n", lastPage);
				
				//이전-다음 페이지 버튼
				if(currentPage==1 && lastPage!=1){	//1페이지는 다음만 보이도록. 첫페이지=마지막페이지일 때 버튼 안 보이도록 한다.
%>		
					<span>[<%=currentPage%>]</span>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">다음</a>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">&gt;&gt;</a>
					
<%		
				} else if(lastPage==1){ //마지막페이지가 1일 때 아무것도 보이지 않게 한다.
%>		
					<span>[<%=currentPage%>]</span>
<%		
				} else if(currentPage==lastPage){ //마지막 페이지는 이전만 보이도록
%>		
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">이전</a>
					<span>[<%=currentPage%>]</span>
<%		
				} else{	//그 외 이전, 다음 다 보이도록
%>		
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">&lt;&lt;</a>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">이전</a>
					<span>[<%=currentPage%>]</span>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">다음</a>
					<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="button alt small paging">&gt;&gt;</a>
<%		
				}
%>
				<br><span></span><br>
				<form action="<%=request.getContextPath() %>/client/clientList.jsp" method="post" class="formSearch">
					<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
					<input type="text" name="searchWord" class="search" placeholder="검색어를 입력해주세요.">
					<button type ="submit">검색</button>
				</form>
				
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