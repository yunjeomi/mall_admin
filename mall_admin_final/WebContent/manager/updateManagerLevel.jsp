<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.Manager" %>
<%@ page import = "gdu.mall.dao.ManagerDao" %>
<%
	//updateManagerLevel

	//이 페이지는 주소창에서 주소 검색하면 바로 올 수 있으므로,
	//이 페이지에 도달하면 다른 곳으로 강제로 보내버리자
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집 - no, level
	request.setCharacterEncoding("UTF-8");
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	
	//디버깅
	System.out.println("수정하는 managerNo->"+managerNo);
	System.out.println("수정하려는 managerLevel->"+managerLevel);
	
	Manager manager = new Manager();
	manager.setManagerNo(managerNo);
	manager.setManagerLevel(managerLevel);
	
	//메소드 실행 후 페이지 재 요청
	ManagerDao.updateManagerLevel(manager);
	System.out.println("*매니저 level 수정 완료*\n");
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>
