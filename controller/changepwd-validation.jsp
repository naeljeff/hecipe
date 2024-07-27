<%@ page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String old_pwd = request.getParameter("old-password");
    String new_pwd = request.getParameter("new-password");
    String pwd_confirm = request.getParameter("confirm-password");

    String ALPHABET_REGEX = "^[a-zA-Z]+$";
    String NUMBER_REGEX = "^[0-9]+$";

    Connect con = Connect.getConnection();
    String email = (String)session.getAttribute("userEmail");
    String query = String.format("SELECT * FROM msuser WHERE UserEmail = ('%s')", email);
    ResultSet rs = con.executeQuery(query);

    String curr_pwd = "";

    while(rs.next()){
        curr_pwd = rs.getString("UserPassword");
    }
    // Validate
    if(old_pwd == ""){
        response.sendRedirect("../change-password.jsp?err=Old Password Cannot be Empty!");
    }
    else if(!curr_pwd.equals(old_pwd)){
        response.sendRedirect("../change-password.jsp?err=Old Password Incorrect!");
    }

    else if(new_pwd == ""){
        response.sendRedirect("../change-password.jsp?err=New Password Cannot be Empty!");
    }
    else if(new_pwd.length() < 6){
        response.sendRedirect("../change-password.jsp?err=New Password must be at least 6 characters!");
    }
    else if(new_pwd.matches(ALPHABET_REGEX) || new_pwd.matches(NUMBER_REGEX)){
        response.sendRedirect("../change-password.jsp?err=New Password must contain both alphabet and number!");
    }
    else if(!pwd_confirm.equals(new_pwd)){
        response.sendRedirect("../change-password.jsp?err=Confirm password does not match new password!");
    }
    // Update to db
    else{
        String query_update = String.format("UPDATE msuser SET UserPassword = ('%s') WHERE UserEmail = ('%s')", new_pwd, email);
        con.executeUpdate(query_update);
        response.sendRedirect("../profile.jsp");
    }
%>