package controller;

import dao.CategoryDAO;
import model.Category;
import org.junit.*;
import org.mockito.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;
import java.util.Arrays;

import static org.mockito.Mockito.*;

public class CategoryServletTest {

    private CategoryServlet servlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private CategoryDAO mockDAO;

    @Before
    public void setUp() throws Exception {
        servlet = new CategoryServlet();
        mockDAO = mock(CategoryDAO.class);
        servlet.setCategoryDAO(mockDAO);

        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);

        when(request.getRequestDispatcher(anyString())).thenReturn(dispatcher);
    }

    @Test
    public void testListCategories() throws Exception {
        when(mockDAO.getAllCategories()).thenReturn(Arrays.asList(
                new Category("Laptop", "Electronic")
        ));

        when(request.getParameter("action")).thenReturn(null); // null -> should default to list

        servlet.doGet(request, response);

        verify(request).setAttribute(eq("categories"), any());
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testInsertCategory() throws Exception {
        when(request.getParameter("action")).thenReturn("insert");
        when(request.getParameter("name")).thenReturn("Laptop");
        when(request.getParameter("description")).thenReturn("Electronic");

        servlet.doGet(request, response);

        verify(mockDAO).addCategory(any(Category.class));
        verify(response).sendRedirect(contains("/CategoryServlet?action=list"));
    }

    @Test
    public void testUpdateCategory() throws Exception {
        when(request.getParameter("action")).thenReturn("update");
        when(request.getParameter("id")).thenReturn("1");
        when(request.getParameter("name")).thenReturn("Desktop");
        when(request.getParameter("description")).thenReturn("Updated");

        servlet.doGet(request, response);

        verify(mockDAO).updateCategory(any(Category.class));
        verify(response).sendRedirect(contains("/CategoryServlet?action=list"));
    }

    @Test
    public void testDeleteCategory() throws Exception {
        when(request.getParameter("action")).thenReturn("delete");
        when(request.getParameter("id")).thenReturn("1");

        servlet.doGet(request, response);

        verify(mockDAO).deleteCategory(1);
        verify(response).sendRedirect(contains("/CategoryServlet?action=list"));
    }

    @Test
    public void testSearchCategories() throws Exception {
        when(request.getParameter("action")).thenReturn("search");
        when(request.getParameter("keyword")).thenReturn("Lap");

        when(mockDAO.searchCategories("Lap")).thenReturn(Arrays.asList(
                new Category("Laptop", "Electronic")
        ));

        servlet.doGet(request, response);

        verify(request).setAttribute(eq("categories"), any());
        verify(dispatcher).forward(request, response);
    }
}
