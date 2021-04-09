<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//deleteEbookAction
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집
	request.setCharacterEncoding("UTF-8");
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.println("delete ebookISBN-> "+ebookISBN);
	
	//ebook에 값 넣기
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	
	//delete 메소드 실행
	EbookDao.deleteEbook(ebook);
	System.out.println("*삭제 완료*\n");
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");

%>