<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>

<%
	//updateEbookImgAction
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//form에서 enctype="multipart/form-data"로 넘기면 넘어온 값이 문자열이 아니기 때문에 request.getParameter("")로 받을 수 없다.
	//String ebookISBN = request.getParameter("ebookISBN");
	//String ebookImg = request.getParameter("ebookImg");
	//System.out.println("ebookISBN-> "+ebookISBN); -> null 출력
	//System.out.println("ebookImg-> "+ebookImg); -> null 출력
	
	//파일을 다운로드 받을 위치
	//application->해당 프로젝트의 톰캣. getRealPath("img")->"img"폴더를 찾아주세요
	//img라는 폴더의 os상의 실제 폴더
	String path = "D:/gooo/web/mall_admin/WebContent/img";
	System.out.println("img path-> "+path);
	
	//뭘 넣어주나?
	//멀티-는 나중에 가서 사용하진 않음,, 매개변수는 5개 들어감.
	//request.getparameter는 사용할 수 없으나 request는 가능하니, request를 위임?
	//파일을 저장할 곳
	//저장할 사이즈 -> 바이트 단위
	//인코딩, 해석할 방법
	//new DefaultFileRenamePolicy() -> 중복 이름이 있으면 얘가 알아서 처리함
	int size = 1024 * 1024 * 100; //100MB ( 1024*1024*1024 = 1GB)
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	String ebookISBN = multi.getParameter("ebookISBN");
	
	//getFilesystemName() -> new DefaultFileRenamePolicy()에 의해 바뀐 이름
	String ebookImg = multi.getFilesystemName("ebookImg");	
	System.out.println("ebookISBN-> "+ebookISBN);
	System.out.println("ebookImg-> "+ebookImg);
	
	//ebook에 값 저장
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	
	//update img 메소드 실행
	EbookDao.updateEbookImg(ebook);
	System.out.println("*img 수정 완료*\n");
	
	//메소드 실행 후 ebookOne으로 가라
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
	
	
%>