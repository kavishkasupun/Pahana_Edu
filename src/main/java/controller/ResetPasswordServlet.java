package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PasswordResetDAO;
import dao.UserDAO;

/**
 * Servlet implementation class ResetPasswordServlet
 */
@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String token = request.getParameter("token");
        PasswordResetDAO resetDao = new PasswordResetDAO();
        
        // Validate token
        String email = resetDao.validatePasswordResetToken(token);
        if(email != null) {
            // Token is valid, forward to reset page
            request.setAttribute("token", token);
            RequestDispatcher rd = request.getRequestDispatcher("/Auth/resetPassword.jsp");
            rd.forward(request, response);
        } else {
            // Invalid token
            request.setAttribute("error", "Invalid or expired token. Please request a new password reset.");
            RequestDispatcher rd = request.getRequestDispatcher("/Auth/forgot_password.jsp");
            rd.forward(request, response);
        }
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String token = req.getParameter("token");
	    String password = req.getParameter("password");
	    String confirmPassword = req.getParameter("confirmPassword");
	    
	    PasswordResetDAO resetDao = new PasswordResetDAO();
	    UserDAO userDao = new UserDAO();
	    
	    // Validate passwords match
	    if(!password.equals(confirmPassword)) {
	        req.setAttribute("error", "Passwords do not match.");
	        RequestDispatcher rd = req.getRequestDispatcher("/Auth/resetPassword.jsp?token=" + token);
	        rd.forward(req, res);
	        return;
	    }
	    
	    // Validate token
	    String email = resetDao.validatePasswordResetToken(token);
	    if(email != null) {
	        // Update password
	        if(userDao.updatePassword(email, password)) {
	            // Delete token
	            resetDao.deleteToken(token);
	            
	            req.setAttribute("message", "Password has been reset successfully. You can now login with your new password.");
	            RequestDispatcher rd = req.getRequestDispatcher("/Auth/index.jsp");
	            rd.forward(req, res);
	        } else {
	            req.setAttribute("error", "Password update failed. Please try again.");
	            RequestDispatcher rd = req.getRequestDispatcher("/Auth/resetPassword.jsp?token=" + token);
	            rd.forward(req, res);
	        }
	    } else {
	        req.setAttribute("error", "Invalid or expired token. Please request a new password reset.");
	        RequestDispatcher rd = req.getRequestDispatcher("/Auth/forgot_password.jsp");
	        rd.forward(req, res);
	    }
	}
}
