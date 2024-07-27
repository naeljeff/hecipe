<%-- Connect to database --%>
<%@page import="java.sql.*"%>

<%!
    public static final class Connect{
        private Connection con;
        private Statement st;
        private ResultSet rs;
        private static Connect instance;

        private Connect(){
            final String username = "root";
            final String password = "";
            final String database = "hecipe_database";
            final String host = "localhost";
            final String connection = String.format("jdbc:mysql://%s/%s", host, database);

            try{
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(connection, username, password);
                st = con.createStatement();
                
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        // Make new Connection
        public static Connect getConnection(){
            if (instance == null){
                instance = new Connect();
            }
            return instance;
        }
        
        // Read Data
        public ResultSet executeQuery(String query){
            try{
                rs = st.executeQuery(query);
            }catch(Exception e){
                e.printStackTrace();
            }

            return rs;
        }

        // Insert Delete Update
        public Statement executeUpdate(String query){
            try{
                st.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
            }catch(Exception e){
                e.printStackTrace();
            }

            return st;
        }
    }
%>