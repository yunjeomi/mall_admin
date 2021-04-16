package gdu.mall.dao;

import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;

public class EbookDao {	//sql->초기화->db->리턴

	//set ebook state 설정 메소드 - 판매중, 품절, 절판, 구편 
	public static String[] setEbookState() {
		String[] state = {"판매중", "품절", "구편", "절판"};
		
		return state;
	}
		
		
	//delete 메소드
	public static void deleteEbook(Ebook ebook) throws Exception{
		String sql = "DELETE FROM ebook WHERE ebook_isbn=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		System.out.println("delete ebook stmt-> "+stmt);
		
		stmt.executeUpdate();		
	}
	
	//update ebook 메소드
	public static void updateEbook(Ebook ebook) throws Exception{
		String sql = "UPDATE ebook SET ebook_title=?, category_name=?, ebook_author=?, ebook_company=?, ebook_summary=?, ebook_state=?, ebook_page_count=?, ebook_price=? WHERE ebook_isbn=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookTitle());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookAuthor());
		stmt.setString(4, ebook.getEbookCompany());
		stmt.setString(5, ebook.getEbookSummary());
		stmt.setString(6, ebook.getEbookState());
		stmt.setInt(7, ebook.getEbookPageCount());
		stmt.setInt(8, ebook.getEbookPrice());
		stmt.setString(9, ebook.getEbookISBN());
		System.out.println("update ebook stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
		
	//change state 메소드
		public static void changeState(Ebook ebook) throws Exception{
			String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
			
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookState());
			stmt.setString(2, ebook.getEbookISBN());
			System.out.println("state변경 stmt-> "+stmt);
			
			stmt.executeUpdate();
		}
	
	//update summary 메소드
	public static void updateEbookSummary(Ebook ebook) throws Exception{
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		System.out.println("update summary stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	//update img 메소드
	public static void updateEbookImg(Ebook ebook) throws Exception{
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		System.out.println("update img stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	//ebookOne(title클릭) 보기 메소드; No만 알면 모든 정보를 가져온다.
	public static Ebook ebookOne(Ebook ebook) throws Exception{
		String sql = "SELECT ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_summary ebookSummary, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn=?";
		
		Ebook ebookOne = new Ebook();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
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
	
	
	//insert ebook 추가 메소드
	public static void insertEbook(Ebook ebook) throws Exception{
		//sql
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) values(?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', now(), '판매중')";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		System.out.println("ebook insert stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	//ISBN 중복체크 메소드
	public static String checkISBN(Ebook ebook) throws Exception{
		//sql : select from where
		String sql = "SELECT ebook_isbn FROM ebook WHERE ebook_isbn=?";
		String checkISBN = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		System.out.println("checkISBN stmt-> "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			checkISBN = rs.getString("ebook_isbn");
		}
		
		return checkISBN;
	}
	
	
	
	//non category ebookList 메소드
	public static ArrayList<Ebook> ebookList(int beginRow, int rowPerPage) throws Exception{
		//sql : 보여줄 값 -> name, isbn, title, author, date, price
		//초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_state ebookState from ebook order by ebook_date desc limit ?, ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.printf("ebook list stmt-> %s\n\n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook eb = new Ebook();
			eb.setEbookNo(rs.getInt("ebookNo"));
			eb.setCategoryName(rs.getString("categoryName"));
			eb.setEbookISBN(rs.getString("ebookISBN"));
			eb.setEbookTitle(rs.getString("ebookTitle"));
			eb.setEbookAuthor(rs.getString("ebookAuthor"));
			eb.setEbookDate(rs.getString("ebookDate"));
			eb.setEbookPrice(rs.getInt("ebookPrice"));
			eb.setEbookState(rs.getString("ebookState"));
			list.add(eb);
		}
		//리턴
		return list;
	}
	
	//category ebookList 메소드
	public static ArrayList<Ebook> ebookListCategory(int beginRow, int rowPerPage, String categoryName) throws Exception{
		//sql : 보여줄 값 -> name, isbn, title, author, date, price
		//초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice, ebook_state ebookState from ebook where category_name=? order by ebook_date desc limit ?, ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		System.out.printf("ebook list with category stmt-> %s\n\n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook eb = new Ebook();
			eb.setEbookNo(rs.getInt("ebookNo"));
			eb.setCategoryName(rs.getString("categoryName"));
			eb.setEbookISBN(rs.getString("ebookISBN"));
			eb.setEbookTitle(rs.getString("ebookTitle"));
			eb.setEbookAuthor(rs.getString("ebookAuthor"));
			eb.setEbookDate(rs.getString("ebookDate"));
			eb.setEbookPrice(rs.getInt("ebookPrice"));
			eb.setEbookState(rs.getString("ebookState"));
			list.add(eb);
		}
		//리턴
		return list;
	}
	
	//total ebook list row 메소드
	public static int totalRow() throws Exception{
		//sql -> select count(*)
		int totalCnt = 0;
		
		String sql = "select count(*) cnt from ebook";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.printf("totalListRow stmt-> %s\n\n",stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalCnt = rs.getInt("cnt");
		}
		
		return totalCnt;
	}
	
	//category list row 메소드
	public static int totalrowOfCategoryList(String categoryName) throws Exception{
		int totalCnt = 0;
		
		String sql = "SELECT COUNT(category_name) cnt FROM ebook WHERE category_name=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		System.out.println("categoryListRow stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalCnt = rs.getInt("cnt");
		}
		
		return totalCnt;
	}
}
