<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//insertCategoryAction

	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//insertCategoryForm에서 받은 값 -> name, weight
	//name -> 스트링
	//weight -> 스트링에서 인트형 변환
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	System.out.println("추가할 categoryName-> "+categoryName);
	System.out.println("부여할 categoryWeight-> "+categoryWeight);
	
	//중복 확인 후 중복 없을 경우 추가 실행되도록
	//리턴값 != null 중복
	//리턴값 == null 중복아님
	String checkCategoryName = null;
	checkCategoryName = CategoryDao.checkCategoryName(categoryName);
	if(checkCategoryName != null){
		System.out.println("*카테고리명 중복입니다.*\n");
		response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
		return;
	}
	
	//중복 아닐 경우 전처리 후 기존의 값을 넣어준다.
	System.out.println("*카테고리명 사용 가능합니다.*");
	Category category = new Category();
	category.setCategoryName(categoryName);
	category.setCategoryWeight(categoryWeight);
	
	//카테고리 추가 메소드 실행
	CategoryDao.insertCategory(category);
	System.out.println("*카테고리 추가 완료*\n");
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
	
%>
