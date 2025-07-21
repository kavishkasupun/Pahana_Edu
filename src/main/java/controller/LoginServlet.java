package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import util.EmailUtility;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String usernameOrEmail = req.getParameter("username");
	    String password = req.getParameter("password");

	    UserDAO dao = new UserDAO();
	    User user = dao.checkLogin(usernameOrEmail, password);

	    if(user != null) {
	        HttpSession session = req.getSession();
	        session.setAttribute("user", user);

	        Cookie cookie = new Cookie("username", user.getUsername());
	        res.addCookie(cookie);

	        // Send email notification
	        try {
	            String emailContent = "Dear " + user.getUsername() + ",\n\n" +
	                "You have successfully logged into the Pahana Edu System at " + 
	                new java.util.Date() + ".\n\n" +
	                "If this was not you, please contact the system administrator immediately.\n\n" +
	                "Best regards,\n" +
	                "Pahana Edu Team";
	            
	            EmailUtility.sendEmail(user.getEmail(), "Login Notification", emailContent);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        // Redirect based on role
	        if(user.getRole().equals("admin")) {
	            res.sendRedirect(req.getContextPath() + "/Admin/adminDashboard.jsp");
	        } else if(user.getRole().equals("cashier")) {
	            res.sendRedirect(req.getContextPath() + "/Cashier/cashierDashboard.jsp");
	        } else {
	            // Handle other roles or default case
	            res.sendRedirect(req.getContextPath() + "/Auth/index.jsp");
	        }
	    } else {
	        req.setAttribute("error", "Invalid username or password");
	        RequestDispatcher rd = req.getRequestDispatcher("/Auth/index.jsp");
	        rd.forward(req, res);
	    }
	}
}
