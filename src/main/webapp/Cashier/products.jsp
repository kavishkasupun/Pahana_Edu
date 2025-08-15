<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - Products</title>
  
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
    .out-of-stock {
      background-color: rgba(220, 53, 69, 0.1) !important;
    }
    .low-stock {
      background-color: rgba(255, 193, 7, 0.1) !important;
    }
    .product-image {
      max-width: 80px;
      max-height: 80px;
      border-radius: 4px;
    }
    .stock-badge {
      font-size: 0.75rem;
      padding: 0.25em 0.4em;
    }
  </style>
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
        <a href="${pageContext.request.contextPath}/CashierProductServlet?action=list" class="active">
          <i class="zmdi zmdi-grid"></i> <span>Products</span>
        </a>
      </li>
      <!-- Other menu items -->
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
              <h4 class="card-title">
                <c:choose>
                  <c:when test="${not empty lowStockView}">Low Stock Products</c:when>
                  <c:otherwise>All Products</c:otherwise>
                </c:choose>
              </h4>
              <div class="card-action">
                <div class="btn-group" role="group">
                  <a href="${pageContext.request.contextPath}/CashierProductServlet?action=new" class="btn btn-primary">
                    <i class="fa fa-plus"></i> Add New
                  </a>
                  <a href="${pageContext.request.contextPath}/CashierProductServlet?action=lowstock" class="btn btn-warning">
                    <i class="fa fa-exclamation-triangle"></i> Low Stock
                  </a>
                  <a href="${pageContext.request.contextPath}/CashierProductServlet?action=list" class="btn btn-info">
                    <i class="fa fa-list"></i> View All
                  </a>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table id="productsTable" class="table table-bordered table-hover display nowrap" style="width:100%">
                  <thead>
                    <tr>
                      <th>Image</th>
                      <th>Product Name</th>
                      <th>Category</th>
                      <th>Price</th>
                      <th>Stock</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="product" items="${products}">
                      <tr class="${product.quantity == 0 ? 'out-of-stock' : (product.quantity <= 5 ? 'low-stock' : '')}">
                        <td>
                          <c:if test="${not empty product.imageBase64}">
                            <img src="data:image/jpeg;base64,${product.imageBase64}" class="product-image" alt="${product.productName}">
                          </c:if>
                        </td>
                        <td>${product.productName}</td>
                        <td>${product.categoryName}</td>
                        <td>Rs. ${product.price}</td>
                        <td>
                          ${product.quantity}
                          <c:if test="${product.quantity == 0}">
                            <span class="badge badge-danger stock-badge">Out of Stock</span>
                          </c:if>
                          <c:if test="${product.quantity > 0 && product.quantity <= 5}">
                            <span class="badge badge-warning stock-badge">Low Stock</span>
                          </c:if>
                        </td>
                        <td>
                          <a href="${pageContext.request.contextPath}/CashierProductServlet?action=edit&id=${product.productId}" 
                             class="btn btn-sm btn-warning">
                            <i class="fa fa-edit"></i>
                          </a>
                          <a href="${pageContext.request.contextPath}/CashierProductServlet?action=delete&id=${product.productId}" 
                             class="btn btn-sm btn-danger" 
                             onclick="return confirm('Are you sure you want to delete this product?')">
                            <i class="fa fa-trash"></i>
                          </a>
                        </td>
                      </tr>
                    </c:forEach>
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
    $('#productsTable').DataTable({
        responsive: true,
        dom: '<"top"lf>rt<"bottom"ip><"clear">',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search products...",
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
        columnDefs: [
            { responsivePriority: 1, targets: 1 }, // Product Name
            { responsivePriority: 2, targets: 5 }, // Actions
            { responsivePriority: 3, targets: 2 }, // Category
            { 
                targets: 5, // Actions column
                orderable: false,
                searchable: false
            },
            {
                targets: 0, // Image column
                orderable: false,
                searchable: false
            },
            {
                targets: 3, // Price column
                render: function(data, type, row) {
                    if (type === 'display') {
                        return 'Rs. ' + data;
                    }
                    return data;
                }
            }
        ],
        initComplete: function() {
            // Add custom search field
            $('.dataTables_filter').html(
                '<div class="input-group mb-3">' +
                '<input type="search" class="form-control" placeholder="Search products..." aria-label="Search">' +
                '<div class="input-group-append">' +
                '<button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>' +
                '</div></div>'
            );
            
            // Apply search on button click
            $('.dataTables_filter button').on('click', function() {
                var table = $('#productsTable').DataTable();
                table.search($('.dataTables_filter input').val()).draw();
            });
            
            // Apply search on enter key
            $('.dataTables_filter input').on('keyup', function(e) {
                if (e.keyCode === 13) {
                    var table = $('#productsTable').DataTable();
                    table.search(this.value).draw();
                }
            });
        }
    });
});
</script>
</body>
</html>