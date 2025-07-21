package controller;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import dao.UserDAO;
import dao.PasswordResetDAO;
import util.EmailUtility;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private PasswordResetDAO passwordResetDAO;

    public void init() {
        userDAO = new UserDAO();
        passwordResetDAO = new PasswordResetDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Admin/users.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/userForm.jsp").forward(request, response);
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        
        if (userDAO.addUser(user)) {
            // Generate password reset token
            String token = UUID.randomUUID().toString();
            passwordResetDAO.createPasswordResetToken(user.getEmail(), token);
            
            // Build reset password link
            String resetLink = request.getRequestURL().toString()
                .replace("UserManagementServlet", "Auth/resetPassword.jsp")
                + "?token=" + token;
            
            // Send account creation email with reset link
            String emailContent = "Dear " + user.getUsername() + ",\n\n" +
                "Your Pahana Edu account has been successfully created.\n\n" +
                "Username: " + user.getUsername() + "\n" +
                "Role: " + user.getRole() + "\n\n" +
                "Please set your password by clicking the following link:\n" +
                resetLink + "\n\n" +
                "This link will expire in 1 hour.\n\n" +
                "Best regards,\n" +
                "Pahana Edu Team";
            
            EmailUtility.sendEmail(user.getEmail(), "Your Pahana Edu Account - Set Your Password", emailContent);
            
            response.sendRedirect("UserManagementServlet?action=list");
        } else {
            throw new Exception("Could not insert user");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (userDAO.deleteUser(id)) {
            response.sendRedirect("UserManagementServlet?action=list");
        } else {
            throw new Exception("Could not delete user");
        }
    }
}