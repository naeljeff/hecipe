<%@ include file="header.jsp" %>
<%
  if(userRole == null){
    response.sendRedirect("index.jsp");
  }
%>
<section class="content add-food">
    <!-- Add Food Title -->
    <span class="feature-title">
        <h2>Edit Food</h2>
        <hr />
      </span>
    
    <!-- Add Food -->
    <%
        String foodId = request.getParameter("FoodId");
    %>
    <form action="controller/editfood-validation.jsp?FoodId=<%= foodId%>" method="post" name="editFoodForm">
        <div class="add-food-container">

            <!-- Food Name -->
            <div class="add-food-content">
                <label for="food-name" id="f-name">Name:</label>
                <input type="text" name="food-name" id="" placeholder="Name">
            </div>
            
            <!-- Food Category -->
            <div class="add-food-content">
                <label for="food-category" id="f-category">Category:</label>
                <select name="food-category" id="">
                    <option value="Meats">Meats</option>
                    <option value="Vegetarian">Vegetarian</option>
                    <option value="Snack">Snack</option>
                </select>
            </div>

            <!-- Food Description -->
            <div class="add-food-content">
                <label for="food-description" id="f-description">Description: </label>
                <textarea name="food-description" id="" cols="30" rows="7"></textarea>
            </div>

            <!-- Food Price -->
            <div class="add-food-content">
                <label for="food-price" id="f-price">Price: </label>
                <input type="number" name="food-price" id="" min="0" placeholder="Price">
            </div>

            <!-- Food Quantity -->
            <div class="add-food-content">
                <label for="food-quantity" id="f-quantity">Quantity: </label>
                <input type="number" name="food-quantity" id="" min="0" placeholder="Quantity">
            </div>

            <!-- Button Register -->
            <div class="add-food-content">
                <button type="submit">Edit Food</button>
            </div>
        </div>
    </form>
    <%
        if (request.getParameter("err") != null){
            out.println("<br><span style='color:red; font-size: 14px;'>" + request.getParameter("err") + "</span>");
        }
    %>

</section>

<%@ include file="html/footer.html" %>