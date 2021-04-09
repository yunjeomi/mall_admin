<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//updateEbookStateAction

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
	String ebookState = request.getParameter("ebookState");
	System.out.println("선택한 ebookISBN-> "+ebookISBN);
	System.out.println("선택한 ebookState-> "+ebookState);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	//change 메소드 실행
	EbookDao.changeState(ebook);
	System.out.println("*state 변경 완료*\n");

	//실행 후 이동
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);

%>