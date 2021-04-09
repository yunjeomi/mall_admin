<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();	//세션 정보 초기화
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");

%>