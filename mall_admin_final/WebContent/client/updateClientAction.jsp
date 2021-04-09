<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//updateClientAction

	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//업뎃 폼에서 넘겨준 값 -> mail, pw
	String clientMail =request.getParameter("clientMail");
	String clientPw = request.getParameter("clientPw");
	System.out.println("선택한 mail ->"+clientMail);
	System.out.println("선택한 pw ->"+clientPw);
	
	//vo에 넣기
	Client client = new Client();
	client.setClientMail(clientMail);
	client.setClientPw(clientPw);
	
	//업뎃 메소드 실행
	ClientDao.updateClient(client);
	System.out.println("*client 수정 완료*\n");
	
	//수정했든 안 했든 List로 이동
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>