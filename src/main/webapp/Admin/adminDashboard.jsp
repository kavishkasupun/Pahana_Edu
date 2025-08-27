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
    
    /* Help Section Styles - Theme Matching */
    .help-section {
      background: linear-gradient(135deg, #2c3e50 0%, #4a6491 100%);
      border-radius: 15px;
      padding: 25px;
      margin-top: 30px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      border: 1px solid rgba(255,255,255,0.1);
    }
    
    .help-card {
      transition: all 0.3s ease;
      height: 100%;
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.15);
      border-radius: 12px;
      backdrop-filter: blur(10px);
    }
    
    .help-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.3);
      background: rgba(255, 255, 255, 0.15);
    }
    
    .help-icon {
      font-size: 3rem;
      margin-bottom: 20px;
      color: #00c9ff;
      text-shadow: 0 0 15px rgba(0, 201, 255, 0.5);
    }
    
    .help-card h5 {
      color: #ffffff;
      font-weight: 600;
      margin-bottom: 15px;
    }
    
    .help-card p {
      color: rgba(255, 255, 255, 0.8);
      margin-bottom: 20px;
    }
    
    .help-card .btn {
      background: linear-gradient(45deg, #00c9ff, #92fe9d);
      border: none;
      border-radius: 25px;
      padding: 10px 25px;
      font-weight: 600;
      color: #2c3e50;
      transition: all 0.3s ease;
    }
    
    .help-card .btn:hover {
      transform: scale(1.05);
      box-shadow: 0 5px 15px rgba(0, 201, 255, 0.4);
    }
    
    .help-modal .modal-content {
      border-radius: 20px;
      background: linear-gradient(135deg, #2c3e50 0%, #4a6491 100%);
      border: 1px solid rgba(255,255,255,0.1);
      color: white;
    }
    
    .help-modal .modal-header {
      background: rgba(0, 0, 0, 0.2);
      border-bottom: 1px solid rgba(255,255,255,0.1);
      border-radius: 20px 20px 0 0;
      padding: 20px;
    }
    
    .help-modal .modal-title {
      color: #00c9ff;
      font-weight: 600;
    }
    
    .help-modal .close {
      color: white;
      text-shadow: none;
      opacity: 0.8;
    }
    
    .help-modal .close:hover {
      opacity: 1;
      color: #00c9ff;
    }
    
    .help-modal .modal-body {
      padding: 25px;
      background: rgba(255, 255, 255, 0.05);
    }
    
    .help-modal .modal-footer {
      background: rgba(0, 0, 0, 0.2);
      border-top: 1px solid rgba(255,255,255,0.1);
      border-radius: 0 0 20px 20px;
      padding: 20px;
    }
    
    .help-modal .btn-primary {
      background: linear-gradient(45deg, #00c9ff, #92fe9d);
      border: none;
      border-radius: 25px;
      padding: 10px 25px;
      font-weight: 600;
      color: #2c3e50;
    }
    
    .help-modal .btn-secondary {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 25px;
      padding: 10px 25px;
      font-weight: 600;
      color: white;
    }
    
    /* Quick Links Styles */
    .quick-links-card {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.15);
      border-radius: 12px;
      backdrop-filter: blur(10px);
    }
    
    .quick-links-card .card-header {
      background: rgba(0, 0, 0, 0.2);
      border-bottom: 1px solid rgba(255,255,255,0.1);
      color: #00c9ff;
      font-weight: 600;
    }
    
    .quick-link-item {
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 10px;
      padding: 20px;
      transition: all 0.3s ease;
      height: 100%;
    }
    
    .quick-link-item:hover {
      background: rgba(255, 255, 255, 0.15);
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    
    .quick-link-item i {
      font-size: 2.5rem;
      margin-bottom: 15px;
      background: linear-gradient(45deg, #00c9ff, #92fe9d);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    
    .quick-link-item p {
      color: rgba(255, 255, 255, 0.9);
      margin: 0;
      font-weight: 500;
    }
    
    /* Accordion Styles */
    .accordion .card {
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid rgba(255, 255, 255, 0.1);
      margin-bottom: 15px;
      border-radius: 10px;
    }
    
    .accordion .card-header {
      background: rgba(0, 0, 0, 0.2);
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    
    .accordion .btn-link {
      color: #00c9ff;
      text-decoration: none;
      font-weight: 600;
      width: 100%;
      text-align: left;
    }
    
    .accordion .btn-link:hover {
      color: #92fe9d;
    }
    
    .accordion .card-body {
      color: rgba(255, 255, 255, 0.9);
    }
    
    /* List Group Styles */
    .list-group-item {
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: rgba(255, 255, 255, 0.9);
      margin-bottom: 10px;
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    
    .list-group-item:hover {
      background: rgba(255, 255, 255, 0.1);
      transform: translateX(5px);
    }
    
    /* Form Styles */
    .form-control {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      color: white;
      border-radius: 8px;
    }
    
    .form-control:focus {
      background: rgba(255, 255, 255, 0.15);
      border-color: #00c9ff;
      box-shadow: 0 0 0 0.2rem rgba(0, 201, 255, 0.25);
      color: white;
    }
    
    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.6);
    }
    
    /* Support Options */
    .support-options p {
      color: rgba(255, 255, 255, 0.8);
      margin-bottom: 10px;
    }
    
    .support-options i {
      color: #00c9ff;
      width: 20px;
      margin-right: 10px;
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
	
	<!-- Help Section Menu Item -->
	<li class="sidebar-header">SUPPORT</li>
	<li>
	  <a href="#" id="helpMenuLink">
	    <i class="zmdi zmdi-help" style="color: #00c9ff;"></i> <span style="color: #00c9ff;">Help & Support</span>
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
        <li class="nav-item">
          <form class="search-bar">
            <input type="text" class="form-control" placeholder="Enter keywords">
            <a href="javascript:void();"><i class="icon-magnifier"></i></a>
          </form>
        </li>
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
              <img src="https://via.placeholder.com/110x110" class="img-circle" alt="user avatar">
            </span>
          </a>
          <ul class="dropdown-menu dropdown-menu-right">
            <li class="dropdown-item user-details">
              <a href="javaScript:void();">
                <div class="media">
                  <div class="avatar">
                    <img class="align-self-start mr-3" src="https://via.placeholder.com/110x110" alt="user avatar">
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
            <li class="dropdown-item"><i class="icon-settings mr-2"></i> Setting</li>
            <li class="dropdown-divider"></li>
            <li class="dropdown-item"><i class="icon-power mr-2"></i> 
              <a href="${pageContext.request.contextPath}/Auth/index.jsp">Logout</a>
            </li>
          </ul>
        </li>
        
        <!-- Help Button in Top Navigation -->
        <li class="nav-item">
          <a class="nav-link" href="#" id="topHelpBtn" title="Help" style="color: #00c9ff;">
            <i class="fa fa-question-circle fa-lg"></i>
          </a>
        </li>
      </ul>
    </nav>
  </header>
  <!--End topbar header-->

  <div class="clearfix"></div>
  
  <div class="content-wrapper">
    <div class="container-fluid">
     <!-- Dashboard Cards Section -->
		<div class="card mt-3">
		  <div class="card-content">
		    <div class="row row-group m-0">
		      <div class="col-12 col-lg-6 col-xl-3 border-light">
		        <div class="card-body">
		          <h5 class="text-white mb-0">${not empty productCount ? productCount : 0} <span class="float-right"><i class="fa fa-cubes"></i></span></h5>
		          <div class="progress my-3" style="height:3px;">
		            <div class="progress-bar" style="width:55%"></div>
		          </div>
		          <p class="mb-0 text-white small-font">Total Products <span class="float-right"><i class="zmdi zmdi-long-arrow-up"></i></span></p>
		        </div>
		      </div>
		      <div class="col-12 col-lg-6 col-xl-3 border-light">
		        <div class="card-body">
		          <h5 class="text-white mb-0">${not empty lowStockCount ? lowStockCount : 0} <span class="float-right"><i class="fa fa-exclamation-triangle"></i></span></h5>
		          <div class="progress my-3" style="height:3px;">
		            <div class="progress-bar" style="width:55%"></div>
		          </div>
		          <p class="mb-0 text-white small-font">Low Stock Items <span class="float-right"><i class="zmdi zmdi-long-arrow-up"></i></span></p>
		        </div>
		      </div>
		      <div class="col-12 col-lg-6 col-xl-3 border-light">
		        <div class="card-body">
		          <h5 class="text-white mb-0">${not empty outOfStockCount ? outOfStockCount : 0} <span class="float-right"><i class="fa fa-times-circle"></i></span></h5>
		          <div class="progress my-3" style="height:3px;">
		            <div class="progress-bar" style="width:55%"></div>
		          </div>
		          <p class="mb-0 text-white small-font">Out of Stock <span class="float-right"><i class="zmdi zmdi-long-arrow-up"></i></span></p>
		        </div>
		      </div>
		      <div class="col-12 col-lg-6 col-xl-3 border-light">
		        <div class="card-body">
		          <h5 class="text-white mb-0">
		            <c:choose>
		              <c:when test="${not empty totalSalesAmount}">
		                <fmt:formatNumber value="${totalSalesAmount}" type="currency" currencySymbol="Rs. "/>
		              </c:when>
		              <c:otherwise>Rs. 0.00</c:otherwise>
		            </c:choose>
		            <span class="float-right"><i class="fa fa-chart-line"></i></span>
		          </h5>
		          <div class="progress my-3" style="height:3px;">
		            <div class="progress-bar" style="width:55%"></div>
		          </div>
		          <p class="mb-0 text-white small-font">
		            Total Sales (${not empty salesCount ? salesCount : 0} transactions)
		            <span class="float-right"><i class="zmdi zmdi-long-arrow-up"></i></span>
		          </p>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Sales Chart -->
		<div class="row">
		  <div class="col-lg-12">
		    <div class="card">
		      <div class="card-header">
		        <h5>Recent Sales Performance</h5>
		      </div>
		      <div class="card-body">
		        <div class="chart-container-1">
		          <canvas id="salesChart" height="100"></canvas>
		        </div>
		        <c:if test="${empty recentSales}">
		          <div class="alert alert-info mt-3">No recent sales data available.</div>
		        </c:if>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Recent Sales Table -->
		<div class="row">
		  <div class="col-lg-12">
		    <div class="card">
		      <div class="card-header">
		        <h5>Recent Sales</h5>
		      </div>
		      <div class="card-body">
		        <c:choose>
		          <c:when test="${not empty recentInvoices}">
		            <div class="table-responsive">
		              <table id="recentSalesTable" class="table table-bordered">
		                <thead>
		                  <tr>
		                    <th>Invoice ID</th>
		                    <th>Date</th>
		                    <th>Customer</th>
		                    <th>Items</th>
		                    <th>Total (Rs.)</th>
		                  </tr>
		                </thead>
		                <tbody>
		                  <c:forEach items="${recentInvoices}" var="invoice">
		                    <tr>
		                      <td>${invoice.invoiceId}</td>
		                      <td><fmt:formatDate value="${invoice.invoiceDate}" pattern="yyyy-MM-dd HH:mm" /></td>
		                      <td>
		                        <c:set var="customer" value="${customerDAO.getCustomerById(invoice.customerId)}" />
		                        ${not empty customer ? customer.name : 'Guest Customer'}
		                      </td>
		                      <td>
		                        <c:set var="items" value="${invoiceItemDAO.getItemsByInvoiceId(invoice.invoiceId)}" />
		                        ${not empty items ? items.size() : 0} items
		                      </td>
		                      <td><fmt:formatNumber value="${invoice.total}" type="currency" currencySymbol="Rs. "/></td>
		                    </tr>
		                  </c:forEach>
		                </tbody>
		              </table>
		            </div>
		          </c:when>
		          <c:otherwise>
		            <div class="alert alert-info">No recent sales found.</div>
		          </c:otherwise>
		        </c:choose>
		      </div>
		    </div>
		  </div>
		</div>
      
      <!-- Help Section -->
      <div class="row mt-4">
        <div class="col-12">
          <div class="card help-section">
            <div class="card-header" style="background: rgba(0, 0, 0, 0.2); border-bottom: 1px solid rgba(255,255,255,0.1);">
              <h5 style="color: #00c9ff; font-weight: 700; margin: 0;">
                <i class="fa fa-question-circle mr-2"></i>Help & Support Center
              </h5>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-4 mb-4">
                  <div class="card help-card text-center">
                    <div class="card-body">
                      <div class="help-icon">
                        <i class="fa fa-book"></i>
                      </div>
                      <h5>User Guide</h5>
                      <p>Complete documentation for all system features</p>
                      <button class="btn btn-outline-primary" data-toggle="modal" data-target="#userGuideModal">
                        View Guide
                      </button>
                    </div>
                  </div>
                </div>
                
                <div class="col-md-4 mb-4">
                  <div class="card help-card text-center">
                    <div class="card-body">
                      <div class="help-icon">
                        <i class="fa fa-video"></i>
                      </div>
                      <h5>Video Tutorials</h5>
                      <p>Step-by-step video guides for common tasks</p>
                      <button class="btn btn-outline-primary" data-toggle="modal" data-target="#videoTutorialsModal">
                        Watch Videos
                      </button>
                    </div>
                  </div>
                </div>
                
                <div class="col-md-4 mb-4">
                  <div class="card help-card text-center">
                    <div class="card-body">
                      <div class="help-icon">
                        <i class="fa fa-headset"></i>
                      </div>
                      <h5>Contact Support</h5>
                      <p>Get help from our technical support team</p>
                      <button class="btn btn-outline-primary" data-toggle="modal" data-target="#contactSupportModal">
                        Contact Us
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="row mt-4">
                <div class="col-12">
                  <div class="card quick-links-card">
                    <div class="card-header">
                      <h6 style="color: #00c9ff; margin: 0;">Quick Links</h6>
                    </div>
                    <div class="card-body">
                      <div class="row">
                        <div class="col-md-3 col-6 text-center mb-3">
                          <a href="${pageContext.request.contextPath}/CategoryServlet?action=list" class="text-decoration-none">
                            <div class="quick-link-item">
                              <i class="fa fa-list-alt"></i>
                              <p>Category Management</p>
                            </div>
                          </a>
                        </div>
                        <div class="col-md-3 col-6 text-center mb-3">
                          <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="text-decoration-none">
                            <div class="quick-link-item">
                              <i class="fa fa-cube"></i>
                              <p>Product Management</p>
                            </div>
                          </a>
                        </div>
                        <div class="col-md-3 col-6 text-center mb-3">
                          <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new" class="text-decoration-none">
                            <div class="quick-link-item">
                              <i class="fa fa-cash-register"></i>
                              <p>Cashier System</p>
                            </div>
                          </a>
                        </div>
                        <div class="col-md-3 col-6 text-center mb-3">
                          <a href="${pageContext.request.contextPath}/InvoiceServlet?action=report" class="text-decoration-none">
                            <div class="quick-link-item">
                              <i class="fa fa-chart-bar"></i>
                              <p>Sales Reports</p>
                            </div>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--End Help Section-->
      
      <!--End Dashboard Content-->
      
      <!--start overlay-->
      <div class="overlay toggle-menu"></div>
      <!--end overlay-->
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
  
  <!-- Help Section Modals -->
  <!-- User Guide Modal -->
<div class="modal fade help-modal" id="userGuideModal" tabindex="-1" role="dialog" aria-labelledby="userGuideModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userGuideModalLabel"><i class="fa fa-book mr-2"></i>Complete User Guide</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="accordion" id="userGuideAccordion">
                    
                    <!-- Dashboard Overview -->
                    <div class="card">
                        <div class="card-header" id="headingOne">
                            <h6 class="mb-0">
                                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <i class="fa fa-dashboard mr-2"></i>Dashboard Overview
                                </button>
                            </h6>
                        </div>
                        <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <p>The dashboard provides a comprehensive overview of your store's performance with key metrics:</p>
                                <ul>
                                    <li><strong>Total Products:</strong> Number of products in your inventory</li>
                                    <li><strong>Low Stock Items:</strong> Products with limited stock (5 or fewer items)</li>
                                    <li><strong>Out of Stock:</strong> Products that need restocking</li>
                                    <li><strong>Total Sales:</strong> Revenue generated from all transactions</li>
                                </ul>
                                <p><strong>Recent Sales Chart:</strong> Visual representation of daily sales performance</p>
                                <p><strong>Recent Sales Table:</strong> Detailed list of recent transactions</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Category Management -->
                    <div class="card">
                        <div class="card-header" id="headingTwo">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="fa fa-list-alt mr-2"></i>Category Management
                                </button>
                            </h6>
                        </div>
                        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Adding a New Category:</h6>
                                <ol>
                                    <li>Navigate to <strong>Categories</strong> from the sidebar menu</li>
                                    <li>Click the <strong>Add New</strong> button</li>
                                    <li>Fill in the category name (required)</li>
                                    <li>Add a description (optional)</li>
                                    <li>Click <strong>Save</strong> to create the category</li>
                                </ol>
                                
                                <h6>Editing a Category:</h6>
                                <ol>
                                    <li>Go to the Categories list</li>
                                    <li>Click the <strong>Edit</strong> button (pencil icon) next to the category</li>
                                    <li>Modify the category name or description</li>
                                    <li>Click <strong>Save</strong> to update</li>
                                </ol>
                                
                                <h6>Deleting a Category:</h6>
                                <ol>
                                    <li>Go to the Categories list</li>
                                    <li>Click the <strong>Delete</strong> button (trash icon) next to the category</li>
                                    <li>Confirm the deletion when prompted</li>
                                    <li class="text-warning"><strong>Note:</strong> Categories with associated products cannot be deleted</li>
                                </ol>
                                
                                <h6>Best Practices:</h6>
                                <ul>
                                    <li>Create categories before adding products</li>
                                    <li>Use descriptive category names</li>
                                    <li>Keep categories organized for easy navigation</li>
                                    <li>Regularly review and update categories</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Product Management -->
                    <div class="card">
                        <div class="card-header" id="headingThree">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    <i class="fa fa-cube mr-2"></i>Product Management
                                </button>
                            </h6>
                        </div>
                        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Adding a New Product:</h6>
                                <ol>
                                    <li>Navigate to <strong>Products</strong> from the sidebar menu</li>
                                    <li>Click the <strong>Add New</strong> button</li>
                                    <li>Fill in the product details:
                                        <ul>
                                            <li><strong>Product Name:</strong> Required field</li>
                                            <li><strong>Category:</strong> Select from existing categories</li>
                                            <li><strong>Description:</strong> Product details and specifications</li>
                                            <li><strong>Price:</strong> Selling price in Rs.</li>
                                            <li><strong>Quantity:</strong> Initial stock quantity</li>
                                            <li><strong>Image:</strong> Upload product photo (optional)</li>
                                        </ul>
                                    </li>
                                    <li>Click <strong>Save</strong> to add the product</li>
                                </ol>
                                
                                <h6>Editing a Product:</h6>
                                <ol>
                                    <li>Go to the Products list</li>
                                    <li>Click the <strong>Edit</strong> button next to the product</li>
                                    <li>Update the product information</li>
                                    <li>Click <strong>Save</strong> to apply changes</li>
                                </ol>
                                
                                <h6>Managing Stock:</h6>
                                <ul>
                                    <li><span class="badge badge-warning">Low Stock</span> indicates products with 5 or fewer items</li>
                                    <li><span class="badge badge-danger">Out of Stock</span> indicates products with zero quantity</li>
                                    <li>Regularly update stock levels to avoid overselling</li>
                                </ul>
                                
                                <h6>Product Images:</h6>
                                <ul>
                                    <li>Supported formats: JPEG, PNG</li>
                                    <li>Maximum file size: 10MB</li>
                                    <li>Recommended dimensions: 500x500 pixels</li>
                                    <li>Images display in product lists and cashier system</li>
                                </ul>
                                
                                <h6>Low Stock View:</h6>
                                <p>Use the <strong>Low Stock</strong> button to quickly identify products that need restocking.</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Customer Management -->
                    <div class="card">
                        <div class="card-header" id="headingFour">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    <i class="fa fa-users mr-2"></i>Customer Management
                                </button>
                            </h6>
                        </div>
                        <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Adding a New Customer:</h6>
                                <ol>
                                    <li>Navigate to <strong>Accounts → Customer Management</strong></li>
                                    <li>Click the <strong>Add New</strong> button</li>
                                    <li>Fill in customer details:
                                        <ul>
                                            <li><strong>Account Number:</strong> Unique identifier for the customer</li>
                                            <li><strong>Name:</strong> Customer's full name</li>
                                            <li><strong>Email:</strong> Contact email address</li>
                                            <li><strong>Telephone:</strong> Phone number</li>
                                            <li><strong>Address:</strong> Complete mailing address</li>
                                        </ul>
                                    </li>
                                    <li>Click <strong>Save</strong> to add the customer</li>
                                </ol>
                                
                                <h6>Editing Customer Information:</h6>
                                <ol>
                                    <li>Go to the Customers list</li>
                                    <li>Click the <strong>Edit</strong> button next to the customer</li>
                                    <li>Update the customer information</li>
                                    <li>Click <strong>Save</strong> to apply changes</li>
                                </ol>
                                
                                <h6>Customer Search in Cashier:</h6>
                                <ul>
                                    <li>Customers can be searched by name or account number</li>
                                    <li>Selecting a customer pre-fills their information for sales</li>
                                    <li>Email receipts can be sent to customers after purchase</li>
                                </ul>
                                
                                <h6>Best Practices:</h6>
                                <ul>
                                    <li>Maintain accurate customer information</li>
                                    <li>Use unique account numbers for each customer</li>
                                    <li>Keep customer records updated regularly</li>
                                    <li>Use customer data for personalized service</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Staff Management -->
                    <div class="card">
                        <div class="card-header" id="headingFive">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                    <i class="fa fa-user-tie mr-2"></i>Staff Management
                                </button>
                            </h6>
                        </div>
                        <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Adding Staff Members:</h6>
                                <ol>
                                    <li>Navigate to <strong>Accounts → Staff Management</strong></li>
                                    <li>Click the <strong>Add New</strong> button</li>
                                    <li>Fill in staff details:
                                        <ul>
                                            <li><strong>Username:</strong> Login username (required)</li>
                                            <li><strong>Email:</strong> Professional email address (required)</li>
                                            <li><strong>Password:</strong> Secure password for system access</li>
                                            <li><strong>Role:</strong> Select between Admin or Cashier</li>
                                        </ul>
                                    </li>
                                    <li>Click <strong>Save</strong> to create the staff account</li>
                                </ol>
                                
                                <h6>Role Permissions:</h6>
                                <ul>
                                    <li><strong>Admin:</strong> Full access to all system features
                                        <ul>
                                            <li>Dashboard viewing</li>
                                            <li>Category management</li>
                                            <li>Product management</li>
                                            <li>Customer management</li>
                                            <li>Staff management</li>
                                            <li>Sales processing</li>
                                            <li>Report generation</li>
                                        </ul>
                                    </li>
                                    <li><strong>Cashier:</strong> Limited access for sales processing
                                        <ul>
                                            <li>Dashboard viewing (limited)</li>
                                            <li>Sales processing only</li>
                                            <li>Customer lookup</li>
                                            <li>No access to management features</li>
                                        </ul>
                                    </li>
                                </ul>
                                
                                <h6>Security Best Practices:</h6>
                                <ul>
                                    <li>Use strong, unique passwords</li>
                                    <li>Assign appropriate role permissions</li>
                                    <li>Regularly review staff access levels</li>
                                    <li>Deactivate accounts for former employees</li>
                                </ul>
                                
                                <h6>Deleting Staff Accounts:</h6>
                                <ol>
                                    <li>Go to the Staff Management list</li>
                                    <li>Click the <strong>Delete</strong> button next to the staff member</li>
                                    <li>Confirm the deletion when prompted</li>
                                    <li class="text-warning"><strong>Note:</strong> This action cannot be undone</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Cashier System -->
                    <div class="card">
                        <div class="card-header" id="headingSix">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                                    <i class="fa fa-cash-register mr-2"></i>Cashier System
                                </button>
                            </h6>
                        </div>
                        <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Processing a Sale:</h6>
                                <ol>
                                    <li>Navigate to <strong>Cashier</strong> from the sidebar menu</li>
                                    <li><strong>Step 1: Customer Selection</strong>
                                        <ul>
                                            <li>Search for existing customers by name or account number</li>
                                            <li>Select the customer from search results</li>
                                            <li>Customer information will auto-populate</li>
                                            <li>Use <strong>Clear Customer</strong> to start over</li>
                                        </ul>
                                    </li>
                                    <li><strong>Step 2: Adding Products</strong>
                                        <ul>
                                            <li>Search products by name or use category filters</li>
                                            <li>Click on products to add them to the cart</li>
                                            <li>Use quantity controls to adjust amounts</li>
                                            <li>Remove items using the trash icon</li>
                                        </ul>
                                    </li>
                                    <li><strong>Step 3: Payment Processing</strong>
                                        <ul>
                                            <li>Review the order summary with subtotal</li>
                                            <li>Enter the amount paid by customer</li>
                                            <li>System automatically calculates balance</li>
                                            <li>Click <strong>Complete Sale</strong> to finalize</li>
                                        </ul>
                                    </li>
                                    <li><strong>Step 4: Receipt Generation</strong>
                                        <ul>
                                            <li>System generates invoice automatically</li>
                                            <li>Email receipt is sent to customer if email is provided</li>
                                            <li>Use <strong>Print Receipt</strong> for physical copy</li>
                                        </ul>
                                    </li>
                                </ol>
                                
                                <h6>Cart Management:</h6>
                                <ul>
                                    <li>View all items in the cart with quantities and prices</li>
                                    <li>Adjust quantities using + and - buttons</li>
                                    <li>Remove items completely with delete button</li>
                                    <li>Cart automatically calculates totals</li>
                                </ul>
                                
                                <h6>Stock Validation:</h6>
                                <ul>
                                    <li>System prevents adding out-of-stock products</li>
                                    <li>Low stock warnings appear for limited quantities</li>
                                    <li>Real-time inventory updates during sales</li>
                                </ul>
                                
                                <h6>Keyboard Shortcuts:</h6>
                                <ul>
                                    <li><strong>Enter:</strong> Initiate search in customer or product fields</li>
                                    <li><strong>Tab:</strong> Navigate between form fields</li>
                                    <li><strong>Escape:</strong> Clear current selection</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sales Reports -->
                    <div class="card">
                        <div class="card-header" id="headingSeven">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                                    <i class="fa fa-chart-bar mr-2"></i>Sales Reports & Analytics
                                </button>
                            </h6>
                        </div>
                        <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>Generating Sales Reports:</h6>
                                <ol>
                                    <li>Navigate to <strong>Sales Report</strong> from the sidebar menu</li>
                                    <li>Select date range using the calendar pickers
                                        <ul>
                                            <li><strong>Start Date:</strong> Beginning of report period</li>
                                            <li><strong>End Date:</strong> End of report period</li>
                                        </ul>
                                    </li>
                                    <li>Click <strong>Filter</strong> to generate the report</li>
                                    <li>Use <strong>Export to Excel</strong> for data analysis</li>
                                </ol>
                                
                                <h6>Report Components:</h6>
                                <ul>
                                    <li><strong>Daily Sales Chart:</strong> Visual representation of sales trends</li>
                                    <li><strong>Sales Details Table:</strong> Comprehensive list of all transactions</li>
                                    <li><strong>Invoice Information:</strong> Invoice ID, date, customer details</li>
                                    <li><strong>Transaction Details:</strong> Items purchased and total amounts</li>
                                </ul>
                                
                                <h6>Data Analysis:</h6>
                                <ul>
                                    <li>Identify best-selling products</li>
                                    <li>Track sales trends over time</li>
                                    <li>Analyze customer purchasing patterns</li>
                                    <li>Monitor daily revenue performance</li>
                                </ul>
                                
                                <h6>Export Features:</h6>
                                <ul>
                                    <li>Export reports to Excel for further analysis</li>
                                    <li>Data includes all transaction details</li>
                                    <li>Use exported data for accounting purposes</li>
                                    <li>Create custom reports using exported data</li>
                                </ul>
                                
                                <h6>Viewing Invoice Details:</h6>
                                <ol>
                                    <li>From the sales report, click <strong>View</strong> next to any invoice</li>
                                    <li>System displays complete invoice details</li>
                                    <li>View individual items, quantities, and prices</li>
                                    <li>See customer information and payment details</li>
                                </ol>
                                
                                <h6>Reprinting Receipts:</h6>
                                <ol>
                                    <li>From the sales report, click <strong>Print</strong> next to any invoice</li>
                                    <li>System generates a printable receipt</li>
                                    <li>Receipt includes all transaction details</li>
                                    <li>Use for customer copies or record keeping</li>
                                </ol>
                                
                                <h6>Report Best Practices:</h6>
                                <ul>
                                    <li>Generate daily reports for performance tracking</li>
                                    <li>Create weekly and monthly reports for trends</li>
                                    <li>Export data regularly for backup purposes</li>
                                    <li>Use reports for inventory planning</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- System Settings -->
                    <div class="card">
                        <div class="card-header" id="headingEight">
                            <h6 class="mb-0">
                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
                                    <i class="fa fa-cog mr-2"></i>System Settings & Maintenance
                                </button>
                            </h6>
                        </div>
                        <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#userGuideAccordion">
                            <div class="card-body">
                                <h6>User Management:</h6>
                                <ul>
                                    <li>Regularly review staff accounts and permissions</li>
                                    <li>Update passwords periodically for security</li>
                                    <li>Deactivate accounts for former employees</li>
                                </ul>
                                
                                <h6>Data Backup:</h6>
                                <ul>
                                    <li>Regularly export important data</li>
                                    <li>Maintain backup copies of sales reports</li>
                                    <li>Keep customer and product data backed up</li>
                                </ul>
                                
                                <h6>System Maintenance:</h6>
                                <ul>
                                    <li>Regularly update product information</li>
                                    <li>Maintain accurate inventory levels</li>
                                    <li>Keep customer records current</li>
                                    <li>Review and purge old data as needed</li>
                                </ul>
                                
                                <h6>Security Practices:</h6>
                                <ul>
                                    <li>Use strong passwords for all accounts</li>
                                    <li>Limit admin access to authorized personnel only</li>
                                    <li>Regularly review system access logs</li>
                                    <li>Keep the system updated with latest security patches</li>
                                </ul>
                                
                                <h6>Getting Help:</h6>
                                <ul>
                                    <li>Use the <strong>Help & Support Center</strong> for assistance</li>
                                    <li>Contact support for technical issues</li>
                                    <li>Refer to video tutorials for visual guidance</li>
                                    <li>Access quick links for common tasks</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
            
        </div>
    </div>
</div>



  <!-- Video Tutorials Modal -->
  <div class="modal fade help-modal" id="videoTutorialsModal" tabindex="-1" role="dialog" aria-labelledby="videoTutorialsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="videoTutorialsModalLabel"><i class="fa fa-video mr-2"></i>Video Tutorials</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="list-group">
            <a href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Getting Started with Pahana Edu</h6>
                <small>15:23</small>
              </div>
              <p class="mb-1">Learn how to navigate the dashboard and basic features</p>
            </a>
            <a href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Inventory Management</h6>
                <small>22:45</small>
              </div>
              <p class="mb-1">How to add, edit, and manage your product inventory</p>
            </a>
            <a href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Processing Sales Transactions</h6>
                <small>18:12</small>
              </div>
              <p class="mb-1">Step-by-step guide to processing customer purchases</p>
            </a>
            <a href="#" class="list-group-item list-group-item-action">
              <div class="d-flex w-100 justify-content-between">
                <h6 class="mb-1">Generating Reports</h6>
                <small>12:34</small>
              </div>
              <p class="mb-1">How to generate and interpret sales reports</p>
            </a>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">View All Tutorials</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Contact Support Modal -->
  <div class="modal fade help-modal" id="contactSupportModal" tabindex="-1" role="dialog" aria-labelledby="contactSupportModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="contactSupportModalLabel"><i class="fa fa-headset mr-2"></i>Contact Support</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form id="supportForm">
            <div class="form-group">
              <label for="supportName" style="color: rgba(255, 255, 255, 0.9);">Your Name</label>
              <input type="text" class="form-control" id="supportName" required>
            </div>
            <div class="form-group">
              <label for="supportEmail" style="color: rgba(255, 255, 255, 0.9);">Email Address</label>
              <input type="email" class="form-control" id="supportEmail" required>
            </div>
            <div class="form-group">
              <label for="supportSubject" style="color: rgba(255, 255, 255, 0.9);">Subject</label>
              <select class="form-control" id="supportSubject" required>
                <option value="">Select a subject</option>
                <option value="technical">Technical Issue</option>
                <option value="billing">Billing Inquiry</option>
                <option value="feature">Feature Request</option>
                <option value="other">Other</option>
              </select>
            </div>
            <div class="form-group">
              <label for="supportMessage" style="color: rgba(255, 255, 255, 0.9);">Message</label>
              <textarea class="form-control" id="supportMessage" rows="4" required></textarea>
            </div>
          </form>
          <div class="mt-4 support-options">
            <h6 style="color: #00c9ff;">Other Support Options:</h6>
            <p><i class="fa fa-envelope"></i>Email: support@pahana.edu</p>
            <p><i class="fa fa-phone"></i>Phone: +94 11 234 5678</p>
            <p><i class="fa fa-clock"></i>Hours: Monday-Friday, 8:00 AM - 6:00 PM</p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" id="submitSupportRequest">Submit Request</button>
        </div>
      </div>
    </div>
  </div>
  
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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>

  <script>
  $(document).ready(function() {
      // Initialize DataTable if we have invoices
      <c:if test="${not empty recentInvoices}">
      $('#recentSalesTable').DataTable({
          "order": [[1, "desc"]],
          "language": {
              "emptyTable": "No recent sales data available"
          },
          "dom": '<"top"lf>rt<"bottom"ip><"clear">',
          "responsive": true
      });
      </c:if>
      
      // Initialize chart only if we have data
      <c:if test="${not empty recentSales}">
      // Prepare data for chart
      var salesChartData = {
          labels: [
              <c:forEach items="${recentSales}" var="entry" varStatus="loop">
                  "${entry.key}"<c:if test="${!loop.last}">,</c:if>
              </c:forEach>
          ],
          datasets: [{
              label: 'Sales Amount (Rs.)',
              data: [
                  <c:forEach items="${recentSales}" var="entry" varStatus="loop">
                      ${entry.value}<c:if test="${!loop.last}">,</c:if>
                  </c:forEach>
              ],
              backgroundColor: 'rgba(54, 162, 235, 0.6)',
              borderColor: 'rgba(54, 162, 235, 1)',
              borderWidth: 2,
              fill: true
          }]
      };
      
      // Get chart canvas
      var ctx = document.getElementById('salesChart').getContext('2d');
      
      // Destroy previous chart instance if exists
      if (window.salesChart instanceof Chart) {
          window.salesChart.destroy();
      }
      
      // Create chart with improved visibility settings
      window.salesChart = new Chart(ctx, {
          type: 'line',
          data: salesChartData,
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
      
      // Help section functionality
      $('#helpMenuLink, #topHelpBtn').click(function(e) {
          e.preventDefault();
          $('html, body').animate({
              scrollTop: $('.help-section').offset().top - 20
          }, 1000);
      });
      
      // Support form submission
      $('#submitSupportRequest').click(function() {
          const form = $('#supportForm');
          if (form[0].checkValidity()) {
              // Simulate form submission
              $('#contactSupportModal').modal('hide');
              alert('Your support request has been submitted successfully. We will contact you within 24 hours.');
              form[0].reset();
          } else {
              form[0].reportValidity();
          }
      });
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