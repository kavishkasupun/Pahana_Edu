package controller;

import dao.ProductDAO;
import dao.InvoiceDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "AdminServlet", value = "/AdminServlet")
public class AdminServlet extends HttpServlet {
    private ProductDAO productDAO;
    private InvoiceDAO invoiceDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        invoiceDAO = new InvoiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all counts
            Map<String, Integer> counts = new HashMap<>();
            
            // 1. Total Products Count
            counts.put("productCount", productDAO.getTotalProductsCount());
            
            // 2. Low Stock Products Count (quantity <= 5 and > 0)
            counts.put("lowStockCount", productDAO.getLowStockProductsCount());
            
            // 3. Out of Stock Products Count (quantity = 0)
            counts.put("outOfStockCount", productDAO.getOutOfStockProductsCount());
            
            // 4. Total Sales Count
            counts.put("salesCount", invoiceDAO.getTotalSalesCount());
            
            // Set all attributes
            request.setAttribute("productCount", counts.get("productCount"));
            request.setAttribute("lowStockCount", counts.get("lowStockCount"));
            request.setAttribute("outOfStockCount", counts.get("outOfStockCount"));
            request.setAttribute("salesCount", counts.get("salesCount"));
            
            // Forward to adminDashboard.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/adminDashboard.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/Admin/adminDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}