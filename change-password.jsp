<%@ include file="header.jsp" %>
<%
  if(userRole == null){
    response.sendRedirect("index.jsp");
  }
%>
<section class="content changepwd">
    <!-- Change Password Title -->
    <span class="feature-title">
        <h2>Change Password</h2>
        <hr />
      </span>
    
    <!-- Change Password -->
    <form action="controller/changepwd-validation.jsp" method="post" name="ChangepwdForm">
        <div class="changepwd-container">

            <!-- Old Password -->
            <div class="changepwd-content">
                <label for="old-password">Old Password:</label>
                <input type="password" name="old-password" id="" placeholder="Old Password">
            </div>
            
            <!-- New Password -->
            <div class="changepwd-content">
                <label for="new-password">New Password:</label>
                <input type="password" name="new-password" id="" placeholder="New Password">
            </div>

            <!-- Confirm Password -->
            <div class="changepwd-content">
                <label for="confirm-password" id="cp-label">Confirm Password:</label>
                <input type="password" name="confirm-password" id="" placeholder="Confirm Password">
            </div>

            <!-- Button Register -->
            <div class="changepwd-content">
                <button type="submit">Change Password</button>
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