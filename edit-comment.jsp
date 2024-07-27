<%@ include file="header.jsp" %>
<%
  if(userRole == null){
    response.sendRedirect("index.jsp");
  }
%>
<section class="content edit-comment">
    <!-- Add Food Title -->
    <span class="feature-title">
        <h2>Edit Comment</h2>
        <hr />
      </span>
    
    <!-- Add Food -->
    <%
        String foodId = request.getParameter("Food_Id");
        String commentId = request.getParameter("CommentId");
        String query = String.format("SELECT * FROM mscomment WHERE CommentId = ('%s')", commentId);

        String comment = "";
        ResultSet rs = con.executeQuery(query);
        while(rs.next()){
            comment = rs.getString("UserComment");
        }
    %>
    <form action="controller/editComment-Controller.jsp" method="post" name="editCommentForm">
        <div class="edit-comment-container">
            <!-- Old Comment -->
            <div class="edit-comment-content">
                <label for="old-comment">Old Comment:</label>
                <input type="text" name="oldComment" id="old-comment" value="<%= comment%>" readonly>
            </div>
            
            <!-- New Comment -->
            <div class="edit-comment-content">
                <label for="new-comment">New Comment:</label>
                <textarea name="userComment" id="" cols="30" rows="7" placeholder="Write your comment"></textarea>
            </div>

            <!-- Button Edit -->
            <div class="edit-comment-content">
                <button type="submit">Edit Comment</button>
            </div>

            <input type="hidden" name="foodId" value="<%= foodId%>">
            <input type="hidden" name="commentId" value="<%= commentId%>">
        </div>
    </form>
    <%
        if (request.getParameter("err") != null){
            out.println("<br><span style='color:red; font-size: 14px;'>" + request.getParameter("err") + "</span>");
        }
    %>

</section>

<%@ include file="html/footer.html" %>