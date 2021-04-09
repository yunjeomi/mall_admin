<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//updateNoticeAction

	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 -> no, title, content
	request.setCharacterEncoding("UTF-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle= request.getParameter("noticeTitle");
	String noticeContent= request.getParameter("noticeContent");
	
	
	System.out.println("선택한 noticeNo-> "+noticeNo);
	System.out.println("수정한 noticeTitle-> "+noticeTitle);
	System.out.println("수정한 noticeContent-> "+noticeContent);
	
	//메소드 실행 전 값 notice에 넣어주기
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	//update 메소드 실행
	NoticeDao.updateNotice(notice);
	System.out.println("*update 완료*\n");
	
	//메소드 실행 후 one으로 이동. one으로 갈 때 no 같이 준다.
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);


%>