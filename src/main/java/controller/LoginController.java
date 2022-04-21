package controller;

import dao.LoginDao;
import dao.UserDao;
import model.Login;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "Login", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private LoginDao loginDao;
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        loginDao = new LoginDao();
        userDao = new UserDao();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        authenticate(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login/login.jsp").forward(request, response);
    }

    private void authenticate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Login login = new Login(username, password);

        if (loginDao.validate(login)){
            User user = userDao.getUser(login);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("list");
        }else{
            System.out.println("Username: " + username);
            System.out.println("Password: " + password);
            System.out.println("Either of wrong!");
            HttpSession session = request.getSession();
            session.setAttribute("error-login", "Username or Password is Incorrect!");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}




















