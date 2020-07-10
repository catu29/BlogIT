/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOPostReport;
import DTO.DTOReportReasonList;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

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
            
            String query = "Select * From PostReport;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Date reportDate = rs.getDate("reportTime");
                Calendar reportCalendar = Calendar.getInstance();
                reportCalendar.setTime(reportDate);
                        
                DTOPostReport pr = new DTOPostReport(rs.getInt("reportId"), rs.getInt("userId"), rs.getInt("postId"), rs.getInt("reportReasonId"), reportCalendar);
                
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
                           + "where PostReport.postId = " + postId + ";";
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
                           + "where PostReport.postId = " + postId + " and PostReport.userId = " + userId + ";";
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
            String query = "Insert into PostReport(userId, postId, reasonId, reportTime) values ("
                         + report.getUserId() + ", "
                         + report.getPostId() + ", "
                         + report.getReportReasonId() + ", '"
                         + report.getReportTime() + "');";
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
}
