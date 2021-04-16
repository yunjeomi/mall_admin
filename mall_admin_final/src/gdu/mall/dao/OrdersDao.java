package gdu.mall.dao;
import java.sql.*;
import java.util.*;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;


public class OrdersDao {
	//orders리스트만 x -> orders join ebook join client 리스트
	/*SELECT
	o.orders_no ordersNo,
	o.ebook_isbn ebookISBN,
	e.ebook_title ebookTitle,
	c.client_no clientNo,
	c.client_mail clientMail,
	o.orders_date ordersDate,
	o.orders_state ordersState
	FROM orders o INNER JOIN ebook e INNER JOIN client c
	ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no AND o.ebook_isbn = e.ebook_isbn
	ORDER BY o.orders_no DESC*/
	
	
	public static ArrayList<OrdersAndEbookAndClient> ordersList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, c.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.client_no = c.client_no AND o.ebook_no = e.ebook_no ORDER BY o.orders_date DESC limit ?, ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("ordersList stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		return list;
	}
	
	//totalRow 구하는 메소드
	public static int totalCnt() throws Exception {
		int rowCnt = 0;
		
		String sql = "SELECT COUNT(*) cnt FROM orders";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("totalRow stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		
		return rowCnt;
	}
	
	//ordersStateList 주문상태 리스트 출력 메소드
	public static String[] ordersStateList() {
		String[] stateList = {"주문완료", "주문취소"};
		
		return stateList;
	}
	
	//update ordersState; 주문상태 변경 메소드 no 몇일 때~ 상태를 변경한다.
	public static void updateOrdersState(Orders orders) throws Exception{
		String sql = "UPDATE orders SET orders_state=? WHERE orders_no=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersNo());
		System.out.println("update ordersState stmt-> "+stmt);
		stmt.executeUpdate();
	}
	
	//ebookOne(title클릭) 보기 메소드; ebookNo만 알면 모든 정보를 가져온다.
	public static Ebook ebookOne(Ebook ebook) throws Exception{
		String sql = "SELECT ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_summary ebookSummary, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_no=?";
		
		Ebook ebookOne = new Ebook();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebook.getEbookNo());
		System.out.println("ebookOne stmt-> "+stmt);
		System.out.println();
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			ebookOne.setEbookISBN(rs.getString("ebookISBN"));
			ebookOne.setCategoryName(rs.getString("categoryName"));
			ebookOne.setEbookTitle(rs.getString("ebookTitle"));
			ebookOne.setEbookAuthor(rs.getString("ebookAuthor"));
			ebookOne.setEbookCompany(rs.getString("ebookCompany"));
			ebookOne.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebookOne.setEbookPrice(rs.getInt("ebookPrice"));
			ebookOne.setEbookImg(rs.getString("ebookImg"));
			ebookOne.setEbookSummary(rs.getString("ebookSummary"));
			ebookOne.setEbookDate(rs.getString("ebookDate"));
			ebookOne.setEbookState(rs.getString("ebookState"));
		}
		
		return ebookOne;
	}
}
