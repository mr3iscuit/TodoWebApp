package dao;

import model.Login;
import model.User;
import util.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao extends JDBCUtils {
    private static final String INSERT_USER = "INSERT INTO users(first_name, last_name, username, password)" +
            " Values(?, ?, ?, ?);";
    private static final String GET_USER_BY_USERNAME = "SELECT * FROM users WHERE username = ?";

    public Integer insertUser(User user){
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(INSERT_USER)){
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getUsername());
            statement.setString(4, user.getPassword());

            return statement.executeUpdate();
        }catch (SQLException ex){
            ex.printStackTrace();
            return 0;
        }
    }

    public User getUser(Login login){
        User user = null;
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(GET_USER_BY_USERNAME)){
            statement.setString(1, login.getUsername());
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            while(rs.next()){
                Integer id = rs.getInt("id");
                String name = rs.getString("first_name");
                String surname = rs.getString("last_name");

                user = new User(id, name, surname, login.getUsername(), null);
            }

            return user;
        }catch (SQLException e){
            e.printStackTrace();
            return null;
        }
    }

}
