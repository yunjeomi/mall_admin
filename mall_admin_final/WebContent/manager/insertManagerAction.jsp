<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	//insertManagerAction

	//1. 수집
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	System.out.printf("매니저 등록)입력한 managerId : %s\n",managerId);
	System.out.printf("매니저 등록)입력한 managerPw : %s\n",managerPw);
	System.out.printf("매니저 등록)입력한 managerName : %s\n",managerName);
	
	//vo에 넣어주기 set
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);
	
	//2. id 중복 체크
	String returnManagerId = ManagerDao.checkManagerId(manager);
	
	//2-1. 중복된 아이디 있으면 인서트폼으로
	if(returnManagerId != null){
		System.out.println("사용중인 id입니다.\n");
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp");
		return; //사용중인 id 출력하고, 요청하고, 끝내기. jsp파일은 중간에 내용을 끝내려면 return 사용 가능함.
	}
	
	//2-2. 중복된 아이디 없으면 바로 진행&입력. 
	//위에 if문을 사용했으나 굳이 else를 사용하여 코드를 복잡하게 만들 필요 없음 
	ManagerDao.insertManager(manager);
	System.out.println("*매니저 등록완료*\n");
	
	//3. 출력

%>
	<div>매니저 등록 성공. 승인 후 사용 가능합니다.</div>
	<div><a href="<%=request.getContextPath()%>/adminIndex.jsp">홈으로</a></div>
</body>
</html>