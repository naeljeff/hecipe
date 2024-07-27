<%@ page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pwd = request.getParameter("password");
    String pwd_confirm = request.getParameter("confirm-password");

    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM msuser WHERE UserEmail = ('%s')", email);
    ResultSet rs = con.executeQuery(query);

    String ALPHABET_REGEX = "^[a-zA-Z]+$";
    String NUMBER_REGEX = "^[0-9]+$";

    // Validate @ and .
    boolean isEmailContainDot = false;
    int countAt = 0;
    boolean isSymbolCorrect = true;
    for (int i = 0 ; i < email.length() ; i++){
        if(email.charAt(i) == '@'){
            countAt++;
            if(i != email.length() - 1 && (email.charAt(i - 1) == '.' || email.charAt(i + 1) == '.')){
                isSymbolCorrect = false;
            }
        }
        else if(email.charAt(i) == '.'){
            isEmailContainDot = true;
        }
    }

    // Validate Name
    if(name == ""){
        response.sendRedirect("../register.jsp?err=Name Cannot be Empty!");
    }
    else if(name.length() < 3){
        response.sendRedirect("../register.jsp?err=Name must be at least 3 characters!");
    }

    // Validate Email
    
    else if(email == ""){
        response.sendRedirect("../register.jsp?err=Email Cannot be Empty!");
    }
    else if(countAt == 0 || isEmailContainDot == false){
        response.sendRedirect("../register.jsp?err=Email must contain both '@' and '.'");
    }
    else if(countAt > 1){
        response.sendRedirect("../register.jsp?err=Email can only contain one '@'");
    }
    else if(isSymbolCorrect == false){
        response.sendRedirect("../register.jsp?err=Email cannot have '@' and '.' side by side");
    }else if(rs.next()){
        // Check if email is in database (Must be unique)
        response.sendRedirect("../register.jsp?err=Email is already registered!");
    }

    // Validate Password
    else if(pwd == ""){
        response.sendRedirect("../register.jsp?err=Password Cannot be Empty!");
    }
    else if(pwd.length() < 6){
        response.sendRedirect("../register.jsp?err=Password must be at least 6 characters!");
    }
    else if(pwd.matches(ALPHABET_REGEX) || pwd.matches(NUMBER_REGEX)){
        response.sendRedirect("../register.jsp?err=Password must contain both alphabet and number!");
    }
    else if(!pwd_confirm.equals(pwd)){
        response.sendRedirect("../register.jsp?err=Confirm password does not match password!");
    }else{
        // Register ke db lalu redirect ke login page
        String query_insert = String.format("INSERT INTO msuser (UserName, UserEmail, UserPassword, UserRole) VALUES ('%s', '%s', '%s', '%s')", name, email, pwd, "Member");
        con.executeUpdate(query_insert);
        response.sendRedirect("../login.jsp");
    }

%>