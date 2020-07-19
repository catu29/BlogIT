/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataMapper;

import DTO.DTOReportReasonList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class MapperReportReasonList extends MapperBase {
    public boolean insertNewReportReason(String reasonContent) {
        try {
            String query = "Insert Into ReportReasonList (reasonContent) Values (N'" + reasonContent + "');";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new report reason error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean updateReportReason(DTOReportReasonList reason) {
        try {
            String query = "Update Set reasonContent = N'" + reason.getReasonContent() 
                            + "' Where reasonId = " + reason.getReasonId() + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
                                    
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Update report reason error: " + e.getMessage());
            
            return false;
        }
    }
    
    public boolean deleteReportReason(int reasonId) {
        try {
            String query = "Delete From ReportReasonList Where reasonId = " + reasonId + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            return stmt.executeUpdate(query) > 0;
        } catch (Exception e) {
            System.out.println("Insert new report reason error: " + e.getMessage());
            
            return false;
        }
    }
    
    public ArrayList<DTOReportReasonList> getAllReportReasons() {
        try {
            ArrayList<DTOReportReasonList> result = new ArrayList();
            
            String query = "Select * From ReportReasonList;";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOReportReasonList reason = new DTOReportReasonList(rs.getInt("reasonId"), rs.getString("reasonContent"));
                result.add(reason);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Get all report reasons error: " + e.getMessage());
            
            return null;
        }
    }
    
    public DTOReportReasonList searchReportReasonById(int id) {
        try {
            String query = "Select * From ReportReasonList Where reasonId = " + id + ";";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            
            return new DTOReportReasonList(rs.getInt("reasonId"), rs.getString("reasonContent"));
        } catch (Exception e) {
            System.out.println("Search report reason error: " + e.getMessage());
            
            return null;
        }
    }
   
    public ArrayList<DTOReportReasonList> searchReportReasonByContent(String content) {
        try {
            ArrayList<DTOReportReasonList> result = new ArrayList();
            
            String query = "Select * From ReportReasonList Where reasonContent = '"
                    + content + "' or reasonContent like '%"
                    + content + "%';";
            PreparedStatement stmt = connection.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                DTOReportReasonList reason = new DTOReportReasonList(rs.getInt("reasonId"), rs.getString("reasonContent"));
                result.add(reason);
            }
            
            return result;
        } catch (Exception e) {
            System.out.println("Search tags error: " + e.getMessage());
            
            return null;
        }
    }
}
