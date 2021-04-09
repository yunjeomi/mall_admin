<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>

<%
	//insertCommentAction
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집 -> commentNo managerId commentContent
	request.setCharacterEncoding("UTF-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	System.out.println("입력한 noticeNo-> "+noticeNo);
	System.out.println("입력한 commentContent-> "+commentContent);
	System.out.println("managerId-> "+managerId);
	
	//vo 담기
	Comment comment = new Comment();
	comment.setCommentContent(commentContent);
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	
	//메소드 실행 후 재요청
	CommentDao.insertComment(comment);
	System.out.println("*Comment 입력 완료*\n");
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
	
%>