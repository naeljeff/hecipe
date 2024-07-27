<%@ include file="header.jsp" %>

<section class="content food-page">
    
    <!-- Food Detail Title -->
    <div class="food-page-item">
        <span class="feature-title">
            <h2>Foods</h2>
            <hr />
        </span>

        <!-- Guest -->
        <!-- Search Bar -->
        <%
            String searchResult = "";
            String query = "";
            searchResult = request.getParameter("searchFood");
        %>
        <div class="fp-search">
            <div class="fp-search-left">
                <form action="foodPage.jsp">
                    <!-- Search -->
                    <input type="text" name="searchFood" id="" placeholder="Search food by">
        
                    <!-- Select -->
                    <select name="search-category" id="">
                        <option value="name">Name</option>
                        <option value="category">Category</option>
                        <option value="description">Description</option>
                    </select>

                    <button type="submit">Search</button>
                </form>
            </div>
            <div class="fp-search-right">
                <%
                    if(userRole != null && userRole.equals("Admin")){
                        %>
                        <button><a href="add-food.jsp">Add new food</a></button>
                        <%
                    }
                %>
            </div>
        </div>
        <div class="fp-content">
            <table class="fp-content-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <!-- If guest hide action -->
                        <%
                            if(userRole != null && (userRole.equals("Admin") || userRole.equals("Member"))){
                                %>
                                <th>Action</th>
                                <%
                            }
                        %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String category = request.getParameter("search-category");
                        if(searchResult == null || searchResult.equals("")){
                            query = String.format("SELECT * FROM msfood");
                        }
                        else if(category.equals("name")){
                            query = "SELECT * FROM msfood WHERE FoodName LIKE '%" + searchResult + "%'";
                        }
                        else if(category.equals("category")){
                            query = "SELECT * FROM msfood WHERE FoodCategory LIKE '%" + searchResult + "%'";
                        }
                        else if(category.equals("description")){
                            query = "SELECT * FROM msfood WHERE FoodDescription LIKE '%" + searchResult + "%'";
                        }
                        int foodCount = 0;
                        ResultSet rs = con.executeQuery(query);
                        while(rs.next()){
                            foodCount += 1;
                    %>
                    <tr class="fp-content-item">
                        <td class="image-item">
                            <img src="<%= rs.getString("FoodImage")%>" alt="<%= rs.getString("FoodName")%>" />
                        </td>
                        <td><a href="food-detail.jsp?Food_Id=<%= rs.getInt("FoodId")%>"><%= rs.getString("FoodName")%></a></td>
                        <td><%= rs.getString("FoodCategory")%></td>
                        <td><%= rs.getString("FoodPrice")%></td>
                        <%
                            if(userRole != null){
                                if(userRole.equals("Admin")){
                                    %>
                                        <td>
                                            <div class="fp-content-action">
                                                <button class="edit"><a href="edit-food.jsp?FoodId=<%= rs.getInt("FoodId")%>">Edit</a></button>
                                                <button class="delete"><a href="controller/deleteFood-Controller.jsp?FoodId=<%=rs.getInt("FoodId")%>">Delete</a></button>
                                            </div>
                                        </td>
                                    <%
                                } else if(userRole.equals("Member")){
                                    %>
                                        <td>
                                            <div class="fp-content-action">
                                                <button class="atc"><a href="controller/addFoodToCart.jsp?foodId=<%= rs.getInt("FoodId")%>">Add to Cart</a></button>
                                            </div>
                                        </td>
                                    <%
                                }
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <%
        if (request.getParameter("err") != null){
            out.println("<br><span style='color:red; font-size: 14px;'>" + request.getParameter("err") + "</span>");
        }
    %>
    <div class="fp-page-nav">
        <ul id="pageNavigation">
            <!-- Pagination -->
        </ul>
    </div>
    
    <input type="hidden" name="totalFood" value="<%= foodCount%>">
    <script src="js/pagination.js"></script>
</section>

<%@ include file="html/footer.html" %>