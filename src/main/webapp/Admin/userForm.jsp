<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("user");
    boolean isEditMode = user != null;
    String pageTitle = isEditMode ? "Edit Staff Member" : "Add Staff Member";
    String formAction = isEditMode ? 
        request.getContextPath() + "/UserManagementServlet?action=update&id=" + user.getId() : 
        request.getContextPath() + "/UserManagementServlet?action=insert";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - <%= pageTitle %></title>
  
  <!-- Same styles as adminDashboard -->
  <link href="${pageContext.request.contextPath}/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/assets/js/pace.min.js"></script>
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/sidebar-menu.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  
  <!-- SweetAlert2 CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>

<body class="bg-theme bg-theme1">
<div id="wrapper">
  <!-- Same sidebar as adminDashboard -->
  <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
      <a href="${pageContext.request.contextPath}/Admin/adminDashboard.jsp">
        <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
        <h5 class="logo-text">Pahana Edu</h5>
      </a>
    </div>
    <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header">MAIN NAVIGATION</li>
      <li>
        <a href="${pageContext.request.contextPath}/Admin/adminDashboard.jsp">
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
              <h4 class="card-title"><%= pageTitle %></h4>
            </div>
            <div class="card-body">
              <form action="<%= formAction %>" method="post" id="userForm">
                <div class="form-group">
                  <label for="username">Username</label>
                  <input type="text" class="form-control" id="username" name="username" 
                         value="<%= isEditMode ? user.getUsername() : "" %>" required>
                </div>
                
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" id="email" name="email" 
                         value="<%= isEditMode ? user.getEmail() : "" %>" required>
                </div>
                
                <div class="form-group">
                  <label for="password">Password <%= isEditMode ? "(Leave blank to keep current password)" : "" %></label>
                  <input type="password" class="form-control" id="password" name="password" 
                         <%= isEditMode ? "" : "required" %>>
                </div>
                
                <div class="form-group">
                  <label for="role">Role</label>
                  <select class="form-control" id="role" name="role" required>
                    <option value="cashier" <%= isEditMode && "cashier".equals(user.getRole()) ? "selected" : "" %>>Cashier</option>
                    <option value="admin" <%= isEditMode && "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                  </select>
                </div>
                
                <div class="form-group text-center">
                  <button type="submit" class="btn btn-primary mr-2">
                    <i class="fa fa-save"></i> <%= isEditMode ? "Update" : "Save" %>
                  </button>
                  <a href="${pageContext.request.contextPath}/UserManagementServlet?action=list" class="btn btn-light">
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

<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<script>
$(document).ready(function() {
    // Show success message if exists
    <% 
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) { 
        session.removeAttribute("successMessage");
    %>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '<%= successMessage %>',
            timer: 3000,
            showConfirmButton: false
        });
    <% } %>
    
    // Form validation
    $('#userForm').on('submit', function(e) {
        var password = $('#password').val();
        var isEditMode = <%= isEditMode %>;
        
        if (!isEditMode && (password === '' || password.length < 6)) {
            e.preventDefault();
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Password is required and must be at least 6 characters long'
            });
        }
    });
});
</script>
</body>
</html>