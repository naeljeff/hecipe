<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp"%>
<%
    String foodId = request.getParameter("foodId");

    ArrayList<String> foodIdList = (ArrayList<String>)session.getAttribute("foodIdList");
    ArrayList<Integer> foodQuantityList = (ArrayList<Integer>)session.getAttribute("foodQuantityList");

    Connect con = Connect.getConnection();
    String query = String.format("SELECT * FROM msfood WHERE FoodId='%s'", foodId);
    ResultSet rs = con.executeQuery(query);

    int curr_quantity = 0;
    String curr_foodName = "";
    

    while(rs.next()){
        curr_quantity = rs.getInt("FoodQuantity");
        curr_foodName = rs.getString("FoodName");
    }
    if(curr_quantity == 0){
        response.sendRedirect("../foodPage.jsp?err="+curr_foodName+" stock is empty");
        return;
    }

    if(foodIdList == null){
        ArrayList<String> newFoodIdList = new ArrayList<String>();
        ArrayList<Integer> newFoodQuantityList = new ArrayList<Integer>();

        newFoodIdList.add(foodId);
        newFoodQuantityList.add(1);
        session.setAttribute("foodIdList", newFoodIdList);
        session.setAttribute("foodQuantityList", newFoodQuantityList);
        response.sendRedirect("../foodPage.jsp");
        return;
    }

    int foodIndex = foodIdList.indexOf(foodId);
    
    
    if(foodIndex > -1){
        foodQuantityList.set(foodIndex, foodQuantityList.get(foodIndex)+1);
        session.setAttribute("foodQuantityList", foodQuantityList);
    }else if(foodIndex > -1 && foodQuantityList.get(foodIndex)+1 > curr_quantity){
        response.sendRedirect("../foodPage.jsp?err="+curr_foodName+" stock is left "+curr_quantity);
        return;
    }else{
        foodIdList.add(foodId);
        foodQuantityList.add(1);
        session.setAttribute("foodIdList", foodIdList);
        session.setAttribute("foodQuantityList", foodQuantityList);
    }
    
    response.sendRedirect("../foodPage.jsp");
%>