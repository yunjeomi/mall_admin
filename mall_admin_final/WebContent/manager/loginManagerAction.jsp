<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
	//loginManagerAction

	//1.요청 수집(전처리) : 넘어온 값 - id, pw
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	System.out.printf("로그인 창)입력한 managerId : %s\n", managerId);
	System.out.printf("로그인 창)입력한 managerPw : %s\n", managerPw);
	
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	
	//2.처리 - 로그인 메소드 실행; 로그인 메소드의 데이터형은 Manager이다.
	Manager managerLogin = ManagerDao.login(manager);
	
	if(managerLogin != null){
		System.out.println("*로그인 성공*\n");
		session.setAttribute("sessionManager", managerLogin);	//manager에 id, name, level값을 넣어줬다.
	}
	
	//3.출력 또는 다른 페이지 재요청(redirect)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");

%>