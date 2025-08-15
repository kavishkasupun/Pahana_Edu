<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - <%= request.getParameter("id") != null ? "Edit" : "Add" %> Customer</title>
  
  <!-- Same styles as adminDashboard -->
  <link href="${pageContext.request.contextPath}/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/assets/js/pace.min.js"></script>
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/sidebar-menu.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>

<body class="bg-theme bg-theme1">
<div id="wrapper">
  <!-- Same sidebar as adminDashboard -->
  <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
      <a href="${pageContext.request.contextPath}/Cashier/cashierDashboard.jsp">
        <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
        <h5 class="logo-text">Pahana Edu</h5>
      </a>
    </div>
    <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header">MAIN NAVIGATION</li>
      <li>
        <a href="${pageContext.request.contextPath}/Cashier/cashierDashboard.jsp">
          <i class="zmdi zmdi-view-dashboard"></i> <span>Dashboard</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/CategoryServlet?action=list">
          <i class="zmdi zmdi-format-list-bulleted"></i> <span>Categories</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/ProductServlet?action=list">
          <i class="zmdi zmdi-grid"></i> <span>Products</span>
        </a>
      </li>
      <li class="active">
        <a href="accounts.jsp">
          <i class="zmdi zmdi-face"></i> <span>Accounts</span>
        </a>
      </li>
      <li class="sidebar-header">SETTINGS</li>
      <li>
        <a href="${pageContext.request.contextPath}/Auth/index.jsp">
          <i class="zmdi zmdi-power"></i> <span>Logout</span>
        </a>
      </li>
    </ul>
  </div>

  <header class="topbar-nav">
    <nav class="navbar navbar-expand fixed-top">
      <!-- Same topbar as adminDashboard -->
    </nav>
  </header>

  <div class="clearfix"></div>
  
  <div class="content-wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12 col-lg-6 mx-auto">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title"><%= request.getParameter("id") != null ? "Edit" : "Add" %> Customer</h4>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/CashierCustomerServlet?action=<%= request.getParameter("id") != null ? "update" : "insert" %>" method="post">
                <% if (request.getParameter("id") != null || (request.getAttribute("customer") != null && ((Customer)request.getAttribute("customer")).getId() > 0)) { %>
                <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : ((Customer)request.getAttribute("customer")).getId() %>">
                <% } %>
                
                <div class="form-group">
                  <label for="accountNumber">Account Number</label>
                  <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                         value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getAccountNumber() : "" %>" required>
                </div>
                
                <div class="form-group">
                  <label for="name">Full Name</label>
                  <input type="text" class="form-control" id="name" name="name" 
                         value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getName() : "" %>" required>
                </div>
                
                <div class="form-group">
                  <label for="address">Address</label>
                  <textarea class="form-control" id="address" name="address" rows="3" required><%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getAddress() : "" %></textarea>
                </div>
                
                <div class="form-group">
                  <label for="telephone">Telephone</label>
                  <input type="tel" class="form-control" id="telephone" name="telephone" 
                         value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getTelephone() : "" %>" required>
                </div>
                
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" id="email" name="email" 
                         value="<%= request.getAttribute("customer") != null ? ((Customer)request.getAttribute("customer")).getEmail() : "" %>" required>
                </div>
                
                <div class="form-group text-center">
                  <button type="submit" class="btn btn-primary mr-2">
                    <i class="fa fa-save"></i> Save
                  </button>
                  <a href="${pageContext.request.contextPath}/CashierCustomerServlet?action=list" class="btn btn-light">
                    <i class="fa fa-times"></i> Cancel
                  </a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Same footer as adminDashboard -->
  <footer class="footer">
    <div class="container">
      <div class="text-center">
        Copyright &copy; <b><%= java.time.Year.now().getValue() %></b> Pahana Edu Management System
      </div>
    </div>
  </footer>
</div>

<!-- Same scripts as adminDashboard -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/simplebar/js/simplebar.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar-menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app-script.js"></script>
</body>
</html>