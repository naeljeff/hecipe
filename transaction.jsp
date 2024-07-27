<%@ include file="header.jsp" %>
<%
  if(userRole == null){
    response.sendRedirect("index.jsp");
  }
%>
<section class="content transaction">
  <span class="feature-title">
    <h2>Transactions</h2>
    <hr />
  </span>
  <div class="table-wrapper">
    <%
      String query = "";
      if(userRole.equals("Admin")){
        query = "SELECT COUNT(*) FROM mstransaction";
      }else if(userRole.equals("Member")){
        query = String.format("SELECT COUNT(*) FROM mstransaction T JOIN mscart C ON T.TransactionId = C.TransactionId WHERE UserId = %d GROUP BY C.TransactionId;", userId);
      }
      
      ResultSet rs = con.executeQuery(query);
      int countRow = 0;
      if(rs.next()){
        countRow = rs.getInt(1);
      }      
      if(countRow > 0){
    %>

    <table class="transaction-table">
      <tr>
        <th>Date</th>
        <th>Processed</th>
        <th>Action</th>
      </tr>
      <%

        if(userRole.equals("Admin")){
          query = "SELECT * FROM mstransaction";
        }else if(userRole.equals("Member")){
          query = String.format("SELECT * FROM mstransaction T JOIN mscart C ON T.TransactionId = C.TransactionId WHERE UserId = %d GROUP BY C.TransactionId;", userId);
        }
        rs = con.executeQuery(query);
        while(rs.next()){
          %>
            <tr class="table-item">
              <td><%= rs.getString("TransactionDate")%></td>
              <td><%= rs.getString("TransactionStatus")%></td>
              <td><a href="transaction-detail.jsp?transactionId=<%= rs.getString("TransactionId")%>">See detail</a></td>
            </tr>
          <%
        }
      %>
    </table>
    <%
      }else{
        %>
          <div class="empty-transaction-info">
            <h2>There is no item in transaction currently</h2>
            <a href="foodPage.jsp" class="btn-prime btn-success">Create Transaction Now</a>
          </div>
        <%
      }
    %>
  </div>
</section>
<%@ include file="html/footer.html" %>
