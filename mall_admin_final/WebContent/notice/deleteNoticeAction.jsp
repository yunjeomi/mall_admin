<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>

<%
	//updateNoticeForm
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 -> no
	request.setCharacterEncoding("UTF-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	//매니저 레벨 1일 때는 권한없음을 알려주기 위해
	if(managerCk.getManagerLevel()==1){
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		System.out.println("*공지 삭제 권한이 없습니다.*\n");
		return;
	}
	
	System.out.println("선택한 noticeNo-> "+noticeNo);
	
	//댓글이 있을 경우 삭제가 안 되도록 한다.
	int rowCnt = CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt != 0){
		System.out.printf("%d번 공지글의 댓글이 %d개\n", noticeNo, rowCnt);
		System.out.println("*댓글 삭제 후 공지글 삭제 가능합니다.*\n");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		return;
	}
	
	//notice객체는 생략한다....ㅎ
	//delete 메소드 실행
	NoticeDao.deleteNotice(noticeNo);
	System.out.println("*삭제 완료*\n");

	//실행 후 List로 이동
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");

%>