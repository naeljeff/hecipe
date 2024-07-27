<%@ include file="header.jsp" %>
<section class="content home">
  <div class="welcome-content">
    <h1>Welcome to Hecipe!</h1>
    <p class="welcome-slang">The place to satisfy all your's belly needs</p>
    <hr />
    <p class="description-text">
      Trying to fill your's belly? You come to the right place! With many foods
      to choose from, you can satisfy yourself in whatever the way you want. And
      so without holding yourself back, why not see what we have to over by
      clicking this button?
    </p>
    <a class="btn-prime" href="foodPage.jsp">See our's catalog</a>
  </div>
  <div class="feature-content">
    <div class="purchase-food feature-item">
      <span class="feature-title">
        <h2>Purchase Foods</h2>
        <hr />
      </span>
      <p class="description-text">
        Hecipe is the place where you can go to if you want to find a wide
        variety of cuisine around the world. And so, now is the time if you want
        to fill your belly with the greatest cuisine from around the world.
      </p>
      <a class="btn-prime" href="foodPage.jsp">See what's we have to offer</a>
    </div>
    <div class="search-foods feature-item">
      <span class="feature-title">
        <h2>Search Foods</h2>
        <hr />
      </span>
      <p class="description-text">
        Want to search a specific food in mind? Try using our search engine to
        find the cuisine that can fill your belly with our greatest cuisine from
        around the world.
      </p>
      <div class="search-engine">
        <form action="foodPage.jsp">                
          <input
            type="text"
            name="searchFood"
            id="searchFoods"
            placeholder="Search food by"
          />
          <select name="search-category" id="search-by">
            <option value="name">Name</option>
            <option value="category">Category</option>
            <option value="description">Description</option>
          </select>
          <input type="submit" class="btn-prime" value="Search">
        </form>
      </div>
    </div>
    <div class="site-status feature-item">
      <span class="feature-title">
        <h2>Site Status</h2>
        <hr />
      </span>
      <span class="site-status-item">
        <p class="description-text">Current Date:</p>
        <p class="description-text">
          <%
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();
            out.println(formatter.format(today));
          %>
        </p>
      </span>
      <span class="site-status-item">
        <p class="description-text">Number of user:</p>
        <p class="description-text">
          <%
            String query = "SELECT COUNT(*) FROM msuser";
            ResultSet rs = con.executeQuery(query);
            
            while(rs.next()){
              Integer countRow = rs.getInt(1);
              if(countRow > 1){
                out.println(countRow + " persons");

              }else{
                out.println(countRow + " person");

              }
            }

          %>
        </p>
      </span>
      <span class="site-status-item">
        <p class="description-text">Logged user:</p>
        <p class="description-text">
        <%
          query = "SELECT * FROM msuser";
          rs = con.executeQuery(query);
          int countLogged = 0;
          while(rs.next()){
              if(rs.getString("UserStatus").equals("logged_in")){
                countLogged++;
              }
          }
          if(countLogged > 1){
            out.println(countLogged + " persons");

          }else{
            out.println(countLogged + " person");

          }
        %>
        
        
        </p>
      </span>
    </div>
  </div>
</section>
<%@ include file="html/footer.html" %>
