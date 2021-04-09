package gdu.mall.dao;

import java.util.ArrayList;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.sql.*;

public class CommentDao {
	//
	public static int selectCommentCnt(int noticeNo) throws Exception{
		int rowCnt = 0;
		String sql = "select count(*) cnt from comment where notice_no=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("commentList stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			rowCnt = rs.getInt("cnt");
		}
		
		return rowCnt;
	}
	
	//insert comment
	public static void insertComment(Comment comment) throws Exception {
		String sql = "INSERT INTO comment(notice_no, manager_id, comment_content, comment_date) value(?, ?, ?, now())";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		System.out.println("comment입력 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	
	//commentList;  select * from 테이블명 where notice_no=? commentNo 오름차순으로
	public static ArrayList<Comment> commentList(int noticeNo) throws Exception{
		String sql = "SELECT comment_no commentNo, notice_no noticeNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		
		ArrayList<Comment> list = new ArrayList<>();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println("commentList stmt-> "+stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Comment temp = new Comment();
			temp.setCommentContent(rs.getString("commentContent"));
			temp.setCommentDate(rs.getString("commentDate"));
			temp.setCommentNo(rs.getInt("commentNo"));
			temp.setManagerId(rs.getString("managerId"));
			temp.setNoticeNo(rs.getInt("noticeNo"));
			list.add(temp);
		}
		return list;
	}
	
	//deleteComment 메소드 오버로딩
	//삭제; 레벨 2일 때 전부 삭제가능
	public static void deleteComment(int commentNo) throws Exception {	//commentNo
		String sql = "DELETE FROM comment WHERE comment_no=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		System.out.println("comment삭제 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
	//삭제; 레벨 1일 때는 내 것만 삭제가능
	public static void deleteComment(int commentNo, String managerId) throws Exception {	//commentNo, managerId
		String sql = "DELETE FROM comment WHERE comment_no=? and manager_id=?";
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		System.out.println("comment삭제 stmt-> "+stmt);
		
		stmt.executeUpdate();
	}
}
