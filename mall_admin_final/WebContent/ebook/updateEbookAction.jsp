<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//updateEbookAction
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집
	request.setCharacterEncoding("UTF-8");

	String ebookTitle = request.getParameter("ebookTitle");
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	String ebookSummary = request.getParameter("ebookSummary");
	String ebookState = request.getParameter("ebookState");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	
	System.out.println("ebookTitle-> "+ebookTitle);
	System.out.println("categoryName-> "+categoryName);
	System.out.println("ebookISBN-> "+ebookISBN);
	System.out.println("ebookAuthor-> "+ebookAuthor);
	System.out.println("ebookCompany-> "+ebookCompany);
	System.out.println("ebookSummary-> "+ebookSummary);
	System.out.println("ebookState-> "+ebookState);
	System.out.println("ebookPageCount-> "+ebookPageCount);
	System.out.println("ebookPrice-> "+ebookPrice);
	
	Ebook ebook = new Ebook();
	ebook.setEbookTitle(ebookTitle);
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	
	//update ebook 메소드 실행
	EbookDao.updateEbook(ebook);
	System.out.println("*ebook 수정 완료*\n");
	
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
	
	
%>