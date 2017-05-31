package conn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import bean.BoardBean;

public class BoardPool {
	
	private DBConnectionMgr pool = null;
	
	public BoardPool() {
 	 try{
 	   pool = DBConnectionMgr.getInstance();
 	   }catch(Exception e){
 	      System.out.println("Error : 커넥션 얻어오기 실패");
 	   }
     }//BoardPool()
 
    public Vector getBoardList(String mem_no) {
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
	   Vector vecList = new Vector();	   
	   
       try {
          conn = pool.getConnection();
          String strQuery = "select * from board";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(strQuery);
		  while (rs.next()) {
             BoardBean boardBean = new BoardBean();
             boardBean.setItem_no(Integer.parseInt(rs.getString("Item_no")));
             boardBean.setMem_no(Integer.parseInt(rs.getString("Mem_no")));
             boardBean.setTimestamp(rs.getString("TIMESTAMP"));
             boardBean.setCount(Integer.parseInt(rs.getString("Count")));
             boardBean.setTitle(rs.getString("Title"));
             boardBean.setContents(rs.getString("Contents"));
             vecList.add(boardBean);
          }
       } catch (Exception ex) {
          System.out.println("Exception" + ex);
       } finally {
	      pool.freeConnection(conn);
       }
       return vecList;
    }
 }//class