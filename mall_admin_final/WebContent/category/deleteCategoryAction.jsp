<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page %>
<%
	//deleteCategoryAction
	
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//categoryList에게 받은 값 -> categoryName
	//name -> 스트링
	String categoryName = request.getParameter("categoryName");
	System.out.println("삭제할 category-> "+categoryName);
	
	//삭제 메소드 실행 -> 받은 값;이름 넣어준다
	CategoryDao.deleteCategory(categoryName);
	System.out.println("*카테고리 삭제완료*\n");

	//메소드 실행 후 categoryList페이지로 이동
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");

%>