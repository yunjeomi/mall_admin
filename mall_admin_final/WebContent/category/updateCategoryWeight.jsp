<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
    
<%
	//updatedCategoryWeight
	
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//categoryList에서 보내온 값 -> weight, name
	//weight -> 인트형 변환
	//name -> 스트링
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	String categoryName = request.getParameter("categoryName");
	System.out.println("선택한 category-> "+categoryName);
	System.out.println("바꿀 weight-> "+categoryWeight);
	
	//업뎃 메소드 실행
	CategoryDao.updateWeight(categoryWeight, categoryName);
	System.out.println("*weight 수정 완료*\n");
	
	//업뎃 후 화면 이동
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>
</body>
</html>