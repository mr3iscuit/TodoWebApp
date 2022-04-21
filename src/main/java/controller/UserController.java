package controller;

import dao.UserDao;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "User", urlPatterns = {"/register"})
public class UserController extends HttpServlet {
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        register(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register/register.jsp").forward(request, response);
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(null, firstName, lastName, username, password);

        try{
            Integer result = userDao.insertUser(user);

            if (result == 1){
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                request.setAttribute("notifications", "Registered Successfully!");
            }else{
                request.setAttribute("notifications", "Unexpected Error!");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
       request.getRequestDispatcher("register/register.jsp").forward(request, response);
    }
}
