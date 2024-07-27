<%@ include file="header.jsp" %>

<section class="content food-detail">
    <%
        String userEmail = (String)session.getAttribute("userEmail");
        String foodId = request.getParameter("Food_Id");
        String query = String.format("SELECT * FROM msfood WHERE FoodId = ('%s')", foodId);
        ResultSet rs = con.executeQuery(query);
        while(rs.next()){
    %>
    <!-- Food Detail Title -->
    <span class="feature-title">
    <!-- Food name from request.getparam -->
        <h2><%= rs.getString("FoodName")%></h2>
        <hr />
    </span>

    <!-- Guest -->
    <!-- Food Detail -->
    <div class="fd-content">
        <!-- Data dummy, nanti dari db-->
        <div class="fd-content-left">
            <img src="<%= rs.getString("FoodImage")%>" alt="Nasi Goreng">
            <div class="fd-description">
                <!-- Category -->
                <h4>Category</h4>
                <p><%= rs.getString("FoodCategory")%></p>
    
                <!-- Description -->
                <h4>Description</h4>
                <p><%= rs.getString("FoodDescription")%></p>
    
                <!-- Price -->
                <h4>Price</h4>
                <p><%= rs.getInt("FoodPrice")%></p>
    
                <!-- Quantity -->
                <h4>Quantity</h4>
                <p><%= rs.getInt("FoodQuantity")%></p>
            </div>
        </div>
        <div class="fd-content-right">
            <%
                if(userRole != null){
                    if(userRole.equals("Member")){
                        %>
                        <button><a href="controller/addFoodToCart.jsp?foodId=<%= rs.getInt("FoodId")%>">Add to Cart</a></button>
                        <%
                    }
                }
            %>
        </div>
    </div>
    <%
        }
    %>

    <!-- Comments -->
    <span id="fd-comment-title">
        <h3>Comments</h3>
        <hr>
    </span>

    
    <%
        String query_comment = String.format("SELECT * FROM mscomment mc LEFT JOIN msuser mu ON mc.User_Id = mu.UserId LEFT JOIN msfood mf ON mc.Food_Id = mf.FoodId WHERE Food_Id = ('%s')", foodId);
        Connect con_2 = Connect.getConnection();
        ResultSet rs_2 = con_2.executeQuery(query_comment);
        if(!rs_2.next()){
            %>
            <div class="fd-comments">
                <h2>There is no comment yet!</h2>
            </div>
            <%
        }
        else{
            // Output first rs
            %>
            <div class="fd-comments">
                <div class="fd-comments-left">
                    <div>
                        <h4><%= rs_2.getString("mu.UserName")%></h4>
                        <p><%= rs_2.getString("UserComment")%></p>
                    </div>
                    <%
                        if(userRole != null){
                            if(userRole.equals("Member")){
                                if(rs_2.getString("UserEmail").equals(userEmail)){
                                    %>
                                    <div>
                                        <button class="editFood"><a href="edit-comment.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Edit</a></button>
                                        <button class="deleteFood"><a href="controller/deleteComment-Controller.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Delete</a></button>
                                    </div>
                                    <%
                                }
                            }
                            else if(userRole.equals("Admin")){
                                %>
                                <div>
                                    <button class="deleteFood"><a href="controller/deleteComment-Controller.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Delete</a></button>
                                </div>
                                <%
                            }
                        }
                    %>
                    
                </div>
            <%
            while(rs_2.next()){
                %>
                    <div class="fd-comments-left">
                        <div>
                            <h4><%= rs_2.getString("mu.UserName")%></h4>
                            <p><%= rs_2.getString("UserComment")%></p>
                        </div>
                        <%
                        if(userRole != null){
                            if(userRole.equals("Member")){
                                if(rs_2.getString("UserEmail").equals(userEmail)){
                                    %>
                                    <div>
                                        <button class="editFood"><a href="edit-comment.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Edit</a></button>
                                        <button class="deleteFood"><a href="controller/deleteComment-Controller.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Delete</a></button>
                                    </div>
                                    <%
                                }
                            }
                            else if(userRole.equals("Admin")){
                                %>
                                <div>
                                    <button class="deleteFood"><a href="controller/deleteComment-Controller.jsp?CommentId=<%= rs_2.getInt("CommentId")%>&Food_Id=<%= rs_2.getInt("Food_Id")%>">Delete</a></button>
                                </div>
                                <%
                            }
                        }
                        %>
                    </div>
                <%
            }
            %>
            </div>
            <%
        }
        if(userRole != null && userRole.equals("Member")){
    %>
    
    <div class="post-comment">
        <form action="controller/addComment-Controller.jsp" class="comment-form">
            <textarea name="userComment" id="" cols="30" rows="7" placeholder="Write your comment"></textarea>
            <button type="submit">Post Comment</button>
            <input type="hidden" name="foodId" value="<%= foodId%>">
        </form>
    </div>
    <%
        }
        if (request.getParameter("err") != null){
            out.println("<br><span style='color:red; font-size: 15px;'>" + request.getParameter("err") + "</span>");
        }
    %>
</section>

<%@ include file="html/footer.html" %>