package conn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import bean.TestDoneBean;

public class TestDonePool {
	
	private DBConnectionMgr pool = null;
	
	public TestDonePool() {
 	 try{
 	   pool = DBConnectionMgr.getInstance();
 	   }catch(Exception e){
 	      System.out.println("Error : 커넥션 얻어오기 실패");
 	   }
     }//MemberMgrPool()
 
    public Vector getTestDoneList(String mem_no) {
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
	   Vector vecList = new Vector();	   
	   
       try {
          conn = pool.getConnection();
          String strQuery = "select * from test_done where Mem_no = "+mem_no;
          stmt = conn.createStatement();
          rs = stmt.executeQuery(strQuery);
		  while (rs.next()) {
             TestDoneBean testDoneBean = new TestDoneBean();
             testDoneBean.setTest_no(Integer.parseInt(rs.getString("Test_no")));
             testDoneBean.setMem_no(Integer.parseInt(rs.getString("Mem_no")));
             testDoneBean.setResult(Integer.parseInt(rs.getString("Result")));
             testDoneBean.setTimestamp(rs.getString("TIMESTAMP"));             
             vecList.add(testDoneBean);
          } 
       } catch (Exception ex) {
          System.out.println("Exception" + ex);
       } finally {
	      pool.freeConnection(conn);
       }
       return vecList;
    }
    
    
    public void setTestDoneList(int test_no, int mem_no, int result){
 	   Connection conn = null;
 	   Statement stmt = null;
 	   Vector vecList = new Vector();	   
 	   
        try {
           conn = pool.getConnection();
           String strQuery = "insert into test_done (Test_no, Mem_no, Result) values ("+test_no+","+mem_no+","+result+")";
           stmt = conn.createStatement();
           int rs = stmt.executeUpdate(strQuery);
        } catch (Exception ex) {
           System.out.println("Exception" + ex);
        } finally {
 	      pool.freeConnection(conn);
        }
    }
 }//class