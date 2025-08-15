package controller;

import dao.*;
import model.*;
import util.EmailUtility;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet(name = "CashierInvoiceServlet", urlPatterns = {"/CashierInvoiceServlet"})
public class CashierInvoiceServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CustomerDAO customerDAO;
    private InvoiceDAO invoiceDAO;
    private InvoiceItemDAO invoiceItemDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        customerDAO = new CustomerDAO();
        invoiceDAO = new InvoiceDAO();
        invoiceItemDAO = new InvoiceItemDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check session first
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null && !request.getRequestURI().endsWith("/CashierInvoiceServlet?action=print")) {
            response.sendRedirect(request.getContextPath() + "/Auth/index.jsp?sessionExpired=true");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewInvoiceForm(request, response);
                    break;
                case "list":
                    listInvoices(request, response);
                    break;
                case "view":
                    viewInvoice(request, response);
                    break;
                case "print":
                    printInvoice(request, response);
                    break;
                case "report":
                    showSalesReport(request, response);
                    break;
                case "export":
                    exportSalesToExcel(request, response);
                    break;
                default:
                    listInvoices(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check session first
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"Session expired\"}");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("CashierInvoiceServlet?action=list");
            return;
        }

        try {
            switch (action) {
                case "searchCustomer":
                    searchCustomer(request, response);
                    break;
                case "searchProduct":
                    searchProduct(request, response);
                    break;
                case "create":
                    createInvoice(request, response);
                    break;
                default:
                    listInvoices(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showNewInvoiceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/cashier.jsp");
        dispatcher.forward(request, response);
    }

    private void listInvoices(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Invoice> invoices = invoiceDAO.getAllInvoices();
        request.setAttribute("invoices", invoices);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/viewInvoice.jsp");
        dispatcher.forward(request, response);
    }

    private void viewInvoice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
            try {
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.isEmpty()) {
                    request.setAttribute("errorMessage", "Invoice ID is required");
                    request.getRequestDispatcher("/Cashier/viewInvoice.jsp").forward(request, response);
                    return;
                }

                int invoiceId;
                try {
                    invoiceId = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid Invoice ID format");
                    request.getRequestDispatcher("/Cashier/viewInvoice.jsp").forward(request, response);
                    return;
                }

                Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
                if (invoice == null) {
                    request.setAttribute("errorMessage", "Invoice not found with ID: " + invoiceId);
                    request.getRequestDispatcher("/Cashier/viewInvoice.jsp").forward(request, response);
                    return;
                }

                List<InvoiceItem> items = invoiceItemDAO.getItemsByInvoiceId(invoiceId);
                // Load products for each item
                for (InvoiceItem item : items) {
                    Product product = productDAO.getProductById(item.getProductId());
                    item.setProduct(product);
                }

                Customer customer = customerDAO.getCustomerById(invoice.getCustomerId());
                
                request.setAttribute("invoice", invoice);
                request.setAttribute("items", items);
                request.setAttribute("customer", customer);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/viewInvoice.jsp");
                dispatcher.forward(request, response);
                
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Error viewing invoice: " + e.getMessage());
                request.getRequestDispatcher("/Cashier/viewInvoice.jsp").forward(request, response);
            }
        }

    private void printInvoice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int invoiceId = Integer.parseInt(request.getParameter("id"));
        Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
        List<InvoiceItem> items = invoiceItemDAO.getItemsByInvoiceId(invoiceId);
        
        // Load product for each item
        for (InvoiceItem item : items) {
            Product product = productDAO.getProductById(item.getProductId());
            item.setProduct(product);
        }
        
        Customer customer = customerDAO.getCustomerById(invoice.getCustomerId());
        
        request.setAttribute("invoice", invoice);
        request.setAttribute("items", items);
        request.setAttribute("customer", customer);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/printInvoice.jsp");
        dispatcher.forward(request, response);
    }

    private void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerDAO.searchCustomers(keyword);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(customers));
    }

    private void searchProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");
        List<Product> products = productDAO.searchProducts(keyword, categoryId);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(products));
    }

    private void createInvoice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Gson gson = new Gson();
        Map<String, Object> responseData = new HashMap<>();
        Connection connection = null;

        try {
            // Validate user session first
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                responseData.put("success", false);
                responseData.put("message", "Session expired. Please log in again.");
                response.getWriter().write(gson.toJson(responseData));
                return;
            }

            // Get a new connection for transaction
            connection = DBConnection.getConnection();
            if (connection == null) {
                throw new SQLException("Failed to get database connection");
            }
            connection.setAutoCommit(false); // Start transaction

            // Validate required parameters
            if (request.getParameter("customerId") == null || request.getParameter("amountPaid") == null || 
                request.getParameter("items") == null) {
                throw new ServletException("Missing required parameters");
            }

            int customerId = Integer.parseInt(request.getParameter("customerId"));
            double amountPaid = Double.parseDouble(request.getParameter("amountPaid"));
            String itemsJson = request.getParameter("items");

            // Parse cart items
            List<CartItem1> cartItems = gson.fromJson(itemsJson, new TypeToken<List<CartItem1>>(){}.getType());
            if (cartItems == null || cartItems.isEmpty()) {
                throw new ServletException("No items in cart");
            }

            // Calculate totals
            double subtotal = cartItems.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();

            // Validate payment
            if (amountPaid < subtotal) {
                throw new ServletException("Amount paid is less than subtotal");
            }

            // Create invoice
            Invoice invoice = new Invoice();
            invoice.setCustomerId(customerId);
            invoice.setUserId(user.getId());
            invoice.setSubtotal(subtotal);
            invoice.setTotal(subtotal);
            invoice.setAmountPaid(amountPaid);
            invoice.setBalance(amountPaid - subtotal);
            invoice.setInvoiceDate(Timestamp.valueOf(LocalDateTime.now()));

            // Add invoice to database
            int invoiceId = invoiceDAO.addInvoice(invoice, connection); // Pass connection
            if (invoiceId <= 0) {
                throw new ServletException("Failed to create invoice");
            }

            // Add invoice items and update product quantities
            for (CartItem1 cartItem1 : cartItems) {
                // Check product availability
                Product product = productDAO.getProductById(cartItem1.getProductId(), connection);
                if (product == null) {
                    throw new ServletException("Product not found: " + cartItem1.getProductId());
                }
                
                if (product.getQuantity() < cartItem1.getQuantity()) {
                    throw new ServletException("Insufficient stock for product: " + product.getProductName());
                }

                // Create invoice item
                InvoiceItem item = new InvoiceItem();
                item.setInvoiceId(invoiceId);
                item.setProductId(cartItem1.getProductId());
                item.setQuantity(cartItem1.getQuantity());
                item.setUnitPrice(cartItem1.getPrice());
                item.setTotal(cartItem1.getPrice() * cartItem1.getQuantity());
                
                if (!invoiceItemDAO.addInvoiceItem(item, connection)) {
                    throw new ServletException("Failed to add invoice item");
                }

                // Update product stock
                product.setQuantity(product.getQuantity() - cartItem1.getQuantity());
                if (!productDAO.updateProduct(product, connection)) {
                    throw new ServletException("Failed to update product stock");
                }
            }

            // Commit transaction
            connection.commit();

            // Try to send email receipt
            boolean emailSent = false;
            try {
                emailSent = sendEmailReceipt(invoiceId, customerId);
            } catch (Exception e) {
                System.err.println("Failed to send email receipt: " + e.getMessage());
            }

            // Prepare success response
            responseData.put("success", true);
            responseData.put("invoiceId", invoiceId);
            responseData.put("emailSent", emailSent);

        } catch (Exception e) {
            // Rollback transaction if there's an error
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    System.err.println("Error during rollback: " + ex.getMessage());
                }
            }
            e.printStackTrace();
            responseData.put("success", false);
            responseData.put("message", e.getMessage());
        } finally {
            // Close connection
            if (connection != null) {
                try {
                    connection.setAutoCommit(true); // Reset auto-commit
                    connection.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }

        // Send response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(responseData));
    }

    private boolean sendEmailReceipt(int invoiceId, int customerId) {
        try {
            Invoice invoice = invoiceDAO.getInvoiceById(invoiceId);
            Customer customer = customerDAO.getCustomerById(customerId);
            List<InvoiceItem> items = invoiceItemDAO.getItemsByInvoiceId(invoiceId);
            
            // Load products for each item
            for (InvoiceItem item : items) {
                Product product = productDAO.getProductById(item.getProductId());
                item.setProduct(product);
            }
            
            String subject = "Your Invoice #" + invoiceId + " from Pahana Edu";
            
            // Build HTML content
            StringBuilder html = new StringBuilder();
            html.append("<!DOCTYPE html>");
            html.append("<html>");
            html.append("<head>");
            html.append("<meta charset='UTF-8'>");
            html.append("<style>");
            html.append("body { font-family: Arial, sans-serif; line-height: 1.6; margin: 20px; }");
            html.append("h2 { color: #2c3e50; }");
            html.append("table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
            html.append("th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }");
            html.append("th { background-color: #f2f2f2; }");
            html.append(".text-right { text-align: right; }");
            html.append(".total-row { font-weight: bold; }");
            html.append("</style>");
            html.append("</head>");
            html.append("<body>");
            
            // Invoice header
            html.append("<h2>Invoice #").append(invoiceId).append("</h2>");
            html.append("<p><strong>Date:</strong> ").append(invoice.getInvoiceDate()).append("</p>");
            
            // Customer details
            html.append("<h3>Customer Details</h3>");
            html.append("<p><strong>Name:</strong> ").append(customer.getName()).append("</p>");
            html.append("<p><strong>Email:</strong> ").append(customer.getEmail()).append("</p>");
            if (customer.getTelephone() != null && !customer.getTelephone().isEmpty()) {
                html.append("<p><strong>Phone:</strong> ").append(customer.getTelephone()).append("</p>");
            }
            
            // Items table
            html.append("<h3>Items</h3>");
            html.append("<table>");
            html.append("<thead><tr><th>Item</th><th>Qty</th><th>Price</th><th class='text-right'>Total</th></tr></thead>");
            html.append("<tbody>");
            
            for (InvoiceItem item : items) {
                html.append("<tr>");
                html.append("<td>").append(item.getProduct().getProductName()).append("</td>");
                html.append("<td>").append(item.getQuantity()).append("</td>");
                html.append("<td>Rs. ").append(String.format("%.2f", item.getUnitPrice())).append("</td>");
                html.append("<td class='text-right'>Rs. ").append(String.format("%.2f", item.getTotal())).append("</td>");
                html.append("</tr>");
            }
            
            // Summary
            html.append("<tr class='total-row'>");
            html.append("<td colspan='3'><strong>Subtotal:</strong></td>");
            html.append("<td class='text-right'>Rs. ").append(String.format("%.2f", invoice.getSubtotal())).append("</td>");
            html.append("</tr>");
            
            html.append("<tr class='total-row'>");
            html.append("<td colspan='3'><strong>Amount Paid:</strong></td>");
            html.append("<td class='text-right'>Rs. ").append(String.format("%.2f", invoice.getAmountPaid())).append("</td>");
            html.append("</tr>");
            
            html.append("<tr class='total-row'>");
            html.append("<td colspan='3'><strong>Balance:</strong></td>");
            html.append("<td class='text-right'>Rs. ").append(String.format("%.2f", invoice.getBalance())).append("</td>");
            html.append("</tr>");
            
            html.append("</tbody></table>");
            html.append("<p>Thank you for your purchase!</p>");
            html.append("</body></html>");
            
            // Send the email
            EmailUtility.sendHtmlEmail(customer.getEmail(), subject, html.toString());
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void showSalesReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            // Get date parameters from request or use defaults
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            
            Date startDate;
            Date endDate;
            
            // Set default date range (last 7 days) if parameters are not provided
            if (startDateParam == null || startDateParam.isEmpty()) {
                startDate = new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000));
            } else {
                startDate = dateFormat.parse(startDateParam);
            }
            
            if (endDateParam == null || endDateParam.isEmpty()) {
                endDate = new Date();
            } else {
                endDate = dateFormat.parse(endDateParam);
            }
            
            // Add one day to end date to include the entire day
            Calendar cal = Calendar.getInstance();
            cal.setTime(endDate);
            cal.add(Calendar.DATE, 1);
            endDate = cal.getTime();
            
            // Get both daily sales summary and invoices list
            Map<String, Double> dailySales = invoiceDAO.getDailySalesSummary(startDate, endDate);
            List<Invoice> invoices = invoiceDAO.getInvoicesByDateRange(startDate, endDate);
            
            // Set all required attributes
            request.setAttribute("dailySales", dailySales);
            request.setAttribute("invoices", invoices);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            
            // Also set DAOs in request for JSTL access
            request.setAttribute("customerDAO", customerDAO);
            request.setAttribute("invoiceItemDAO", invoiceItemDAO);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/salesReport.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error generating sales report: " + e.getMessage(), e);
        }
    }

    private void exportSalesToExcel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date startDate = dateFormat.parse(request.getParameter("startDate"));
                java.util.Date endDate = dateFormat.parse(request.getParameter("endDate"));
                
                List<Invoice> invoices = invoiceDAO.getInvoicesByDateRange(startDate, endDate);
                
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "attachment; filename=sales_report_" + 
                    dateFormat.format(startDate) + "_to_" + dateFormat.format(endDate) + ".xls");
                
                PrintWriter out = response.getWriter();
                
                // Excel header
                out.println("Invoice ID\tDate\tCustomer ID\tSubtotal\tTotal\tAmount Paid\tBalance");
                
                // Excel data rows
                for (Invoice invoice : invoices) {
                    out.println(
                        invoice.getInvoiceId() + "\t" +
                        invoice.getInvoiceDate() + "\t" +
                        invoice.getCustomerId() + "\t" +
                        invoice.getSubtotal() + "\t" +
                        invoice.getTotal() + "\t" +
                        invoice.getAmountPaid() + "\t" +
                        invoice.getBalance()
                    );
                }
                
                out.close();
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
}

class CartItem1 {
    private int productId;
    private String productName;
    private double price;
    private int quantity;
    
    // Getters and Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}