<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>

<%
	//deleteCommentAction
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 -> commentNo managerId noticeNo
	request.setCharacterEncoding("UTF-8");
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));	//삭제 후 페이지 재요청 시 입력
	String managerId = request.getParameter("managerId");
	System.out.println("삭제할 commentNo-> "+commentNo);
	System.out.println("managerId-> "+managerId);
	
	//메소드 실행 후 재요청
	if(managerCk.getManagerLevel() > 1){	//manager.managerLevel == 2
		CommentDao.deleteComment(commentNo);
	} else if(managerCk.getManagerLevel() > 0){	//manager.managerLevel == 1
		if(!managerCk.getManagerId().equals(managerId)){	//레벨1이 자신이 쓴 코멘트가 아닌 다른 코멘트 클릭했을 때 아무 것도 실행되지 않도록 한다.
			System.out.println("*Comment 삭제 권한이 없습니다.*\n");
			System.out.println("managerCk.managerId-> "+managerCk.getManagerId());
			System.out.println("managerId->"+managerId);
			
			response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
			return;
		} 
		CommentDao.deleteComment(commentNo, managerId);
	}
	System.out.println("*Comment 삭제 완료*\n");
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
	
%>