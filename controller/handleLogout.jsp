<%@ page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%
    Cookie[] cookies = request.getCookies();
    String LoggedUserName=null;

    // Update User Status in database to not_loggeedin
    Connect con = Connect.getConnection();
    String email = (String)session.getAttribute("userEmail");
    String query = String.format("UPDATE msuser SET UserStatus = ('%s') WHERE UserEmail = ('%s')", "not_loggedin",email);
    con.executeUpdate(query);

    if(cookies != null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("hecipe_userName")){
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
    }
    
    session.removeAttribute("userRole");
    session.removeAttribute("userName");
    session.removeAttribute("userEmail");   
    session.removeAttribute("userId");
    session.removeAttribute("foodQuantityList");
    session.removeAttribute("foodIdList");
    response.sendRedirect("../index.jsp");
%>