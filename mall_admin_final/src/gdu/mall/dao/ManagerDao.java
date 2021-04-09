package gdu.mall.dao;
import gdu.mall.vo.Manager;
import java.sql.*;
import java.util.*;
import gdu.mall.util.DBUtil;

public class ManagerDao {
	//totalRow
		public static int totalRow() throws Exception{
			int totalCnt = 0;
			
			String sql = "SELECT COUNT(*) cnt FROM manager";
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.printf("totalRow stmt-> %s\n", stmt);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalCnt = rs.getInt("cnt");
			}
			
			return totalCnt;
		}
		
	//승인 대기중인 매니저 목록
	public static ArrayList<Manager> managerListByZero() throws Exception{
		//1. sql
		String sql="SELECT manager_id managerId, manager_date managerDate FROM manager where manager_level=0";
		
		//2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.printf("매니저 level 0 리스트 출력 stmt-> %s\n\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Manager managerList = new Manager();
			managerList.setManagerId(rs.getString("managerId"));
			managerList.setManagerDate(rs.getString("managerDate"));
			list.add(managerList);
		}
		
		//4. 리턴
		return list;
	}
	
	//수정 메소드 update
	public static void updateManagerLevel(Manager manager) throws Exception {
		//1. sql : no가 일치하면 level을 수정해라.
		String sql = "UPDATE manager SET manager_level=? WHERE manager_no=?";
		
		//2. 리턴값 초기화	
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, manager.getManagerLevel());
		stmt.setInt(2, manager.getManagerNo());
		System.out.printf("매니저 level 수정 stmt-> %s\n", stmt);
		
		stmt.executeUpdate();
	}
	
	
	//삭제 메소드 delete
	public static void deleteManager(int managerNo) throws Exception{
		//1. sql : no가 일치하면 행을 지워라.
		String sql = "DELETE FROM manager WHERE manager_no=?";
		
		//2. 리턴값 초기화	
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		System.out.printf("매니저 삭제 stmt-> %s\n", stmt);
		
		stmt.executeUpdate();
	}
	
	
	//매니저List출력 메소드
	public static ArrayList<Manager> managerList(int beginRow, int rowPerPage) throws Exception{
		//1. sql
		String sql="SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_date DESC limit ?,?";
		
		//2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.printf("매니저 List 출력 stmt-> %s\n\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Manager managerList = new Manager();
			managerList.setManagerNo(rs.getInt("managerNo"));
			managerList.setManagerId(rs.getString("managerId"));
			managerList.setManagerName(rs.getString("managerName"));
			managerList.setManagerDate(rs.getString("managerDate"));
			managerList.setManagerLevel(rs.getInt("managerLevel"));
			list.add(managerList);
		}
		
		//4. 리턴
		return list;
	}
	
	
	//insert 매니저등록 메소드
	public static void insertManager(Manager manager) throws Exception{
		//1. sql문
		String sql = "INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) values (?,?,?,now(),0)";
		
		//2. 초기화
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		stmt.setString(2, manager.getManagerPw());
		stmt.setString(3, manager.getManagerName());
		System.out.printf("매니저 등록 stmt-> %s\n", stmt);
		
		stmt.executeUpdate();
	}
	
	
	//insert 매니저등록 중복체크 메소드
	public static String checkManagerId(Manager manager) throws Exception{
		//1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_Id = ?";
		
		//2. 리턴타입 초기화
		String returnManagerId = null;
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		System.out.printf("ID중복체크 stmt-> %s\n", stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnManagerId = rs.getString("manager_Id");
		}
		//4. 리턴
		return returnManagerId;
	}
	
	//로그인 메소드 : id, pw 입력하면 -> manager(id, name, level) 정보를 얻는다
	//SELECT 컬럼을 rs.next로 출력해준다... WHERE은 조건값 
	public static Manager login(Manager manager) throws Exception{
		//1. 실행할 쿼리를 미리 정해놓는다. 매니저 관리창은 레벨1부터 볼 수 있음.
		//받아온 id, pw가 일치하고 레벨 1이상이면 id, name, level을 가져와라. 
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? And manager_level>0";
		
		//2. 리턴값 초기화
		//클래스 Manager내 변수에 여러 값을 넣어주기 위해
		Manager loginManager = new Manager();
		
		//3. db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, manager.getManagerId());
		stmt.setString(2, manager.getManagerPw());
		System.out.printf("매니저 로그인 stmt-> %s\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {	
			loginManager.setManagerId(rs.getString("manager_id"));
			loginManager.setManagerName(rs.getString("manager_name"));
			loginManager.setManagerLevel(rs.getInt("manager_level"));
		}
		//4. 리턴
		return loginManager;
	}
	
}

