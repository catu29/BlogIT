/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DTO.DTOReportReasonList;
import DataMapper.MapperReportReasonList;
import java.util.ArrayList;

/**
 *
 * @author TranCamTu
 */
public class BOReportReason {
    
    MapperReportReasonList mapper = new MapperReportReasonList();
        
    public boolean insertNewReportReason(String reasonContent) {
        return mapper.insertNewReportReason(reasonContent);
    }
    
    public boolean updateReportReason(DTOReportReasonList reason) {
        return mapper.updateReportReason(reason);
    }
    
    public boolean deleteReportReason(int reasonId) {
        return mapper.deleteReportReason(reasonId);
    }
    
    public ArrayList<DTOReportReasonList> getAllReportReasons() {
        return mapper.getAllReportReasons();
    }
    
    public DTOReportReasonList searchReportReasonById(int id) {
        return mapper.searchReportReasonById(id);
    }
    
    public ArrayList<DTOReportReasonList> searchReportReasonByContent(String content) {
        return mapper.searchReportReasonByContent(content);
    }
}
