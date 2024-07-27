<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String userEmail = (String)session.getAttribute("userEmail");
    String userComment = request.getParameter("userComment");
    String foodId = request.getParameter("foodId");

    Connect con = Connect.getConnection();

    // Count Space
    int count_space = 0;
    for(int i = 0 ; i < userComment.length() ; i++){
        if(userComment.charAt(i) == ' '){
            count_space++;
        }
    }

    // Validate Comment
    if(userComment == ""){
        response.sendRedirect("../food-detail.jsp?Food_Id=" + foodId + "&err=Comment Cannot be Empty!");
    }
    else if(count_space < 4) {
        response.sendRedirect("../food-detail.jsp?Food_Id=" + foodId + "&err=Comment Must be at Least 5 Words!");
    }
    else{
        // Insert to comment database
        // Get user id
        String query = String.format("SELECT UserId FROM msuser WHERE UserEmail = ('%s')", userEmail);
        String uId = "";
        ResultSet rs = con.executeQuery(query);
        while(rs.next()){
            uId = String.valueOf(rs.getInt("UserId"));
        }

        String query_insert = String.format("INSERT INTO mscomment (Food_Id, User_Id, UserComment) VALUES ('%s', '%s', '%s')", foodId, uId, userComment);
        con.executeUpdate(query_insert);
        response.sendRedirect("../food-detail.jsp?Food_Id=" + foodId);
    }

%>