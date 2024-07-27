<%@ include file="header.jsp" %>

<section class="content register">
    <!-- Register Title -->
    <span class="feature-title">
        <h2>Register</h2>
        <hr />
      </span>
    
    <!-- Register -->
    <form action="controller/register-validation.jsp" method="post" name="RegisterForm">
        <div class="register-container">

            <!-- Name -->
            <div class="register-content">
                <label for="name">Name:</label>
                <input type="text" name="name" id="" placeholder="Name">
            </div>

            <!-- Email -->
            <div class="register-content">
                <label for="email">Email:</label>
                <input type="text" name="email" id="" placeholder="Email">
            </div>

            <!-- Password -->
            <div class="register-content">
                <label for="password">Password:</label>
                <input type="password" name="password" id="" placeholder="Password">
            </div>

            <!-- Confirm Password -->
            <div class="register-content">
                <label for="confirm-password" id="cp-label">Confirm Password:</label>
                <input type="password" name="confirm-password" id="" placeholder="Confirm Password">
            </div>

            <!-- Button Register -->
            <div class="register-content">
                <button type="submit">Register</button>
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