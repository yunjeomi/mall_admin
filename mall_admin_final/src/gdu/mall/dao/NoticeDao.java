package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;

public class NoticeDao {
	
	//totalRow 구하기 메소드
	public static int totalRow() throws Exception{
		String sql = "SELECT COUNT(*) cnt FROM notice";
		
		int totalCnt = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("totalRow stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalCnt = rs.getInt("cnt");
		}
		
		return totalCnt;
	}
	
	//notice list 출력 메소드 -> no내림차순, 여러리스트가 나와야 하니 어레이리스트 사용하자. 어레이리스트는 리턴값이 따로 없는듯???
	public static ArrayList<Notice> noticeList(int beginRow, int rowPerPage) throws Exception{
		//notice 테이블의 모든 값을 불러온다
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice ORDER BY notice_date DESC LIMIT ?, ?";
		
		//초기화
		ArrayList<Notice> totalList = new ArrayList<>();
		
		//db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("notice list stmt-> "+stmt);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice temp = new Notice();
			temp.setNoticeNo(rs.getInt("noticeNo"));
			temp.setNoticeTitle(rs.getString("noticeTitle"));
			temp.setNoticeContent(rs.getString("noticeContent"));
			temp.setNoticeDate(rs.getString("noticeDate"));
			temp.setManagerId(rs.getString("managerId"));
			totalList.add(temp);
		}
		
		return totalList;
	}
	
	//notice one 출력 메소드 select from where no=?
	public static Notice noticeOne(Notice notice) throws Exception{
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice WHERE notice_no=?";
		
		Notice one = new Notice();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		System.out.println("noticeOne stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			one.setManagerId(rs.getString("managerId"));
			one.setNoticeContent(rs.getString("noticeContent"));
			one.setNoticeDate(rs.getString("noticeDate"));
			one.setNoticeNo(rs.getInt("noticeNo"));
			one.setNoticeTitle(rs.getString("noticeTitle"));
		}
		
		return one;
	}
	
	//insert notice 메소드 리턴값 없이 바로 실행 - insert into 테이블명 (컬럼) value (값)
	public static void insertNotice(Notice notice) throws Exception{
		String sql = "INSERT INTO notice(notice_title, notice_content, manager_id, notice_date) VALUE(?, ?, ?, now())";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getManagerId());
		System.out.println("공지추가 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	//update notice 메소드 update 테이블 set _=? 수정할 값은 title, content
	public static void updateNotice(Notice notice) throws Exception{
		String sql = "UPDATE notice SET notice_title=?, notice_content=? where notice_no=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		System.out.println("update stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	
	//delete notice 메소드 delete from where no=?
	public static void deleteNotice(int noticeNo) throws Exception{
		String sql = "DELETE FROM notice WHERE notice_no=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("delete stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
}
