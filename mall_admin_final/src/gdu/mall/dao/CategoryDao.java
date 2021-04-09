package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;

public class CategoryDao {	//1. sql	2.리턴값 초기화	3.db핸들링	4.리턴
	
	//카테고리 목록 불러오기 메소드
	public static ArrayList<String> categoryNameList() throws Exception{
		//1.
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight DESC";
		
		//2.
		ArrayList<String> list = new ArrayList<>();
		
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("category name list 출력 stmt-> "+stmt);
		System.out.println();
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			String c = rs.getString("categoryName");
			list.add(c);
		}
		//4.
		return list;
	}
	
	//카테고리 목록 불러오기 메소드
	public static ArrayList<Category> categoryList() throws Exception{
		//1.
		String sql = "SELECT category_name categoryName, category_weight categoryWeight FROM category ORDER BY category_weight DESC";
		
		//2.
		ArrayList<Category> list = new ArrayList<>();
		
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("category list 출력 stmt-> "+stmt);
		System.out.println("*list출력완료*\n");
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryWeight(rs.getInt("categoryWeight"));
			list.add(c);
		}
		
		//4.
		return list;
	}
	
	//카테고리 이름 중복 체크 후 추가하는 메소드
	public static void insertCategory(Category category) throws Exception{
		//1. sql : insert into 테이블명(컬럼1, 컬럼2) values(값1, 값2);
		//넣어줄 값은 이름, 가중치, 날짜. 날짜는 자동생성
		String sql = "INSERT INTO category(category_name, category_weight, category_date) VALUES(?, ?, now())";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryWeight());
		System.out.println("category insert stmt-> "+stmt);
		stmt.executeUpdate();
	}
	
	//카테고리 중복 체크 메소드
	public static String checkCategoryName(String categoryName) throws Exception{
		//sql : select from where
		String sql = "SELECT category_name FROM category WHERE category_name=?";
		
		String checkCategoryName = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println("check categoryName stmt-> "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			checkCategoryName = rs.getString("category_name");
		}
		
		return checkCategoryName;
	}
	
	
	
	//카테고리 삭제 메소드
	public static void deleteCategory(String categoryName) throws Exception{
		//1. 받아온 값 카테고리이름이 일치하면 해당 카테고리를 지우자
		//삭제 sql : delete from 테이블명 where 특정열=지울행의값
		String sql ="DELETE FROM category WHERE category_name=?";
		
		//2. 리턴값 없음
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println("category delete stmt-> "+stmt);
		
		//4. 실행
		stmt.executeUpdate();
	}
	
	//카테고리 weight 수정 메소드
	public static void updateWeight(int categoryWeight, String categoryName) throws Exception{
		//1. 수정 sql : update 테이블명 set 특정열=수정할값 where 특정열=수정할행의값
		String sql = "UPDATE category SET category_weight=? WHERE category_name=?";
		
		//2. 리턴값 없음
		//3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight);
		stmt.setString(2, categoryName);
		System.out.println("weight update stmt->"+stmt);
		
		//4. 실행
		stmt.executeUpdate();
	}
}
