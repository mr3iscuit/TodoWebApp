package dao;

import model.Todo;
import util.JDBCUtils;

import javax.xml.transform.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TodoDao extends JDBCUtils implements TodoDaoImpl{

    private static final String INSERT_TODO = "INSERT INTO todos(description, is_done, target_date, username, title)" +
            " VALUES(?, ?, ?, ?, ?);";
    private static final String SELECT_TODO_BY_ID = "SELECT id, description, is_done, target_date, username, title FROM todos " +
            "WHERE id = ?;";
    private static final String SELECT_ALL_TODOS = "SELECT * FROM todos";
    private static final String DELETE_TODO = "DELETE FROM todos WHERE id = ?;";
    private static final String UPDATE_TODO = "UPDATE todos SET description = ?, is_done = ?, target_date = ?, username = ?," +
            "title = ? WHERE id = ?;";


    @Override
    public void insertTodo(Todo todo) throws SQLException {
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(INSERT_TODO)){
            statement.setString(1, todo.getDescription());
            statement.setBoolean(2, todo.getDone());
            statement.setDate(3, JDBCUtils.getSqlDate(todo.getTargetDate()));
            statement.setString(4, todo.getUsername());
            statement.setString(5, todo.getTitle());

            statement.executeUpdate();
        }catch (SQLException ex){
            ex.printStackTrace();
        }
    }

    @Override
    public Todo selectTodo(long todoId) {
        Todo todo = null;
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(SELECT_TODO_BY_ID)){
            statement.setLong(1, todoId);
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            while(rs.next()){
                String description = rs.getString("description");
                Boolean isDone = rs.getBoolean("is_done");
                LocalDate targetDate = rs.getDate("target_date").toLocalDate();
                String username = rs.getString("username");
                String title = rs.getString("title");

                todo = new Todo(todoId, description, isDone, targetDate, username, title);
            }
            return todo;
        }catch (SQLException ex){
            ex.printStackTrace();
            return todo;
        }
    }

    @Override
    public List<Todo> selectAllTodos() {
        List<Todo> todos = new ArrayList<>();
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(SELECT_ALL_TODOS)){
            statement.executeQuery();

            ResultSet rs = statement.getResultSet();
            while(rs.next()){
                Long todoId = rs.getLong("id");
                String description = rs.getString("description");
                Boolean isDone = rs.getBoolean("is_done");
                LocalDate targetDate = rs.getDate("target_date").toLocalDate();
                String username = rs.getString("username");
                String title = rs.getString("title");

                todos.add(new Todo(todoId, description, isDone, targetDate, username, title));
            }
            return todos;
        }catch (SQLException ex){
            ex.printStackTrace();
            return todos;
        }
    }

    @Override
    public boolean deleteTodo(int id) throws SQLException {
        boolean status = false;
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(DELETE_TODO)){
            statement.setLong(1, id);

            status = statement.executeUpdate()>0;
            return status;
        }catch (SQLException ex){
            ex.printStackTrace();
            return status;
        }
    }

    @Override
    public boolean updateTodo(Todo todo) throws SQLException {
        boolean status = false;
        try(Connection connection = getConnect();
            PreparedStatement statement = connection.prepareStatement(UPDATE_TODO)){
            statement.setString(1, todo.getDescription());
            statement.setBoolean(2, todo.getDone());
            statement.setDate(3, JDBCUtils.getSqlDate(todo.getTargetDate()));
            statement.setString(4, todo.getUsername());
            statement.setString(5, todo.getTitle());
            statement.setLong(6, todo.getId());

            status = statement.executeUpdate()>0;
            return status;
        }catch (SQLException ex){
            ex.printStackTrace();
            return status;
        }
    }
}
