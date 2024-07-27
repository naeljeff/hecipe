<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*"%>
<%@ include file="databases/connect.jsp"%>
<%@ include file="controller/handleCookiesLogin.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hecipe</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/transaction-style.css" />
    <link rel="stylesheet" href="css/cart-style.css" />
    <link rel="stylesheet" href="css/login.css" />
    <link rel="stylesheet" href="css/register.css" />
    <link rel="stylesheet" href="css/profile.css" />
    <link rel="stylesheet" href="css/changepwd.css" />
    <link rel="stylesheet" href="css/add-food.css" />
    <link rel="stylesheet" href="css/food-detail.css" />
    <link rel="stylesheet" href="css/food-page.css" />
    <link rel="stylesheet" href="css/edit-comment.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
  </head>
  <body>
    <header>
      <nav>
        <a class="nav-logo" href="#">
          <img src="assets/Logo.png" alt="logo"/>
        </a>
        <ul>
          <li class="nav-item"><a href="index.jsp">Home</a></li>
          <li class="nav-item"><a href="foodPage.jsp">Foods</a></li>
        </ul>
        <div class="hamburger">
          <span class="icon" id="hamburger-icon">
            <i class="fa fa-bars"></i>
          </span>
        </div>
      </nav>
      <div class="nav-auth">
        <!--Dynamic Change-->
        <%
            Connect con = Connect.getConnection();
            //String query = "SELECT * FROM msuser";
            //ResultSet rs = con.executeQuery(query);

            //while(rs.next()){
            //  session.setAttribute("userRole", rs.getString("UserRole"));
            //  session.setAttribute("userName", rs.getString("UserName"));
              
            //}
            
            //Ini untuk Dummy
            //session.setAttribute("userRole", "Member");
            //session.setAttribute("userName", "Edbert");

            String userRole = (String)session.getAttribute("userRole");
            String userName = (String)session.getAttribute("userName");
            Integer userId = (Integer)session.getAttribute("userId");
            
        %>
        <ul>
        <%-- 1. Guest Auth --%>
          <%
            if(userRole == null){
          %>
            <li class="nav-item"><a href="login.jsp">Login</a></li>
            <li class="nav-item"><a href="register.jsp">Register</a></li>
          <%
            }else{
          %>
        
        <%-- 2. Admin Auth --%>
            <li class="nav-item-welcome">Welcome, <%= userName%></li>
            <li class="nav-item"><a href="profile.jsp">Profile</a></li>
              <%
                if(userRole.equals("Member")){
              %>
                <li class="nav-item"><a href="cart.jsp">View Cart</a></li>
              <%
                }
              %>
            <li class="nav-item"><a href="transaction.jsp">View Transaction</a></li>
            <li class="nav-item"><a href="controller/handleLogout.jsp">Logout</a></li>
          <%
            }
          %>
        </ul>
      </div>
    </header>

