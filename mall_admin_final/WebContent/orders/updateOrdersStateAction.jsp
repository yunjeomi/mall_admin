<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%
	//updateOrdersStateAction
	
	//이 페이지는 manager만 볼 수 있도록 한다.
	//login page에서 받아온 sessionManager값이 있는 지? 없는 지?
	Manager managerCk = (Manager)session.getAttribute("sessionManager");
	if(managerCk == null || managerCk.getManagerLevel()<1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	//수집 ordersNo, ordersState +)beginRow, currentPage
	request.setCharacterEncoding("UTF-8");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int beginRow = Integer.parseInt(request.getParameter("beginRow"));
	System.out.println("ordersNo-> "+ordersNo);
	System.out.println("ordersState-> "+ordersState);
	System.out.println("currentPage-> "+currentPage);
	System.out.println("beginRow-> "+beginRow);
	
	//vo에 값 넣어주기
	Orders orders = new Orders();
	orders.setOrdersNo(ordersNo);
	orders.setOrdersState(ordersState);
	
	//update 메소드 실행 후 페이지 재요청
	OrdersDao.updateOrdersState(orders);
	System.out.println("*State 수정 완료*\n");
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp?currentPage="+currentPage+"&beginRow="+beginRow);

%>