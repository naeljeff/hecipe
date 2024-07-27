<%@ include file="header.jsp" %>
<%-- Untuk handle role agar gak tembak via route--%>
<%
  if(userRole == null){
    response.sendRedirect("index.jsp");
  }
%>
<section class="content transaction transaction-detail">
  <span class="feature-title">
    <h2>Detail Transactions</h2>
    <hr />
  </span>
  <div class="table-wrapper">
    <table class="transaction-table">
      <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Subtotal</th>
      </tr>
      <%
        String transactionId = request.getParameter("transactionId");
        String query = String.format("SELECT * FROM mscart WHERE TransactionId=%d", Integer.parseInt(transactionId));
        ResultSet rs = con.executeQuery(query);
        ArrayList<String> queryList = new ArrayList<String>();
        ArrayList<Integer> cartQuantityList = new ArrayList<Integer>();
        ArrayList<Integer> cartTotalList = new ArrayList<Integer>();
        int total = 0;

        while(rs.next()){
          queryList.add(String.format("SELECT * from msfood WHERE FoodId=%d", rs.getInt("FoodId")));
          cartQuantityList.add(rs.getInt("CartQuantity"));
          cartTotalList.add(rs.getInt("CartTotal"));
        }

        for(int i=0; i<queryList.size(); i++){
            rs = con.executeQuery(queryList.get(i));
            while(rs.next()){
              total += cartTotalList.get(i);  
          %>
            <tr class="table-item">
              <td class="image-item">
                <img src="<%= rs.getString("FoodImage")%>" alt="*food-name*" />
              </td>
              <td><a href="food-detail.jsp?Food_Id=<%= rs.getInt("FoodId")%>"><%= rs.getString("FoodName")%></a></td>
              <td><%= cartQuantityList.get(i)%></td>
              <td><%= cartTotalList.get(i) / cartQuantityList.get(i)%></td>
              <td><%= cartTotalList.get(i)%></td>
            </tr>
          <%
          }
        }
      %>
      
      
      <!--Diganti dengan jsp include-->
    </table>
    <div class="total-price">
      <span>
        <b>Total:</b>
        <p id="total-price-text"><%= total%></p>
      </span>
      <%
        query = String.format("SELECT * FROM mstransaction WHERE TransactionId = %d", Integer.parseInt(transactionId));
        rs = con.executeQuery(query);
        String transactionStatus = "";
        while(rs.next()){
          transactionStatus = rs.getString("TransactionStatus");
        }

        if(userRole != null && userRole.equals("Admin") && transactionStatus.equals("False")){
      %>
        <button type="button" class="btn-prime btn-success"><a href="controller/handleTransactionProcess.jsp?transactionId=<%= transactionId%>">Process</a></button>
      <%
        }
      %>
    </div>
  </div>
</section>
<%@ include file="html/footer.html" %>
