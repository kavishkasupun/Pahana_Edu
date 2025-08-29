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
  
  <!-- SweetAlert2 CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
  
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
   <!--Start sidebar-wrapper-->
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
        <a href="${pageContext.request.contextPath}/Cashier/cashierDashboard.jsp" class="<%= request.getRequestURI().endsWith("/cashierDashboard.jsp") ? "active" : "" %>">
          <i class="zmdi zmdi-view-dashboard"></i> <span>Dashboard</span>
        </a>
      </li>

      <li>
        <a href="${pageContext.request.contextPath}/CashierCategoryServlet?action=list">
          <i class="zmdi zmdi-format-list-bulleted"></i> <span>Categories</span>
        </a>
      </li>
      
      <li>
		 <a href="${pageContext.request.contextPath}/CashierProductServlet?action=list" class="<%= request.getRequestURI().endsWith("products.jsp") ? "active" : "" %>">
		   <i class="zmdi zmdi-grid"></i> <span>Products</span>
		 </a>
	 </li>

     <li class="<%= request.getRequestURI().endsWith("/CashierCustomerServlet") ? "active" : "" %>">
	    <a href="${pageContext.request.contextPath}/CashierCustomerServlet?action=list">
	        <i class="zmdi zmdi-face"></i> <span>Manage Customers</span>
	    </a>
	</li>
	
	<li>
	  <a href="${pageContext.request.contextPath}/CashierInvoiceServlet?action=new">
	    <i class="zmdi zmdi-shopping-cart"></i> <span>Cashier</span>
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
  <!--End sidebar-wrapper-->

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
                  <a href="${pageContext.request.contextPath}/ProductServlet?action=lowstock" class="btn btn-warning">
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
                             onclick="return confirmDelete(event, this.href)">
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

<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(document).ready(function() {
    // Check for success message and show SweetAlert
    <c:if test="${not empty sessionScope.successMessage}">
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${sessionScope.successMessage}',
            timer: 3000,
            showConfirmButton: false,
            position: 'top-end',
            toast: true,
            background: '#28a745',
            iconColor: '#fff',
            timerProgressBar: true,
            showClass: {
                popup: 'animate__animated animate__fadeInRight'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutRight'
            }
        });
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    
    // Check for error message and show SweetAlert
    <c:if test="${not empty sessionScope.errorMessage}">
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: '${sessionScope.errorMessage}',
            timer: 3000,
            showConfirmButton: false,
            position: 'top-end',
            toast: true,
            background: '#dc3545',
            iconColor: '#fff',
            timerProgressBar: true,
            showClass: {
                popup: 'animate__animated animate__fadeInRight'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutRight'
            }
        });
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

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

// Custom delete confirmation with SweetAlert
function confirmDelete(event, url) {
    event.preventDefault();
    
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel',
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading message
            Swal.fire({
                title: 'Deleting...',
                text: 'Please wait while we delete the product',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading()
                }
            });
            
            window.location.href = url;
        }
    });
    
    return false;
}
</script>

 <!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content" style="background: linear-gradient(135deg, #2c3e50 0%, #4a6491 100%); color: white; border-radius: 15px;">
      <div class="modal-header" style="border-bottom: 1px solid rgba(255,255,255,0.2);">
        <h5 class="modal-title" id="logoutModalLabel" style="color: #00c9ff;">
          <i class="fa fa-question-circle mr-2"></i>Confirm Logout
        </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center">
        <i class="fa fa-sign-out-alt fa-3x mb-3" style="color: #00c9ff;"></i>
        <h4>Are you sure you want to logout?</h4>
        <p>You will need to login again to access the system.</p>
      </div>
      <div class="modal-footer" style="border-top: 1px solid rgba(255,255,255,0.2);">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);">
          <i class="fa fa-times mr-2"></i>Cancel
        </button>
        <button type="button" class="btn btn-primary" id="confirmLogout" style="background: linear-gradient(45deg, #00c9ff, #92fe9d); border: none;">
          <i class="fa fa-sign-out-alt mr-2"></i>Yes, Logout
        </button>
      </div>
    </div>
  </div>
</div>

<script>
// Logout confirmation functionality
$(document).ready(function() {
    // Intercept logout link click
    $('a[href="${pageContext.request.contextPath}/Auth/index.jsp"]').on('click', function(e) {
        e.preventDefault(); // Prevent default link behavior
        $('#logoutModal').modal('show'); // Show confirmation modal
    });
    
    // Handle confirm logout button click
    $('#confirmLogout').on('click', function() {
        // Redirect to logout page after confirmation
        window.location.href = '${pageContext.request.contextPath}/Auth/index.jsp';
    });
    
    // Optional: Add keyboard support (ESC to close, Enter to confirm)
    $('#logoutModal').on('keydown', function(e) {
        if (e.key === 'Escape') {
            $(this).modal('hide');
        } else if (e.key === 'Enter' && $(this).hasClass('show')) {
            $('#confirmLogout').click();
        }
    });
});
</script>

</body>
</html>