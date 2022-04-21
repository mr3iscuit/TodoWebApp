package util;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;

public abstract class JDBCUtils {
    private String jdbcUrl = "jdbc:mysql://localhost:3306/todo";
    private String username = "root";
    private String password = "root";

    public Connection getConnect(){
        Connection connection = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, username, password);
        }catch (SQLException ex){
            ex.printStackTrace();
        }catch (ClassNotFoundException ex){
            ex.printStackTrace();
        }

        return connection;
    }

    public static Date getSqlDate(LocalDate localDate){
        return java.sql.Date.valueOf(localDate);
    }

    public static LocalDate getUtilDate(Date sqlDate){
        return sqlDate.toLocalDate();
    }

}
