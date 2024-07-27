<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String food_id = request.getParameter("FoodId");
    Connect con = Connect.getConnection();
    
    String query_delete = String.format("DELETE FROM msfood WHERE FoodId = ('%s')", food_id);
    con.executeUpdate(query_delete);
    response.sendRedirect("../foodPage.jsp");

%>