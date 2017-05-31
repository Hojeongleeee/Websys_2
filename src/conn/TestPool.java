package conn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import bean.TestBean;

public class TestPool {
	
	private DBConnectionMgr pool = null;
	
	public TestPool() {
 	 try{
 	   pool = DBConnectionMgr.getInstance();
 	   }catch(Exception e){
 	      System.out.println("Error : 커넥션 얻어오기 실패");
 	   }
     }//MemberMgrPool()
 
    public Vector getTestList(String test_no) {
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
	   Vector vecList = new Vector();	   
	   
       try {
          conn = pool.getConnection();
          String strQuery = "select * from test where Test_no ="+test_no;
          stmt = conn.createStatement();
          rs = stmt.executeQuery(strQuery);
		  while (rs.next()) {
             TestBean testBean = new TestBean();
             testBean.setTest_no(Integer.parseInt(rs.getString("Test_no")));
             testBean.setTest_name(rs.getString("Test_name"));
             testBean.setChecklist(rs.getString("Checklist"));
             testBean.setDescription(rs.getString("Description"));
             testBean.setCount(Integer.parseInt(rs.getString("Count")));
             testBean.setVideoURL(rs.getString("VideoURL"));
             vecList.add(testBean);
          }
       } catch (Exception ex) {
          System.out.println("Exception" + ex);
       } finally {
	      pool.freeConnection(conn);
       }
       return vecList;
    }
 }//class