package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Product;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                listProducts(request, response);
                return;
            }
            
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                case "lowstock":
                    listLowStockProducts(request, response);
                    break;
                case "search":
                    searchProducts(request, response);
                    break;
                case "list":
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void listLowStockProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getLowStockProducts();
        request.setAttribute("products", products);
        request.setAttribute("lowStockView", true);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", categoryDAO.getAllCategories());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/productForm.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productDAO.getProductById(id);
        request.setAttribute("product", existingProduct);
        request.setAttribute("categories", categoryDAO.getAllCategories());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/productForm.jsp");
        dispatcher.forward(request, response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Product product = new Product();
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setProductName(request.getParameter("productName"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                byte[] imageBytes = filePart.getInputStream().readAllBytes();
                product.setImage(imageBytes);
            }
            
            boolean success = productDAO.addProduct(product);
            
            if (success) {
                // Add success message to session
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Product added successfully!");
                response.sendRedirect("ProductServlet?action=list");
            } else {
                throw new Exception("Failed to add product to database");
            }
        } catch (Exception e) {
            // Add error message to session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error adding product: " + e.getMessage());
            response.sendRedirect("ProductServlet?action=new");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(id);
            
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setProductName(request.getParameter("productName"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                byte[] imageBytes = filePart.getInputStream().readAllBytes();
                product.setImage(imageBytes);
            }
            
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                // Add success message to session
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Product updated successfully!");
                response.sendRedirect("ProductServlet?action=list");
            } else {
                throw new Exception("Failed to update product in database");
            }
        } catch (Exception e) {
            // Add error message to session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error updating product: " + e.getMessage());
            response.sendRedirect("ProductServlet?action=edit&id=" + request.getParameter("id"));
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = productDAO.deleteProduct(id);
            
            if (success) {
                // Add success message to session
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Product deleted successfully!");
            } else {
                throw new Exception("Failed to delete product from database");
            }
        } catch (Exception e) {
            // Add error message to session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error deleting product: " + e.getMessage());
        }
        
        response.sendRedirect("ProductServlet?action=list");
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");
        
        List<Product> products = productDAO.searchProducts(keyword, categoryId);
        
        // Convert to JSON and send response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(products));
    }
}