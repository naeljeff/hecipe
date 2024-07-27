<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp"%>

<%
    String transactionId = request.getParameter("transactionId");
    String query = String.format("UPDATE mstransaction SET TransactionStatus = ('%s') WHERE TransactionId = ('%s')", "True", transactionId);
    Connect con = Connect.getConnection();
    con.executeUpdate(query);

    response.sendRedirect("../transaction-detail.jsp?transactionId=" + transactionId);

%>