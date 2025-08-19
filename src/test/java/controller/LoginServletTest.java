package controller;

import dao.UserDAO;
import model.User;
import org.junit.*;
import org.mockito.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;

import java.io.PrintWriter;
import java.io.StringWriter;

import static org.mockito.Mockito.*;
import static org.junit.Assert.*;

public class LoginServletTest {

    private LoginServlet servlet;
    private UserDAO mockUserDAO;

    @Mock private HttpServletRequest request;
    @Mock private HttpServletResponse response;
    @Mock private HttpSession session;
    @Mock private RequestDispatcher dispatcher;

    private StringWriter responseWriter;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);

        servlet = new LoginServlet();
        mockUserDAO = mock(UserDAO.class);
        servlet.setUserDAO(mockUserDAO);

        responseWriter = new StringWriter();
        when(response.getWriter()).thenReturn(new PrintWriter(responseWriter));
        when(request.getSession()).thenReturn(session);
    }

    @Test
    public void testSuccessfulLogin_AdminRedirect() throws Exception {
        User user = new User();
        user.setUsername("admin");
        user.setEmail("admin@example.com");
        user.setRole("admin");

        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("1234");
        when(mockUserDAO.checkLogin("admin", "1234")).thenReturn(user);

        servlet.doPost(request, response);

        verify(session).setAttribute("user", user);
        verify(response).sendRedirect(contains("/AdminServlet"));
        verify(request, never()).getRequestDispatcher(anyString());
    }

    @Test
    public void testSuccessfulLogin_CashierRedirect() throws Exception {
        User user = new User();
        user.setUsername("cashier");
        user.setEmail("cashier@example.com");
        user.setRole("cashier");

        when(request.getParameter("username")).thenReturn("cashier");
        when(request.getParameter("password")).thenReturn("1234");
        when(mockUserDAO.checkLogin("cashier", "1234")).thenReturn(user);

        servlet.doPost(request, response);

        verify(session).setAttribute("user", user);
        verify(response).sendRedirect(contains("/Cashier/cashierDashboard.jsp"));
        verify(request, never()).getRequestDispatcher(anyString());
    }

    @Test
    public void testInvalidLogin() throws Exception {
        when(request.getParameter("username")).thenReturn("wrong");
        when(request.getParameter("password")).thenReturn("wrong");
        when(mockUserDAO.checkLogin("wrong", "wrong")).thenReturn(null);

        when(request.getRequestDispatcher("/Auth/index.jsp")).thenReturn(dispatcher);

        servlet.doPost(request, response);

        verify(request).setAttribute("error", "Invalid username or password");
        verify(dispatcher).forward(request, response);
        verify(response, never()).sendRedirect(anyString());
    }
}
