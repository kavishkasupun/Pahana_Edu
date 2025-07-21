<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - Customers</title>
  
  <!-- Same styles as adminDashboard -->
  <link href="${pageContext.request.contextPath}/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/assets/js/pace.min.js"></script>
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/sidebar-menu.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  
  <!-- DataTables CSS -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css"/>
  <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap4.min.css"/>
  
  <style>
    .dataTables_wrapper .dataTables_filter input {
      border: 1px solid #dee2e6;
      padding: 0.375rem 0.75rem;
      border-radius: 0.25rem;
    }
    .table thead th.sorting:after,
    .table thead th.sorting_asc:after,
    .table thead th.sorting_desc:after {
      color: #fff;
    }
    .table thead th {
      color: #fff;
      background-color: #343a40;
      border-color: #454d55;
    }
    .table td, .table th {
      vertical-align: middle;
    }
    .btn-sm {
      padding: 0.25rem 0.5rem;
      font-size: 0.875rem;
      line-height: 1.5;
    }
  </style>
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
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">Customer Management</h4>
              <div class="card-action">
                <a href="${pageContext.request.contextPath}/CustomerServlet?action=new" class="btn btn-primary">
                  <i class="fa fa-plus"></i> Add New
                </a>
              </div>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table id="customersTable" class="table table-bordered table-hover display nowrap" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Account No</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Telephone</th>
                      <th>Created At</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% 
                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                    if (customers != null && !customers.isEmpty()) {
                      for (Customer customer : customers) { 
                    %>
                    <tr>
                      <td><%= customer.getId() %></td>
                      <td><%= customer.getAccountNumber() %></td>
                      <td><%= customer.getName() %></td>
                      <td><%= customer.getEmail() %></td>
                      <td><%= customer.getTelephone() %></td>
                      <td><%= customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : "" %></td>
                      <td>
                        <a href="${pageContext.request.contextPath}/CustomerServlet?action=edit&id=<%= customer.getId() %>" 
                           class="btn btn-sm btn-warning">
                          <i class="fa fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/CustomerServlet?action=delete&id=<%= customer.getId() %>" 
                           class="btn btn-sm btn-danger" 
                           onclick="return confirm('Are you sure you want to delete this customer?')">
                          <i class="fa fa-trash"></i>
                        </a>
                      </td>
                    </tr>
                    <% } 
                    } else { %>
                    <tr>
                      <td colspan="7" class="text-center">No customers found</td>
                    </tr>
                    <% } %>
                  </tbody>
                </table>
              </div>
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

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap4.min.js"></script>



<script>
$(document).ready(function() {
    $('#customersTable').DataTable({
        responsive: true,
        dom: '<"top"lf>rt<"bottom"ip><"clear">',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search customers...",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            infoEmpty: "Showing 0 to 0 of 0 entries",
            infoFiltered: "(filtered from _MAX_ total entries)",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        },
        columns: [
            { data: 'id' },        // Column 0: ID
            { data: 'accountNo' }, // Column 1: Account No
            { data: 'name' },      // Column 2: Name
            { data: 'email' },     // Column 3: Email
            { data: 'telephone' }, // Column 4: Telephone
            { data: 'createdAt' }, // Column 5: Created At
            { data: 'actions' }    // Column 6: Actions
        ],
        columnDefs: [
            { 
                targets: [6], // Actions column (index 6)
                orderable: false,
                searchable: false
            },
            {
                targets: [5], // Created At column (index 5)
                render: function(data, type, row) {
                    if (type === 'display' || type === 'filter') {
                        if (data) {
                            return new Date(data).toLocaleString();
                        }
                        return '';
                    }
                    return data;
                }
            },
            { responsivePriority: 1, targets: 2 }, // Name (highest priority)
            { responsivePriority: 2, targets: 1 }, // Account No
            { responsivePriority: 3, targets: 3 }  // Email
        ]
    });
});
</script>
</body>
</html>