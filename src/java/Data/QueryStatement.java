/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Data;

/**
 *
 * @author TranCamTu
 */
public interface QueryStatement {
    String getAllUsers = "Select * From UserInfo";
    String getAllAdmins = "Select * From Administrator";
    String getAllPosts = "Select * From Post";
    String getAllPostComments = "Select * From PostComment";
    String getAllPostReports = "Select * From PostReport";
    String getAllReportReasons = "Select * From ReportReasonList";
    String getAllPostTags = "Select * From PostTag";
    String getAllTags = "Select * From TagList";
    String getAllUserSeriesLists = "Select * From UserSeriesList";
}
