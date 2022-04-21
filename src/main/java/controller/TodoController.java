package controller;

import dao.TodoDao;
import model.Todo;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "Todo", urlPatterns = {"/"})
public class TodoController extends HttpServlet {
    private TodoDao todoDao;

    @Override
    public void init() throws ServletException {
        super.init();
        todoDao = new TodoDao();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response){
        doGet(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response){
        String action = request.getServletPath();

        switch (action){
            case "/new":
                request.removeAttribute("todo");
                showNewForm(request, response);
                break;
            case "/insert":
                insertTodo(request, response);
                break;
            case "/delete":
                deleteTodo(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/update":
                updateTodo(request, response);
                break;
            case "/list":
                listTodo(request, response);
                break;
            default:
                defaultTodo(request, response);
                //GO To /login
        }
    }

    public void defaultTodo(HttpServletRequest request, HttpServletResponse response){
        request.getSession().invalidate();
        RequestDispatcher dispatcher = request.getRequestDispatcher("login/login.jsp");
        try {
            dispatcher.forward(request, response);
        }  catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    public void listTodo(HttpServletRequest request, HttpServletResponse response) {
        List<Todo> todos = todoDao.selectAllTodos();
        Boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        System.out.println("Is Done: " + isDone);

        String idStr = request.getParameter("id");
        System.out.println("Id: " + idStr);
        Long id = Long.valueOf(0);

        if (idStr != null){
            System.out.println("IdStr Doesn't null! ");
            id = Long.valueOf(idStr);
            System.out.println("Id: " + id);
            TodoDao todoDao = new TodoDao();
            Todo todo = todoDao.selectTodo(id);
            todo.setDone(isDone);
            System.out.println("Todo set is-done!");
            try{
                todoDao.updateTodo(todo);
                System.out.println("Todo updated!");
                System.out.println("---------------------");
            }catch (SQLException ex){
                ex.printStackTrace();
            }
        }




        HttpSession session = request.getSession();
        session.setAttribute("todos", todos);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("todo/todo-list.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    public void updateTodo(HttpServletRequest request, HttpServletResponse response){
        Long id = Long.valueOf(request.getParameter("id"));
        String desc = request.getParameter("description");
        String username = request.getParameter("username");
        String title = request.getParameter("title");
        Boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"));

        System.out.println("Is Done: " + isDone);
        Todo todo = new Todo(id, desc, isDone, targetDate, username, title);

        try {
            todoDao.updateTodo(todo);
            response.sendRedirect("list");
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    public void showEditForm(HttpServletRequest request, HttpServletResponse response){
        try {
            Long id = Long.valueOf(request.getParameter("id"));
            Todo selectedTodo = todoDao.selectTodo(id);

            HttpSession session = request.getSession();

            RequestDispatcher dispatcher = request.getRequestDispatcher("todo/todo-form.jsp");

            session.setAttribute("todo", selectedTodo);
            dispatcher.forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }

    }

    public void deleteTodo(HttpServletRequest request, HttpServletResponse response){
        Integer id = Integer.parseInt(request.getParameter("id"));
        try {
            todoDao.deleteTodo(id);
            response.sendRedirect("list");
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    public void insertTodo(HttpServletRequest request, HttpServletResponse response){
        String desc = request.getParameter("description");
        String username = request.getParameter("username");
        String title = request.getParameter("title");
        Boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"));

        Todo todo = new Todo(desc, isDone, targetDate, username, title);
        try {
            todoDao.insertTodo(todo);
            response.sendRedirect("list");
        } catch (IOException | SQLException e) {
            e.printStackTrace();
        }
    }

    public void showNewForm(HttpServletRequest request, HttpServletResponse response){
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("todo");

            session.setAttribute("todo", null);
            request.getRequestDispatcher("todo/todo-form.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}






















