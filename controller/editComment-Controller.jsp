<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String userComment = request.getParameter("userComment");
    String foodId = request.getParameter("foodId");
    String commentId = request.getParameter("commentId");

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
        response.sendRedirect("../edit-comment.jsp?Food_Id=" + foodId + "&CommentId=" + commentId + "&err=Comment Cannot be Empty!");
    }
    else if(count_space < 4) {
        response.sendRedirect("../edit-comment.jsp?Food_Id=" + foodId + "&CommentId=" + commentId + "&err=Comment Must be at Least 5 Words!");
    }
    else{
        // Update to comment database
        String query_update = String.format("UPDATE mscomment SET UserComment = ('%s') WHERE CommentId = ('%s')", userComment, commentId);
        con.executeUpdate(query_update);
        response.sendRedirect("../food-detail.jsp?Food_Id=" + foodId);
    }

%>