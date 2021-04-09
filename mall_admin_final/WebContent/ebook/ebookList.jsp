<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookList</title>
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
	//ebookList
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	
	//할 것 : 목록 페이징, 다음버튼, 카테고리 목록메뉴(완)
	
	//수집&초기화
	//현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//rowPerPage
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	//beginRow
	int beginRow = (currentPage-1)*rowPerPage;
	
	//totalRow
	int totalRow = 0;
	
	//목록 메소드 실행하기 위해 초기화
	ArrayList<Ebook> list = new ArrayList<>();
	
	//totalRow with 카테고리 설정&목록 메소드
	//+)카테고리 설정 시 totalRow 바뀔 수 있도록 한다.
	//categoryName = null로 했을 때 보기 목록 선택 시 계속 null로 넘어가서 리스트 출력이 안 됏..ㅠ "null"로 설정했음  
	String categoryName = "null";
	if(request.getParameter("categoryName") == null){
		totalRow = EbookDao.totalRow();
		list = EbookDao.ebookList(beginRow, rowPerPage);
	} else if(request.getParameter("categoryName").equals("null")){
		totalRow = EbookDao.totalRow();
		list = EbookDao.ebookList(beginRow, rowPerPage);
	} else{
		categoryName = request.getParameter("categoryName");
		totalRow = EbookDao.totalrowOfCategoryList(categoryName);
		list = EbookDao.ebookListCategory(beginRow, rowPerPage, categoryName);
	}
	
	//마지막 페이지
		int lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage != 0){
			lastPage += 1;
		}
	
	//디버깅
	System.out.println("totalRow-> "+totalRow);
	System.out.println("beginRow-> "+beginRow);
	System.out.println("rowPerPage-> "+rowPerPage);
	System.out.println("currentPage-> "+currentPage);
	System.out.println("lastPage-> "+lastPage);
	System.out.println("categoryName-> "+categoryName);
	System.out.println("*ebook list 출력*\n");
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
					<h2>ebook 관리</h2>
					<!-- 카테고리별 목록을 볼 수 있는 네비게이션. 카테고리 추가 될 경우 반영 되도록 한다. -->
					<div>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">전체보기</a><!-- 전체보기는 카테고리 null값으로-->
						<%
							ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
							//String은 하나의 값이라 그 값을 넘겨준다.
							//ArrayList일 경우엔 내부에 저장된 값이 여러개이므로 ex.___ 로 값을 가져옴
							for(String s : categoryNameList){	
						%>
								<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
						<%
							}
						%>
					</div>
				</header>
				
				<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
					<input type="hidden" name="categoryName" value="<%=categoryName%>">
					<select name="rowPerPage" class="choice">
				<%	
					for(int i=10; i<=30; i+=5){
						if(rowPerPage == i){
				%>	
						<option value="<%=i%>" selected="selected"><%=i%></option>
				<%		
						} else{
				%>		
						<option value="<%=i%>"><%=i%></option>
				<%	
						}
					}
				%>	
					</select>
					<button type="submit" class="button small">보기</button>
					<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp" class="button small" style="float:right">ebook 추가</a>
				</form>
				
				<!-- rowPerPage별 페이징 -->
				<div class="table-wrapper">
					<table class="alt">
						<thead>
							<tr>
								<th>categoryName</th>
								<th>ebookTitle</th><!-- 상세보기가능 -->
								<th>ebookISBN</th>
								<th>ebookAuthor</th><!-- 검색가능 -->
								<th>ebookPrice</th>
								<th>ebookDate</th><!-- 신간이 먼저 나오도록 -->
								<th>ebookState</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(Ebook eb : list){
						%>
							<tr>
								<td><%=eb.getCategoryName() %></td>
								<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=eb.getEbookISBN()%>"><%=eb.getEbookTitle() %></a></td>
								<td class="align-center"><%=eb.getEbookISBN() %></td>
								<td><%=eb.getEbookAuthor() %></td>
								<td><%=eb.getEbookPrice() %></td>
								<td class="align-center"><%=eb.getEbookDate().substring(0, 11) %></td> <!-- substring(0, 11)년/월/일만 출력 -->
								<td class="align-center"><%=eb.getEbookState() %></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
				</div>
			<%
				//다음 버튼 만들기
				//카테고리 선택했을 때, 선택하지 않았을 때 2개로 나눠서
				//페이지 1일때, 1페이지=랏페이지일때, 마지막일때, 그 사이
				//+)검색기능 넣었을 때,,, if문 중첩,,,
				if(categoryName != null){	//카테고리 선택했을 때->카테고리 같이 넘겨준다.
					if(currentPage == 1 && lastPage > 1){	//다음 버튼만 보이도록
			%>		
						<span>[<%=currentPage %>]</span>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">다음</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">&gt;&gt;</a>
			<%		
					} else if(currentPage == 1 || lastPage == 1 ){	//아무것도 안 보이도록
			%>		
						<span>[<%=currentPage%>]</span>
			<%		
					} else if(currentPage == lastPage){	//이전 버튼만 보이도록
			%>		
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">&lt;&lt;</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">이전</a>
						<span>[<%=currentPage %>]</span>
			<%		
					} else{	//전부 보이도록
			%>		
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">&lt;&lt;</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">이전</a>
						<span>[<%=currentPage %>]</span>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">다음</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>" class="button alt small paging">&gt;&gt;</a>
			<%		
					}
				}  else{
					//다음 버튼 만들기
					//1일때, 마지막일때, 그 사이
					if(currentPage == 1 && lastPage > 1){	//다음 버튼만 보이도록
			%>		
						<span>[<%=currentPage %>]</span>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">다음</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">&gt;&gt;</a>
			<%		
					} else if(lastPage == 1 || currentPage == 0){	//아무것도 안 보이도록
			%>		
						<span>[<%=currentPage%>]</span>
			<%		
					} else if(currentPage == lastPage){	//이전 버튼만 보이도록
			%>		
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>" class="button alt small paging">&lt;&lt;</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">이전</a>
						<span>[<%=currentPage %>]</span>
			<%		
					} else{	//전부 보이도록
			%>		
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>" class="button alt small paging">&lt;&lt;</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">이전</a>
						<span>[<%=currentPage %>]</span>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&beginRow=<%=beginRow%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">다음</a>
						<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>" class="button alt small paging">&gt;&gt;</a>
			<%		
					}
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
