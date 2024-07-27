<%@ page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp" %>
<%

    // Get Values
    String food_name = request.getParameter("food-name");
    String food_category = request.getParameter("food-category");
    String food_description = request.getParameter("food-description");
    String food_price = request.getParameter("food-price");
    String food_quantity = request.getParameter("food-quantity");

    Connect con = Connect.getConnection();

    // Count Space
    int count_space = 0;
    for(int i = 0 ; i < food_description.length() ; i++){
        if(food_description.charAt(i) == ' '){
            count_space++;
        }
    }

    String NUMBER_REGEX = "^-?[0-9]*$";

    // Validate Name
    if(food_name == ""){
        response.sendRedirect("../add-food.jsp?err=Food Name Cannot be Empty!");
    }
    else if(food_name.length() < 3) {
        response.sendRedirect("../add-food.jsp?err=Food Name Must be at Least 3 Characters!");
    }

    // Validate Description
    else if(food_description == ""){
        response.sendRedirect("../add-food.jsp?err=Food Description Cannot be Empty!");
    }
    else if(count_space < 4) {
        response.sendRedirect("../add-food.jsp?err=Food Description Must be at Least 5 Words!");
    }

    // Validate Category
    else if(food_category.equals("meats") && food_category.equals("vegetarian") && food_category.equals("snack")){
        response.sendRedirect("../add-food.jsp?err=Food Category Must be Either Meats, Vegetarian, or Snack!");
    }

    // Validate Price
    else if(food_price == ""){
        response.sendRedirect("../add-food.jsp?err=Food Price Cannot be Empty!");
    }
    else if(!food_price.matches(NUMBER_REGEX)){
        response.sendRedirect("../add-food.jsp?err=Food Price Must be Numeric!");
    }

    // Validate Quantity
    else if(food_quantity == ""){
        response.sendRedirect("../add-food.jsp?err=Food Quantity Cannot be Empty!");
    }
    else if(!food_quantity.matches(NUMBER_REGEX)){
        response.sendRedirect("../add-food.jsp?err=Food Quantity Must be Numeric!");
    }
    else{
        // Insert to food database
        String query_insert = String.format("INSERT INTO msfood (FoodName, FoodCategory, FoodDescription, FoodImage, FoodPrice, FoodQuantity) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')", food_name, food_category, food_description, "assets/dummy-image.jpg", food_price, food_quantity);
        con.executeUpdate(query_insert);
        response.sendRedirect("../foodPage.jsp");
    }

%>