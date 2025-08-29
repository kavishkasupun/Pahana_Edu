<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content="Pahana Edu Dashboard"/>
  <meta name="author" content=""/>
  <title>Pahana Edu - Admin Dashboard</title>
  
  <!-- loader-->
  <link href="${pageContext.request.contextPath}/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  
  <!-- Vector CSS -->
  <link href="${pageContext.request.contextPath}/assets/plugins/vectormap/jquery-jvectormap-2.0.2.css" rel="stylesheet"/>
  
  <!-- simplebar CSS-->
  <link href="${pageContext.request.contextPath}/assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
  
  <!-- Bootstrap core CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  
  <!-- animate CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet" type="text/css"/>
  
  <!-- Icons CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet" type="text/css"/>
  
  <!-- Sidebar CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/sidebar-menu.css" rel="stylesheet"/>
  
  <!-- Custom Style-->
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
    /* Custom chart styles */
    .chart-container-1 {
      position: relative;
      height: 400px;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    /* Ensure all chart text is clearly visible */
    .chartjs-render-monitor text {
      fill: #ffffff !important;
      font-weight: 500;
    }
    
    .card-header h5 {
      color: #ffffff;
      font-weight: 600;
    }
  </style>
</head>

<body class="bg-theme bg-theme1">
 
<!-- Start wrapper-->
<div id="wrapper">
 
  <!--Start sidebar-wrapper-->
  <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
      <a href="${pageContext.request.contextPath}/AdminServlet">
        <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
        <h5 class="logo-text">Pahana Edu</h5>
      </a>
    </div>
    
    <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header">MAIN NAVIGATION</li>
      <li>
        <a href="${pageContext.request.contextPath}/AdminServlet" class="<%= request.getRequestURI().endsWith("/AdminServlet") ? "active" : "" %>">
          <i class="zmdi zmdi-view-dashboard"></i> <span>Dashboard</span>
        </a>
      </li>

      <li>
        <a href="${pageContext.request.contextPath}/CategoryServlet?action=list">
          <i class="zmdi zmdi-format-list-bulleted"></i> <span>Categories</span>
        </a>
      </li>
      
      <li>
		 <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="<%= request.getRequestURI().endsWith("products.jsp") ? "active" : "" %>">
		   <i class="zmdi zmdi-grid"></i> <span>Products</span>
		 </a>
	 </li>

     <li class="<%= request.getRequestURI().endsWith("accounts.jsp") ? "active" : "" %>">
	    <a href="${pageContext.request.contextPath}/Admin/accounts.jsp">
	        <i class="zmdi zmdi-face"></i> <span>Accounts</span>
	    </a>
	</li>
	
	<li>
	  <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new">
	    <i class="zmdi zmdi-shopping-cart"></i> <span>Cashier</span>
	  </a>
	</li>
	<li class="sidebar-header">REPORTS</li>
	<li>
	  <a href="${pageContext.request.contextPath}/InvoiceServlet?action=report" 
	     class="<%= request.getRequestURI().endsWith("salesReport.jsp") ? "active" : "" %>">
	    <i class="zmdi zmdi-receipt"></i> <span>Sales Report</span>
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

  <!--Start topbar header-->
  <header class="topbar-nav">
    <nav class="navbar navbar-expand fixed-top">
      <ul class="navbar-nav mr-auto align-items-center">
        <li class="nav-item">
          <a class="nav-link toggle-menu" href="javascript:void();">
            <i class="icon-menu menu-icon"></i>
          </a>
        </li>
<!--         <li class="nav-item">
          <form class="search-bar">
            <input type="text" class="form-control" placeholder="Enter keywords">
            <a href="javascript:void();"><i class="icon-magnifier"></i></a>
          </form>
        </li> -->
      </ul>
      
      <ul class="navbar-nav align-items-center right-nav-link">
        <li class="nav-item dropdown-lg">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
            <i class="fa fa-bell-o"></i>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
            <span class="user-profile">
              <img src="https://via.placeholder.com/110x110" class="img-circle" alt="Admin">
            </span>
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <li class="dropdown-item user-details">
              <a href="javaScript:void();">
                <div class="media">
                  <div class="avatar">
                    <img class="align-self-start mr-3" src="https://via.placeholder.com/110x110" alt="Admin">
                  </div>
                  <div class="media-body">
                    <h6 class="mt-2 user-title">
                      <%
                        User user = (User) session.getAttribute("user");
                        if (user != null) {
                          out.print(user.getUsername());
                        } else {
                          out.print("Admin");
                        }
                      %>
                    </h6>
                    <p class="user-subtitle">
                      <%
                        if (user != null) {
                          out.print(user.getEmail());
                        } else {
                          out.print("admin@pahana.edu");
                        }
                      %>
                    </p>
                  </div>
                </div>
              </a>
            </li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-power mr-2"></i> 
              <a href="${pageContext.request.contextPath}/Auth/index.jsp">Logout</a>
            </li>
          </ul>
        </li>
      </ul>
    </nav>
  </header>
  <!--End topbar header-->

  <div class="clearfix"></div>
  
   <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumb-->
      <div class="row pt-2 pb-2">
        <div class="col-sm-9">
          <h4 class="page-title">Sales Report</h4>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/Admin/adminDashboard.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Sales Report</li>
          </ol>
        </div>
      </div>
      <!-- End Breadcrumb-->
      
      <div class="row">
        <div class="col-lg-12">
          <div class="card">
            <div class="card-header">
              <h5>Filter Sales</h5>
            </div>
            <div class="card-body">
			    <form id="salesFilterForm" method="get" action="${pageContext.request.contextPath}/InvoiceServlet">
			        <input type="hidden" name="action" value="report">
			        <div class="form-row">
			            <div class="form-group col-md-4">
			                <label for="startDate">Start Date</label>
			                <input type="date" class="form-control" id="startDate" name="startDate" 
			                       value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" />" required>
			            </div>
			            <div class="form-group col-md-4">
			                <label for="endDate">End Date</label>
			                <input type="date" class="form-control" id="endDate" name="endDate" 
			                       value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" />" required>
			            </div>
			            <div class="form-group col-md-4 d-flex align-items-end">
			                <button type="submit" class="btn btn-primary px-4">Filter</button>
			                <button type="button" id="exportBtn" class="btn btn-success px-4 ml-2">Export to Excel</button>
			            </div>
			        </div>
			    </form>
			</div>
          </div>
        </div>
      </div>
      
      <!-- Daily Sales Chart -->
        <div class="row">
	    <div class="col-lg-12">
	      <div class="card">
	        <div class="card-header">
	          <h5>Daily Sales Summary</h5>
	        </div>
	        <div class="card-body">
	          <div class="chart-container-1">
	            <canvas id="dailySalesChart" height="100"></canvas>
	          </div>
	          <c:if test="${empty dailySales}">
	            <div class="alert alert-info mt-3">No sales data available for the selected date range.</div>
	          </c:if>
	        </div>
	      </div>
	    </div>
	  </div>
      
      <!-- Sales Details Table -->
      <div class="row">
        <div class="col-lg-12">
          <div class="card">
            <div class="card-header">
              <h5>Sales Details</h5>
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${not empty invoices}">
                  <div class="table-responsive">
                    <table id="salesTable" class="table table-bordered">
                      <thead>
                        <tr>
                          <th>Invoice ID</th>
                          <th>Date</th>
                          <th>Customer</th>
                          <th>Items</th>
                          <th>Total (Rs.)</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach items="${invoices}" var="invoice">
                          <tr>
                            <td>${invoice.invoiceId}</td>
                            <td><fmt:formatDate value="${invoice.invoiceDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                            <td>
                              <c:set var="customer" value="${customerDAO.getCustomerById(invoice.customerId)}" />
                              ${customer.name}
                            </td>
                            <td>
                              <c:set var="items" value="${invoiceItemDAO.getItemsByInvoiceId(invoice.invoiceId)}" />
                              ${items.size()} items
                            </td>
                            <td><fmt:formatNumber value="${invoice.total}" type="currency" currencySymbol="Rs. "/></td>
                            <td>
                              <a href="${pageContext.request.contextPath}/InvoiceServlet?action=view&id=${invoice.invoiceId}" 
                                 class="btn btn-sm btn-info">View</a>
                              <a href="${pageContext.request.contextPath}/InvoiceServlet?action=print&id=${invoice.invoiceId}" 
                                 class="btn btn-sm btn-warning">Print</a>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="alert alert-info">No sales found for the selected date range.</div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
      
    </div>
    <!-- End container-fluid-->
 <div class="right-sidebar">
    <div class="switcher-icon">
      <i class="zmdi zmdi-settings zmdi-hc-spin"></i>
    </div>
    <div class="right-sidebar-content">

      <p class="mb-0">Gaussion Texture</p>
      <hr>
      
      <ul class="switcher">
        <li id="theme1"></li>
        <li id="theme2"></li>
        <li id="theme3"></li>
        <li id="theme4"></li>
        <li id="theme5"></li>
        <li id="theme6"></li>
      </ul>

      <p class="mb-0">Gradient Background</p>
      <hr>
      
      <ul class="switcher">
        <li id="theme7"></li>
        <li id="theme8"></li>
        <li id="theme9"></li>
        <li id="theme10"></li>
        <li id="theme11"></li>
        <li id="theme12"></li>
		<li id="theme13"></li>
        <li id="theme14"></li>
        <li id="theme15"></li>
      </ul>
      
     </div>
   </div>
  </div><!--End content-wrapper-->
  
  <!--Start Back To Top Button-->
  <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i></a>
  <!--End Back To Top Button-->
  
  <!--Start footer-->
  <footer class="footer">
    <div class="container">
      <div class="text-center">
        Copyright &copy; <b><%= java.time.Year.now().getValue() %></b> Pahana Edu Management System
      </div>
    </div>
  </footer>
  <!--End footer-->
  
  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  
  <!-- simplebar js -->
  <script src="${pageContext.request.contextPath}/assets/plugins/simplebar/js/simplebar.js"></script>
  <!-- sidebar-menu js -->
  <script src="${pageContext.request.contextPath}/assets/js/sidebar-menu.js"></script>
  <!-- loader scripts -->
  <script src="${pageContext.request.contextPath}/assets/js/jquery.loading-indicator.js"></script>
  <!-- Custom scripts -->
  <script src="${pageContext.request.contextPath}/assets/js/app-script.js"></script>
 <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<!-- Then load Chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>

  <script>
$(document).ready(function() {
    // Set default dates if not set
    if (!$('#startDate').val()) {
        let defaultStart = new Date();
        defaultStart.setDate(defaultStart.getDate() - 7);
        $('#startDate').val(defaultStart.toISOString().substr(0, 10));
    }
    
    if (!$('#endDate').val()) {
        let defaultEnd = new Date();
        $('#endDate').val(defaultEnd.toISOString().substr(0, 10));
    }
    
    // Export button functionality
    $('#exportBtn').click(function() {
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        if (!startDate || !endDate) {
            alert('Please select both start and end dates');
            return;
        }
        window.location.href = '${pageContext.request.contextPath}/InvoiceServlet?action=export&startDate=' + 
                              startDate + '&endDate=' + endDate;
    });
    
    // Initialize DataTable if we have invoices
    <c:if test="${not empty invoices}">
    $('#salesTable').DataTable({
        "order": [[1, "desc"]],
        "language": {
            "emptyTable": "No sales data available for the selected period"
        },
        "dom": '<"top"lf>rt<"bottom"ip><"clear">',
        "responsive": true
    });
    </c:if>
    
    // Initialize chart only if we have data
    <c:if test="${not empty dailySales}">
    // Prepare data for chart
    var dailySalesData = {
        labels: [
            <c:forEach items="${dailySales}" var="entry" varStatus="loop">
                "${entry.key}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ],
        datasets: [{
            label: 'Daily Sales (Rs.)',
            data: [
                <c:forEach items="${dailySales}" var="entry" varStatus="loop">
                    ${entry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ],
            backgroundColor: 'rgba(75, 192, 192, 0.6)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 2,
            fill: true
        }]
    };
    
    // Get chart canvas
    var ctx = document.getElementById('dailySalesChart').getContext('2d');
    
    // Destroy previous chart instance if exists
    if (window.dailySalesChart instanceof Chart) {
        window.dailySalesChart.destroy();
    }
    
    // Create chart with improved visibility settings
    window.dailySalesChart = new Chart(ctx, {
        type: 'bar',
        data: dailySalesData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    labels: {
                        color: '#ffffff',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(0,0,0,0.8)',
                    titleColor: '#ffffff',
                    bodyColor: '#ffffff',
                    callbacks: {
                        label: function(context) {
                            return 'Rs. ' + context.parsed.y.toLocaleString();
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: '#ffffff',
                        font: {
                            weight: 'bold'
                        },
                        callback: function(value) {
                            return 'Rs. ' + value.toLocaleString();
                        }
                    },
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    }
                },
                x: {
                    ticks: {
                        color: '#ffffff',
                        font: {
                            weight: 'bold'
                        }
                    },
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
    </c:if>
  });
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