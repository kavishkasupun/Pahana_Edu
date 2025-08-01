<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>

   <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - Cashier</title>
  
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
        <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new">
          <i class="zmdi zmdi-shopping-cart"></i> <span>Cashier</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/CustomerServlet?action=list">
          <i class="zmdi zmdi-face"></i> <span>Customers</span>
        </a>
      </li>
      <li class="sidebar-header">REPORTS</li>
      <li>
        <a href="${pageContext.request.contextPath}/InvoiceServlet?action=list">
          <i class="zmdi zmdi-receipt"></i> <span>Sales</span>
        </a>
      </li>
    </ul>
  </div>

  <header class="topbar-nav">
    <nav class="navbar navbar-expand fixed-top">
      <ul class="navbar-nav mr-auto align-items-center">
        <li class="nav-item">
          <a class="nav-link toggle-menu" href="javascript:void();">
            <i class="icon-menu menu-icon"></i>
          </a>
        </li>
      </ul>
      <ul class="navbar-nav align-items-center right-nav-link">
        <li class="nav-item dropdown-lg">
          <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
            <i class="fa fa-user-circle-o"></i>
          </a>
        </li>
      </ul>
    </nav>
  </header>
  
  <div class="content-wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">Sales Report</h4>
              <div class="card-action">
                <div class="input-group">
                  <input type="date" class="form-control" id="startDate">
                  <input type="date" class="form-control" id="endDate">
                  <div class="input-group-append">
                    <button class="btn btn-primary" type="button" id="filterBtn">
                      <i class="fa fa-filter"></i> Filter
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table id="salesTable" class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>Invoice #</th>
                      <th>Date</th>
                      <th>Customer</th>
                      <th>Total</th>
                      <th>Paid</th>
                      <th>Balance</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="invoice" items="${invoices}">
                      <tr>
                        <td>${invoice.invoiceNumber}</td>
                        <td>${invoice.invoiceDate}</td>
                        <td>${invoice.customerName}</td>
                        <td>Rs. ${invoice.totalAmount}</td>
                        <td>Rs. ${invoice.amountPaid}</td>
                        <td>Rs. ${invoice.balance}</td>
                        <td>
                          <a href="${pageContext.request.contextPath}/InvoiceServlet?action=view&id=${invoice.invoiceId}" 
                             class="btn btn-sm btn-info">
                            <i class="fa fa-eye"></i> View
                          </a>
                          <a href="${pageContext.request.contextPath}/InvoiceServlet?action=print&id=${invoice.invoiceId}" 
                             class="btn btn-sm btn-primary" target="_blank">
                            <i class="fa fa-print"></i> Print
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
  
  <!-- Same footer as cashier.jsp -->
</div>

<!-- Same scripts as cashier.jsp -->
<script>
$(document).ready(function() {
    // Set default dates (today)
    const today = new Date().toISOString().split('T')[0];
    $('#startDate').val(today);
    $('#endDate').val(today);
    
    // Initialize DataTable
    $('#salesTable').DataTable({
        responsive: true,
        order: [[1, 'desc']]
    });
    
    // Filter button
    $('#filterBtn').click(function() {
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        
        if (startDate && endDate) {
            window.location.href = '${pageContext.request.contextPath}/InvoiceServlet?action=list&startDate=' + startDate + '&endDate=' + endDate;
        }
    });
});
</script>
</body>
</html>