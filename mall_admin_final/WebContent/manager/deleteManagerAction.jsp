<%@page import="gdu.mall.dao.ManagerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.Manager" %>
<%
	//deleteManagerAction

	//이 페이지는 manager level 2만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지? & 매니저 관리자 레벨 2만 볼 수 있도록
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	//꼭 return을 넣어줘야함. 안 넣으면 계속 실행됨
	}

	//수집
	request.setCharacterEncoding("UTF-8");
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	
	//디버깅
	System.out.println("선택한 managerNo-> "+managerNo);
	
	//dao 삭제 메소드 실행 후 페이지 재요청
	ManagerDao.deleteManager(managerNo);
	System.out.println("*매니저 삭제 완료*n");
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>
