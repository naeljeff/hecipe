<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*"%>
<%@ include file="../databases/connect.jsp"%>

<%
    Integer userId = (Integer)session.getAttribute("userId");
    String type = request.getParameter("type");
    String foodId = request.getParameter("foodId");
    String foodQuantity = request.getParameter("foodQuantity");
    boolean transactionStatus = false;

    ArrayList<String> foodIdList = (ArrayList<String>)session.getAttribute("foodIdList");
    ArrayList<Integer> foodQuantityList = (ArrayList<Integer>)session.getAttribute("foodQuantityList");
    int index = foodIdList.indexOf(foodId);
    Connect con = Connect.getConnection();
    ResultSet rs;

    switch(type){
        case "save":
            String query = String.format("SELECT * FROM msfood WHERE FoodId='%s'", foodId);
            rs = con.executeQuery(query);

            if(foodIdList.size() == 1 && Integer.parseInt(foodQuantity) == 0){
                session.removeAttribute("foodQuantityList");
                session.removeAttribute("foodIdList");
                response.sendRedirect("../cart.jsp");
                return;
            }else{
                if(Integer.parseInt(foodQuantity) == 0){
                    foodQuantityList.remove(index);
                    foodIdList.remove(index);
                    session.setAttribute("foodQuantityList", foodQuantityList);
                    session.setAttribute("foodIdList", foodIdList);
                    response.sendRedirect("../cart.jsp");
                    return;
                }

                int current_quantity = 0;
                while(rs.next()){
                    current_quantity = rs.getInt("FoodQuantity");
                }

                if(current_quantity < Integer.parseInt(foodQuantity)){
                    response.sendRedirect("../cart.jsp?error=Food Quantity exceed current stock, current stock left: " + current_quantity);
                    return;
                }
                foodQuantityList.set(index, Integer.parseInt(foodQuantity));
                session.setAttribute("foodQuantityList", foodQuantityList);
            }
            
            
            break;
        case "delete":
            
            if(foodIdList.size() == 1){
                session.removeAttribute("foodQuantityList");
                session.removeAttribute("foodIdList");
                
            }else{
                foodQuantityList.remove(index);
                foodIdList.remove(index);
                session.setAttribute("foodQuantityList", foodQuantityList);
                session.setAttribute("foodIdList", foodIdList);
            }
            
            break;
        case "empty":
            
            session.removeAttribute("foodQuantityList");
            session.removeAttribute("foodIdList");
            break;
        case "checkout":    
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();

            //Insert to Transaction
            String query_transaction = String.format("INSERT INTO mstransaction (TransactionDate, TransactionStatus) VALUES ('%s', 'False')", formatter.format(today));
            ResultSet st = con.executeUpdate(query_transaction).getGeneratedKeys();
            st.next();
            //Get Food Price
            int transactionId = st.getInt(1);
            String query_id_list = "";
            for(int i=0; i<foodIdList.size(); i++){
                query_id_list += "'" + foodIdList.get(i) + "'";
                if(i!=foodIdList.size()-1){
                    query_id_list += ",";
                }
            }
            String query_foodPrice = String.format("SELECT * FROM msfood WHERE FoodId IN (%s)", query_id_list);
            rs = con.executeQuery(query_foodPrice);
            ArrayList<Integer> foodPriceList = new ArrayList<Integer>();
            ArrayList<Integer> foodStockList = new ArrayList<Integer>();

            while(rs.next()){
                foodPriceList.add(rs.getInt("FoodPrice"));
                foodStockList.add(rs.getInt("FoodQuantity"));
            }

            
            String query_chart = "";
            String query_stock = "";
            int curr_quantity;

            for(int i=0; i<foodIdList.size(); i++){
                
                //Insert to Cart
                query_chart = String.format("INSERT INTO mscart (FoodId, TransactionId, UserId, CartQuantity, CartTotal) VALUES ('%s', %d, %d, '%s', %d)", foodIdList.get(i), transactionId, userId, foodQuantityList.get(i), foodPriceList.get(i) * foodQuantityList.get(i));
                con.executeUpdate(query_chart);
                
                 //Remove From stock
                curr_quantity = foodStockList.get(i) - foodQuantityList.get(i);
                query_chart = String.format("UPDATE msfood SET FoodQuantity = (%d) WHERE FoodId = ('%s')", curr_quantity, foodIdList.get(i));
                con.executeUpdate(query_chart);
                session.removeAttribute("foodQuantityList");
                session.removeAttribute("foodIdList");
            }
            response.sendRedirect("../transaction-detail.jsp?transactionId=" + transactionId);
            transactionStatus = true;

            break;
    }
    if(transactionStatus){
        return;
    }
    
    response.sendRedirect("../cart.jsp");
%>