/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPostReport;
import DTO.DTOReportReasonList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperPostReport extends MapperBase {
    public MapperPostReport() {
        super();
    }
    
    public ArrayList<DTOPostReport> getAllPostReport() {
        try {
            ArrayList<DTOPostReport> result = new ArrayList();
            
            String query = "Select * From PostReport order by reportTime desc;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                        
                DTOPostReport pr = new DTOPostReport(rs.getInt("reportId"), rs.getInt("userId"), rs.getInt("postId"), rs.getInt("reportReasonId"), rs.getDate("reportTime"));
                
                result.add(pr);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all post report error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOReportReasonList> getAllReportsForPost(int postId) {
        try {
            ArrayList<DTOReportReasonList> result = new ArrayList();
            
            String query = "select ReportReasonList.reasonId, ReportReasonList.reasonContent "
                           + "from ReportReasonList inner join PostReport "
                           + "on ReportReasonList.reasonId = PostReport.reasonId "
                           + "where PostReport.postId = " + postId + " order by reportTime desc;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOReportReasonList reason = new DTOReportReasonList(rs.getInt("reasonId"), rs.getString("reasonContent"));
                result.add(reason);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all reports for post error: " + e.getMessage());
            
            return null;
        }
    }
    
    public ArrayList<DTOReportReasonList> getAllReportsForPostByUser(int postId, int userId) {
        try {
            ArrayList<DTOReportReasonList> result = new ArrayList();
            
            String query = "select ReportReasonList.reasonId, ReportReasonList.reasonContent "
                           + "from ReportReasonList inner join PostReport "
                           + "on ReportReasonList.reasonId = PostReport.reasonId "
                           + "where PostReport.postId = " + postId + " and PostReport.userId = " + userId + " order by reportTime desc;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOReportReasonList reason = new DTOReportReasonList(rs.getInt("reasonId"), rs.getString("reasonContent"));
                result.add(reason);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all reports for post by user error: " + e.getMessage());
            
            return null;
        }
    }
    
    public boolean insertNewReport(DTOPostReport report) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); 
            String query = "Insert into PostReport(userId, postId, reasonId, reportTime) values ("
                         + report.getUserId() + ", "
                         + report.getPostId() + ", "
                         + report.getReportReasonId() + ", '"
                         + formatter.format(report.getReportTime()) + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new report error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteReport(int reportId) {
        try {
            String query = "Delete From PostReport Where reportId = " + reportId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete report error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deletePostReport(int postId) {
        try {
            String query = "Delete From PostReport Where postId = " + postId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Delete all reports of post error: " + e.getMessage());
            
            return false;
        }
    }
}
