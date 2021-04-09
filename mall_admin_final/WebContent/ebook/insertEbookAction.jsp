<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//insertEbookAction
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	//꼭 return을 넣어줘야함. 안 넣으면 계속 실행됨
	}
	
	request.setCharacterEncoding("UTF-8");

	//수집
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	//디버깅
	System.out.println("categoryName-> "+categoryName);
	System.out.println("ebookISBN-> "+ebookISBN);
	System.out.println("ebookTitle-> "+ebookTitle);
	System.out.println("ebookAuthor-> "+ebookAuthor);
	System.out.println("ebookCompany-> "+ebookCompany);
	System.out.println("ebookPrice-> "+ebookPrice);
	System.out.println("ebookPageCount-> "+ebookPageCount);
	System.out.println("ebookSummary-> "+ebookSummary);
	System.out.println();
	
	//ISBN 중복 체크위한 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	
	//중복 메소드 실행
	String checkISBN = null;
	checkISBN = EbookDao.checkISBN(ebook);
	if(checkISBN != null){
		System.out.println("*ISBN 중복*\n");
		response.sendRedirect(request.getContextPath()+"/ebook/insertEbookForm.jsp");
		return;
	}
	
	//남은 값 전처리; 위의 수집한 값을 ebook에 넣는 작업
	//dao 메소드에 매개변수 마구잡이로 넣을 필요 없어짐.
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookSummary(ebookSummary);
	
	//입력 메소드 실행
	EbookDao.insertEbook(ebook);
	System.out.println("*ebook추가 완료*\n");
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
	
%>