<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//insertNoticeAction
	//공지 제목은 중복되어도 상관 없을 듯..? -> 중복처리하지 않음
	
	//R(list, one->레벨1이상)UD(->레벨2이상)
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집 - title, content
	request.setCharacterEncoding("UTF-8");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String managerId = managerCk.getManagerId();
	System.out.println("입력한 title-> "+noticeTitle);
	System.out.println("입력한 content-> "+noticeContent);
	System.out.println("사용자id-> "+managerId);
	
	//vo에 넣기
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setManagerId(managerId);
	
	//메소드 실행
	NoticeDao.insertNotice(notice);
	System.out.println("*공지 등록 완료*\n");
	
	//실행 후 보내기
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");

%>