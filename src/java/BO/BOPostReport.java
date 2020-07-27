/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOPostReport;
import DTO.DTOReportReasonList;
import DataMapper.MapperPostReport;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOPostReport {
    MapperPostReport mapper = new MapperPostReport();
    
    public ArrayList<DTOPostReport> getAllPostReport() {
        return mapper.getAllPostReport();
    }
    
    public ArrayList<DTOReportReasonList> getAllReportsForPost(int postId) {
        return mapper.getAllReportsForPost(postId);
    }
    
    public ArrayList<DTOReportReasonList> getAllReportsForPostByUser(int postId, int userId) {
        return mapper.getAllReportsForPostByUser(postId, userId);
    }
    
    public boolean insertNewReport(DTOPostReport report) {
        return mapper.insertNewReport(report);
    }
    
    public boolean deleteReport(int reportId) {
        return mapper.deleteReport(reportId);
    }
    
    public boolean deletePostReport(int postId) {
        return mapper.deletePostReport(postId);
    }
}
