package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;

public class ClientDao {
	//update 업뎃 메소드
	public static void updateClient(Client client) throws Exception{
		//1. sql 작성 : mail이 일치하면 pw 수정(암호화)
		String sql = "UPDATE client SET client_pw=PASSWORD(?) WHERE client_mail=(?)";
		
		//2. 리턴값 초기화
		
		//3. db핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, client.getClientPw());
		stmt.setString(2, client.getClientMail());
		System.out.println("update client stmt->"+stmt);
		
		stmt.executeUpdate();
	}
	
	
	//삭제 메소드
	public static void deleteClient(String clientMail) throws Exception {
		//1. sql 작성 -> clientNo와 clientMail의 값이 일치하면 삭제한다.
		String sql = "DELETE FROM client WHERE client_mail=?";
		
		//2. 리턴값 초기화
		
		//3. db핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		System.out.println("client delete stmt->"+stmt);
		
		stmt.executeUpdate();
	}
	
	//전체 행의 수
	public static int totalCount(String searchWord) throws Exception{
		//1. sql : 전체 행의 수를 보여준다.
		//->검색어 sql 추가로 수정함.
		
		//2. 리턴값 초기화
		int totalRow = 0;
		
		//3. db핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		if(searchWord.equals("")) {	//검색어 없으면 기존 쿼리
			String sql = "SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
			System.out.println("non searchWord");
		} else {	//검색어 있으면 새로운 쿼리
			String sql = "SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			System.out.println("searchWord!!");
		}
		
		System.out.println("전체 행의 수 stmt ->"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		//4. 리턴
		return totalRow;
	}
	
	
	//고객 목록 페이징 메소드
	public static ArrayList<Client> clientListByPage(int beginRow, int rowPerPage, String searchWord) throws Exception {
		//1. sql : 고객 목록을 1페이지 당 rowPerPage씩 볼 수 있도록 한다.
		//client mail, date가져오기. date 내림차순으로. limit 보여줄행, 페이지 당 행의수
		//-> 검색어 sql 추가로 수정함.
		
		//2. 리턴값 초기화
		ArrayList<Client> list = new ArrayList<Client>();
		
		//3. db핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		//쿼리 나누기
		//고객 목록을 1페이지 당 rowPerPage씩 볼 수 있도록 한다.
		//client mail, date가져오기. date 내림차순으로. limit 보여줄행, 페이지 당 행의수
		if(searchWord.equals("")) {	//검색어 없으면 기존 쿼리
			String sql = "SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
		} else {	//검색어 있으면 새로운 쿼리
			String sql = "SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println("검색어->"+searchWord);
		}
		
		System.out.println("고객 목록 페이징 stmt->"+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		//class Client의 객체c를 만들어 mail, date를 넣어주고
		//c를 list안에 넣어준다.
		while(rs.next()) {
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		
		//4. 리턴
		return list;
	}
}
