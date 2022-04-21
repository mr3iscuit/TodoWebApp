package dao;

import model.Login;
import util.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao extends JDBCUtils {

    private static final String LOGIN_SQL = "select * from users where username = ? and password = ?";

    public boolean validate(Login login){
        boolean status = false;
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(LOGIN_SQL)){

            statement.setString(1, login.getUsername());
            statement.setString(2, login.getPassword());

            ResultSet resultSet = statement.executeQuery();

            status = resultSet.next();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return status;
    }
}
