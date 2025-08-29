package controller;

import dao.CategoryDAO;
import model.Category;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CashierCategoryServlet", value = "/CashierCategoryServlet")
public class CashierCategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }
    
    // Add this setter for testing
    protected void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // default action
        }
        
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertCategory(request, response);
                    break;
                case "delete":
                    deleteCategory(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateCategory(request, response);
                    break;
                case "search":
                    searchCategories(request, response);
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/categories.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/categoryForm.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category existingCategory = categoryDAO.getCategoryById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/categoryForm.jsp");
        request.setAttribute("category", existingCategory);
        dispatcher.forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Category newCategory = new Category(name, description);
        boolean success = categoryDAO.addCategory(newCategory);
        
        if (success) {
            request.getSession().setAttribute("successMessage", "Category added successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to add category. Please try again.");
        }
        
        response.sendRedirect(request.getContextPath() + "/CashierCategoryServlet?action=list");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Category category = new Category(name, description);
        category.setCategoryId(id);
        boolean success = categoryDAO.updateCategory(category);
        
        if (success) {
            request.getSession().setAttribute("successMessage", "Category updated successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to update category. Please try again.");
        }
        
        response.sendRedirect(request.getContextPath() + "/CashierCategoryServlet?action=list");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = categoryDAO.deleteCategory(id);
        
        if (success) {
            request.getSession().setAttribute("successMessage", "Category deleted successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to delete category. Please try again.");
        }
        
        response.sendRedirect(request.getContextPath() + "/CashierCategoryServlet?action=list");
    }

    private void searchCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Category> categories = categoryDAO.searchCategories(keyword);
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cashier/categories.jsp");
        dispatcher.forward(request, response);
    }
}