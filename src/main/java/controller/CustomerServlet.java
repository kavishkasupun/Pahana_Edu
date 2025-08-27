package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import dao.CustomerDAO;
import util.EmailUtility;
import com.google.gson.Gson;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                listCustomers(request, response);
                return;
            }
            
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertCustomer(request, response);
                    break;
                case "delete":
                    deleteCustomer(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateCustomer(request, response);
                    break;
                case "search":  // New search action for cashier
                    searchCustomers(request, response);
                    break;
                default:
                    listCustomers(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/Admin/customers.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/customerForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/Admin/customerForm.jsp").forward(request, response);
    }

    private void insertCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        
        Customer customer = new Customer();
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setName(request.getParameter("name"));
        customer.setAddress(request.getParameter("address"));
        customer.setTelephone(request.getParameter("telephone"));
        customer.setEmail(request.getParameter("email"));
        
        if (customerDAO.addCustomer(customer)) {
            // Send welcome email
            String emailContent = "Dear " + customer.getName() + ",\n\n" +
                "Welcome to Pahana Edu! Your membership has been successfully created.\n\n" +
                "Account Number: " + customer.getAccountNumber() + "\n" +
                "Thank you for joining us.\n\n" +
                "Best regards,\n" +
                "Pahana Edu Team";
            
            EmailUtility.sendEmail(customer.getEmail(), "Welcome to Pahana Edu", emailContent);
            
            // Add success message to session
            session.setAttribute("successMessage", "Customer added successfully!");
            response.sendRedirect("CustomerServlet?action=list");
        } else {
            session.setAttribute("errorMessage", "Could not insert customer. Please try again.");
            response.sendRedirect("CustomerServlet?action=new");
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        
        Customer customer = new Customer();
        customer.setId(Integer.parseInt(request.getParameter("id")));
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setName(request.getParameter("name"));
        customer.setAddress(request.getParameter("address"));
        customer.setTelephone(request.getParameter("telephone"));
        customer.setEmail(request.getParameter("email"));
        
        if (customerDAO.updateCustomer(customer)) {
            // Add success message to session
            session.setAttribute("successMessage", "Customer updated successfully!");
            response.sendRedirect("CustomerServlet?action=list");
        } else {
            session.setAttribute("errorMessage", "Could not update customer. Please try again.");
            response.sendRedirect("CustomerServlet?action=edit&id=" + customer.getId());
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (customerDAO.deleteCustomer(id)) {
            // Add success message to session
            session.setAttribute("successMessage", "Customer deleted successfully!");
        } else {
            session.setAttribute("errorMessage", "Could not delete customer. Please try again.");
        }
        
        response.sendRedirect("CustomerServlet?action=list");
    }

    private void searchCustomers(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerDAO.searchCustomers(keyword);
        
        // Convert to JSON and send response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(customers));
    }
}