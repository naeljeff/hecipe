<%@ include file="header.jsp" %>
<section class="content transaction cart">
  <span class="feature-title">
    <h2>Cart</h2>
    <hr />
  </span>
  <div class="table-wrapper">
    <%
      ArrayList<String> foodIdList = (ArrayList<String>)session.getAttribute("foodIdList");
        ArrayList<Integer> foodQuantityList = (ArrayList<Integer>)session.getAttribute("foodQuantityList");
      if(foodIdList != null){
    %>
    <table class="transaction-table">
      <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Subtotal</th>
        <th>Action</th>
      </tr>
      <%
        
        String query = "";
        ResultSet rs;
        int total = 0;
        
          for(int i=0; i<foodIdList.size(); i++){
            query = String.format("SELECT * FROM msfood WHERE FoodId='%s'", foodIdList.get(i));
            rs = con.executeQuery(query);
            
            while(rs.next()){
              total += (foodQuantityList.get(i) * rs.getInt("FoodPrice"));
        %>
            <tr class="table-item">
              <td class="image-item">
                <img src="<%= rs.getString("FoodImage")%>" alt="fried-rice" />
              </td>
              <td><a href="food-detail.jsp?Food_Id=<%= rs.getInt("FoodId")%>"><%= rs.getString("FoodName")%></a></td>
              <input type="hidden" name="foodId" value="<%= rs.getString("FoodId")%>" />
              <td>
                <form action="controller/handleCart.jsp?type=save" method="POST">
                <div class="quantity-input">
                  <input type="number" name="foodQuantity" value="<%= foodQuantityList.get(i)%>" min="0" max="<%= rs.getInt("FoodQuantity")%>"/>
                  <input type="hidden"
                  name="foodId" value="<%= rs.getString("FoodId")%>"/>
                  <input
                    class="btn-prime btn-warning save-btn"
                    type="submit"
                    value="Save"
                  />
                </div>
                </form>
              </td>
              <td><%= rs.getString("FoodPrice")%></td>
              <td class="item-subtotal"><%= foodQuantityList.get(i) * rs.getInt("FoodPrice")%></td>
              <td>
                <button class="btn-prime delete-btn"><a  href="controller/handleCart.jsp?type=delete&foodId=<%= rs.getString("FoodId")%>">Delete</a></button>
              </td>
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
      <div class="btn-wrapper">
        <button type="button" class="btn-prime delete-btn"><a href="controller/handleCart.jsp?type=empty">Empty cart</a></button>
        <button type="button" class="btn-prime btn-success checkout-btn"><a href="controller/handleCart.jsp?type=checkout">Check out</a></button>
      </div>
    </div>
    <%
      }else{
    %>
    <div class="empty-cart-info">
      <h2>There is no item in cart currently</h2>
       <a href="foodPage.jsp" class="btn-prime btn-success">Add product to cart</a>
    </div>
    <%
      }
    %>
  </div>
</section>
<%@ include file="html/footer.html" %>
