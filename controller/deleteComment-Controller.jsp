<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String commentId = request.getParameter("CommentId");
    String foodId = request.getParameter("Food_Id");
    Connect con = Connect.getConnection();
    
    String query_delete = String.format("DELETE FROM mscomment WHERE CommentId = ('%s')", commentId);
    con.executeUpdate(query_delete);
    response.sendRedirect("../food-detail.jsp?Food_Id=" + foodId);

%>