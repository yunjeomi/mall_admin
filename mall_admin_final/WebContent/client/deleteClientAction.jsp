<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>

<%
	//deleteClientAction
	
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집
	request.setCharacterEncoding("UTF-8");
	String clientMail = request.getParameter("clientMail");
	System.out.println("선택한 mail->"+clientMail);
	
	//삭제 메소드 실행 후 페이지 재요청
	ClientDao.deleteClient(clientMail);
	System.out.println("*client 삭제 완료*\n");
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>