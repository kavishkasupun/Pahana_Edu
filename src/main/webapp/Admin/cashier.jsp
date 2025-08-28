<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Auth/index.jsp?sessionExpired=true");
        return;
    }
%>
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
  <style>
    .product-card {
      cursor: pointer;
      transition: all 0.3s;
      height: 100%;
    }
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .customer-info {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 20px;
    }
    #cartItems {
      max-height: 400px;
      overflow-y: auto;
    }
    .product-img {
      height: 120px;
      width: auto;
      max-width: 100%;
      object-fit: contain;
      margin: 0 auto;
      display: block;
    }
    .product-image-container {
      height: 120px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 10px;
    }
    .cart-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px;
      border-bottom: 1px solid #eee;
      margin-bottom: 10px;
    }
    .cart-item-details {
      flex: 2;
      padding-right: 15px;
    }
    .cart-item-actions {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .quantity-control {
      display: flex;
      align-items: center;
      margin-right: 15px;
    }
    .quantity-control button {
      width: 30px;
      height: 30px;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
    }
    .quantity-display {
      min-width: 30px;
      text-align: center;
      margin: 0 5px;
      font-weight: bold;
    }
    .cart-item-price {
      min-width: 80px;
      text-align: right;
      font-weight: bold;
    }
    .empty-cart-message {
      padding: 20px;
      text-align: center;
      color: #6c757d;
    }
    .product-list-container {
      margin-top: 20px;
    }
    .product-card-body {
      padding: 15px;
    }
    .product-price {
      font-weight: bold;
      color: #28a745;
    }
    .product-stock {
      font-size: 0.8rem;
      color: #6c757d;
    }
    .out-of-stock {
      color: #dc3545;
      font-weight: bold;
    }
    .low-stock {
      color: #ffc107;
      font-weight: bold;
    }
    .receipt-container {
      max-width: 500px;
      margin: 0 auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }
    .receipt-header {
      text-align: center;
      margin-bottom: 20px;
    }
    .receipt-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }
    .receipt-table th, .receipt-table td {
      padding: 8px;
      border-bottom: 1px solid #ddd;
      text-align: left;
    }
    .receipt-table th {
      background-color: #f8f9fa;
    }
    .text-right {
      text-align: right;
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
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

  <div class="clearfix"></div>
  
  <div class="content-wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">Cashier System</h4>
            </div>
            <div class="card-body">
              <div class="row">
                <!-- Customer Section -->
                <div class="col-md-4">
                  <div class="card">
                    <div class="card-body">
                      <h5>Customer Information</h5>
                      <div class="form-group">
                        <label for="customerSearch">Search Customer</label>
                        <div class="input-group">
                          <input type="text" class="form-control" id="customerSearch" placeholder="Search by name or account number">
                          <div class="input-group-append">
                            <button class="btn btn-primary" type="button" id="searchCustomerBtn">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                      <div id="customerResults" class="mt-2"></div>
                      <div id="selectedCustomer" class="mt-3" style="display: none;">
                        <h6>Selected Customer</h6>
                        <div class="customer-details">
                          <p><strong>Name:</strong> <span id="customerName"></span></p>
                          <p><strong>Account No:</strong> <span id="customerAccount"></span></p>
                          <p><strong>Phone:</strong> <span id="customerPhone"></span></p>
                          <p><strong>Email:</strong> <span id="customerEmail"></span></p>
                          <p><strong>Address:</strong> <span id="customerAddress"></span></p>
                        </div>
                        <input type="hidden" id="customerId">
                        <button class="btn btn-sm btn-danger mt-2" id="clearCustomerBtn">Clear Customer</button>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Cart Section -->
                  <div class="card mt-4">
                    <div class="card-header">
                      <h5>Order Summary</h5>
                    </div>
                    <div class="card-body">
                      <div id="cartItems">
                        <div class="empty-cart-message">
                          <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                          <p>No items added</p>
                        </div>
                      </div>
                      <hr>
                      <div class="row">
                        <div class="col-6">
                          <h6>Subtotal:</h6>
                        </div>
                        <div class="col-6 text-right">
                          <h6 id="cartSubtotal">Rs. 0.00</h6>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-6">
                          <h6>Total:</h6>
                        </div>
                        <div class="col-6 text-right">
                          <h6 id="cartTotal">Rs. 0.00</h6>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Payment Section -->
                  <div class="card mt-4">
                    <div class="card-header">
                      <h5>Payment</h5>
                    </div>
                    <div class="card-body">
                      <div class="form-group">
                        <label for="amountPaid">Amount Paid</label>
                        <input type="number" class="form-control" id="amountPaid" placeholder="Enter amount paid" min="0" step="0.01">
                      </div>
                      <div class="form-group">
                        <label for="balance">Balance</label>
                        <input type="text" class="form-control" id="balance" placeholder="Balance" readonly>
                      </div>
                      <button class="btn btn-success btn-block" id="completeSaleBtn" disabled>
                        <i class="fa fa-check-circle"></i> Complete Sale
                      </button>
                      
                    </div>
                  </div>
                </div>
                
                <!-- Product Section -->
                <div class="col-md-8">
                  <div class="card">
                    <div class="card-body">
                      <div class="search-box">
                        <div class="input-group">
                          <input type="text" class="form-control" id="productSearch" placeholder="Search products...">
                          <div class="input-group-append">
                            <button class="btn btn-primary" type="button" id="searchProductBtn">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                      
                      <div class="category-filter mt-3">
                        <label>Filter by Category:</label>
                        <select class="form-control" id="categoryFilter">
                          <option value="">All Categories</option>
                          <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                          </c:forEach>
                        </select>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Products will be loaded here via AJAX -->
                  <div class="product-list-container">
                    <div class="row mt-3" id="productList">
                      <div class="col-12 text-center py-5">
                        <div class="spinner-border text-primary" role="status">
                          <span class="sr-only">Loading products...</span>
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
    </div>
  </div>

  <footer class="footer">
    <div class="container">
      <div class="text-center">
        Copyright &copy; <b><%= java.time.Year.now().getValue() %></b> Pahana Edu Management System
      </div>
    </div>
  </footer>
</div>

<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/simplebar/js/simplebar.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar-menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app-script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
$(document).ready(function() {
    let cart = [];
    let selectedCustomer = null;
    
    // Load products on page load
    loadProducts();
    
    // Search customer
    $('#searchCustomerBtn').click(function() {
        searchCustomers();
    });
    
    $('#customerSearch').keypress(function(e) {
        if (e.which === 13) {
            searchCustomers();
        }
    });
    
    // Search products
    $('#searchProductBtn').click(function() {
        loadProducts();
    });
    
    $('#productSearch').keypress(function(e) {
        if (e.which === 13) {
            loadProducts();
        }
    });
    
    // Category filter change
    $('#categoryFilter').change(function() {
        loadProducts();
    });
    
    // Clear customer button
    $('#clearCustomerBtn').click(function() {
        selectedCustomer = null;
        $('#selectedCustomer').hide();
        $('#customerSearch').val('');
        checkCompleteSaleButton();
    });
    
    // Amount paid calculation
    $('#amountPaid').on('input', function() {
        calculateBalance();
    });
    
    // Complete sale button
    $('#completeSaleBtn').click(function() {
        completeSale();
    });
    
    // Print receipt button
    $('#printReceiptBtn').click(function() {
        printReceipt();
    });
    
    function searchCustomers() {
        const keyword = $('#customerSearch').val().trim();
        if (keyword === '') return;
        
        $.ajax({
            url: '${pageContext.request.contextPath}/InvoiceServlet',
            type: 'POST',
            data: {
                action: 'searchCustomer',
                keyword: keyword
            },
            success: function(response) {
                let html = '<div class="list-group">';
                if (response.length > 0) {
                    response.forEach(function(customer) {
                        html += `<a href="#" class="list-group-item list-group-item-action select-customer" 
                                  data-id="\${customer.id}" 
                                  data-name="\${customer.name}" 
                                  data-account="\${customer.accountNumber}"
                                  data-phone="\${customer.telephone}"
                                  data-email="\${customer.email}"
                                  data-address="\${customer.address}">
                                <strong>\${customer.name}</strong> - \${customer.accountNumber}
                                </a>`;
                    });
                } else {
                    html += '<div class="list-group-item">No customers found</div>';
                }
                html += '</div>';
                
                $('#customerResults').html(html);
                
                $('.select-customer').click(function(e) {
                    e.preventDefault();
                    selectedCustomer = {
                        id: $(this).data('id'),
                        name: $(this).data('name'),
                        account: $(this).data('account'),
                        phone: $(this).data('phone'),
                        email: $(this).data('email'),
                        address: $(this).data('address')
                    };
                    
                    $('#customerName').text(selectedCustomer.name);
                    $('#customerAccount').text(selectedCustomer.account);
                    $('#customerPhone').text(selectedCustomer.phone);
                    $('#customerEmail').text(selectedCustomer.email);
                    $('#customerAddress').text(selectedCustomer.address);
                    $('#customerId').val(selectedCustomer.id);
                    
                    $('#selectedCustomer').show();
                    $('#customerResults').empty();
                    $('#customerSearch').val('');
                    
                    checkCompleteSaleButton();
                });
            },
            error: function(xhr, status, error) {
                console.error(error);
                Swal.fire('Error', 'Failed to search customers', 'error');
            }
        });
    }
    
    function loadProducts() {
        const keyword = $('#productSearch').val().trim();
        const categoryId = $('#categoryFilter').val();
        
        $.ajax({
            url: '${pageContext.request.contextPath}/InvoiceServlet',
            type: 'POST',
            data: {
                action: 'searchProduct',
                keyword: keyword,
                categoryId: categoryId
            },
            beforeSend: function() {
                $('#productList').html('<div class="col-12 text-center py-5"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading products...</span></div></div>');
            },
            success: function(response) {
                let html = '';
                if (response.length > 0) {
                    response.forEach(function(product) {
                        const stockStatus = product.quantity <= 0 ? 
                            '<span class="out-of-stock">Out of Stock</span>' : 
                            (product.quantity <= 5 ? 
                                `<span class="low-stock">Low Stock (\${product.quantity})</span>` : 
                                `<span class="text-success">In Stock (\${product.quantity})</span>`);
                        
                        html += `
                        <div class="col-md-4 mb-4">
                            <div class="card product-card" data-id="\${product.productId}" data-name="\${product.productName}" data-price="\${product.price}" data-stock="\${product.quantity}">
                                <div class="product-image-container">
                                    <img src="data:image/jpeg;base64,\${product.imageBase64 || ''}" class="product-img" alt="\${product.productName}">
                                </div>
                                <div class="product-card-body">
                                    <h6>\${product.productName}</h6>
                                    <p class="product-price">Rs. \${product.price.toFixed(2)}</p>
                                    <p class="product-stock">\${stockStatus}</p>
                                    <p class="text-muted small">\${product.categoryName}</p>
                                </div>
                            </div>
                        </div>`;
                    });
                } else {
                    html = '<div class="col-12 text-center py-5"><p>No products found</p></div>';
                }
                
                $('#productList').html(html);
                
                // Add product to cart on click
                $('.product-card').click(function() {
                    const productId = $(this).data('id');
                    const productName = $(this).data('name');
                    const price = $(this).data('price');
                    const stock = $(this).data('stock');
                    
                    if (stock <= 0) {
                        Swal.fire('Out of Stock', 'This product is currently out of stock', 'warning');
                        return;
                    }
                    
                    // Check if product already in cart
                    const existingItem = cart.find(item => item.productId === productId);
                    if (existingItem) {
                        if (existingItem.quantity >= stock) {
                            Swal.fire('Stock Limit', 'Cannot add more than available stock', 'warning');
                            return;
                        }
                        existingItem.quantity++;
                    } else {
                        cart.push({
                            productId: productId,
                            productName: productName,
                            price: price,
                            quantity: 1
                        });
                    }
                    
                    updateCart();
                });
            },
            error: function(xhr, status, error) {
                console.error(error);
                $('#productList').html('<div class="col-12 text-center py-5"><p>Error loading products</p></div>');
            }
        });
    }
    
    function updateCart() {
        if (cart.length === 0) {
            $('#cartItems').html('<div class="empty-cart-message"><i class="fas fa-shopping-cart fa-2x mb-2"></i><p>No items added</p></div>');
            $('#cartSubtotal').text('Rs. 0.00');
            $('#cartTotal').text('Rs. 0.00');
            $('#amountPaid').val('');
            $('#balance').val('');
            checkCompleteSaleButton();
            return;
        }
        
        let html = '';
        let subtotal = 0;
        
        cart.forEach((item, index) => {
            const itemTotal = item.price * item.quantity;
            subtotal += itemTotal;
            
            html += `
            <div class="cart-item">
                <div class="cart-item-details">
                    <h6>\${item.productName}</h6>
                    <p class="text-muted small">Rs. \${item.price.toFixed(2)} each</p>
                </div>
                <div class="cart-item-actions">
                    <div class="quantity-control">
                        <button class="btn btn-sm btn-outline-secondary decrease-quantity" data-index="\${index}">-</button>
                        <span class="quantity-display">\${item.quantity}</span>
                        <button class="btn btn-sm btn-outline-secondary increase-quantity" data-index="\${index}">+</button>
                    </div>
                    <div class="cart-item-price">
                        Rs. \${itemTotal.toFixed(2)}
                    </div>
                    <button class="btn btn-sm btn-outline-danger remove-item" data-index="\${index}">
                        <i class="fa fa-trash"></i>
                    </button>
                </div>
            </div>`;
        });
        
        $('#cartItems').html(html);
        $('#cartSubtotal').text('Rs. ' + subtotal.toFixed(2));
        $('#cartTotal').text('Rs. ' + subtotal.toFixed(2));
        
        // Recalculate balance if amount paid exists
        if ($('#amountPaid').val()) {
            calculateBalance();
        }
        
        // Add event listeners for quantity controls
        $('.decrease-quantity').click(function() {
            const index = $(this).data('index');
            if (cart[index].quantity > 1) {
                cart[index].quantity--;
                updateCart();
            }
        });
        
        $('.increase-quantity').click(function() {
            const index = $(this).data('index');
            // Check stock limit (we'd need to have stock info in cart items)
            cart[index].quantity++;
            updateCart();
        });
        
        $('.remove-item').click(function() {
            const index = $(this).data('index');
            cart.splice(index, 1);
            updateCart();
        });
        
        checkCompleteSaleButton();
    }
    
    function calculateBalance() {
        const subtotalText = $('#cartTotal').text().replace('Rs. ', '');
        const subtotal = parseFloat(subtotalText) || 0;
        const amountPaid = parseFloat($('#amountPaid').val()) || 0;
        
        const balance = amountPaid - subtotal;
        $('#balance').val('Rs. ' + balance.toFixed(2));
        
        checkCompleteSaleButton();
    }
    
    function checkCompleteSaleButton() {
        const subtotalText = $('#cartTotal').text().replace('Rs. ', '');
        const subtotal = parseFloat(subtotalText) || 0;
        const amountPaid = parseFloat($('#amountPaid').val()) || 0;
        
        const canComplete = cart.length > 0 && selectedCustomer !== null && amountPaid >= subtotal;
        $('#completeSaleBtn').prop('disabled', !canComplete);
        $('#printReceiptBtn').prop('disabled', !canComplete);
    }
    
    function checkSession() {
        $.ajax({
            url: '${pageContext.request.contextPath}/CheckSessionServlet',
            type: 'GET',
            success: function(response) {
                if (response === 'expired') {
                    $('#sessionExpiredModal').modal('show');
                }
            },
            error: function() {
                console.log('Error checking session');
            }
        });
    }

    function redirectToLogin() {
        window.location.href = '${pageContext.request.contextPath}/Auth/index.jsp?sessionExpired=true';
    }

    // Check session every 5 minutes (300000 ms)
    setInterval(checkSession, 300000);

    // Check session before completing sale
    function completeSale() {
    // First check session
    $.ajax({
        url: '${pageContext.request.contextPath}/CheckSessionServlet',
        type: 'GET',
        success: function(response) {
            if (response === 'expired') {
                $('#sessionExpiredModal').modal('show');
            } else {
                // Original complete sale code
                Swal.fire({
                    title: 'Confirm Sale',
                    text: 'Are you sure you want to complete this sale?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, complete sale'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/InvoiceServlet',
                            type: 'POST',
                            data: {
                                action: 'create',
                                customerId: selectedCustomer.id,
                                amountPaid: $('#amountPaid').val(),
                                items: JSON.stringify(cart)
                            },
                            success: function(response) {
                                if (response.success) {
                                    const invoiceId = response.invoiceId;
                                    const emailSent = response.emailSent;
                                    
                                    let successMessage = 'Invoice #' + invoiceId + ' has been created successfully.';
                                    if (emailSent) {
                                        successMessage += "<br>Email receipt has been sent to the customer.";
                                    } else {
                                        successMessage += "<br>Failed to send email receipt.";
                                    }
                                    
                                    Swal.fire({
                                        title: 'Sale Completed!',
                                        html: successMessage,
                                        icon: 'success',
                                        showCancelButton: true,
                                        confirmButtonText: 'View Invoice',
                                        cancelButtonText: 'New Sale',
                                        allowOutsideClick: false
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            // Fixed URL construction
                                            window.location.href = '${pageContext.request.contextPath}/InvoiceServlet?action=view&id=' + invoiceId;
                                        } else {
                                            resetSaleForm();
                                        }
                                    });
                                    
                                    printReceipt(invoiceId);
                                } else {
                                    Swal.fire('Error', response.message || 'Failed to complete sale', 'error');
                                }
                            },
                            error: function(xhr, status, error) {
                                if (xhr.status === 401) {
                                    $('#sessionExpiredModal').modal('show');
                                } else {
                                    console.error(error);
                                    Swal.fire('Error', 'Failed to complete sale: ' + error, 'error');
                                }
                            }
                        });
                    }
                });
            }
        },
        error: function() {
            console.log('Error checking session');
        }
    });
}
    
    function resetSaleForm() {
        cart = [];
        selectedCustomer = null;
        updateCart();
        $('#selectedCustomer').hide();
        $('#customerSearch').val('');
        $('#amountPaid').val('');
        $('#balance').val('');
        loadProducts();
    }
    
    function printReceipt(invoiceId) {
        if (!invoiceId) {
            // For manual print button click
            const subtotalText = $('#cartTotal').text().replace('Rs. ', '');
            const subtotal = parseFloat(subtotalText) || 0;
            const amountPaid = parseFloat($('#amountPaid').val()) || 0;
            const balance = amountPaid - subtotal;
            
            let receiptHtml = generateReceiptHtml(
                selectedCustomer,
                cart,
                subtotal,
                amountPaid,
                balance
            );
            
            openPrintWindow(receiptHtml);
        } else {
            // For completed sale print
            window.open(`${pageContext.request.contextPath}/InvoiceServlet?action=print&id=\${invoiceId}`, '_blank');
        }
    }
    
    function generateReceiptHtml(customer, items, subtotal, amountPaid, balance) {
        let html = `
            <div class="receipt-container">
                <div class="receipt-header">
                    <h3>Pahana Edu</h3>
                    <p>Invoice</p>
                </div>
                <div class="customer-details">
                    <p><strong>Customer:</strong> \${customer.name}</p>
                    <p><strong>Account #:</strong> \${customer.account}</p>
                    <p><strong>Date:</strong> \${new Date().toLocaleString()}</p>
                </div>
                <table class="receipt-table">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th class="text-right">Qty</th>
                            <th class="text-right">Price</th>
                            <th class="text-right">Total</th>
                        </tr>
                    </thead>
                    <tbody>`;
        
        items.forEach(item => {
            const itemTotal = item.price * item.quantity;
            html += `
                <tr>
                    <td>\${item.productName}</td>
                    <td class="text-right">\${item.quantity}</td>
                    <td class="text-right">Rs. \${item.price.toFixed(2)}</td>
                    <td class="text-right">Rs. \${itemTotal.toFixed(2)}</td>
                </tr>`;
        });
        
        html += `
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Subtotal:</strong></td>
                            <td class="text-right">Rs. \${subtotal.toFixed(2)}</td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Amount Paid:</strong></td>
                            <td class="text-right">Rs. \${amountPaid.toFixed(2)}</td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Balance:</strong></td>
                            <td class="text-right">Rs. \${balance.toFixed(2)}</td>
                        </tr>
                    </tfoot>
                </table>
                <div class="receipt-footer" style="text-align: center; margin-top: 20px;">
                    <p>Thank you for your purchase!</p>
                </div>
            </div>`;
        
        return html;
    }
    
    function openPrintWindow(content) {
        const printWindow = window.open('', '_blank');
        printWindow.document.write(`
            <html>
                <head>
                    <title>Receipt</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
                        .receipt-container { max-width: 500px; margin: 0 auto; }
                        .receipt-header { text-align: center; margin-bottom: 20px; }
                        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
                        th, td { padding: 8px; border-bottom: 1px solid #ddd; }
                        th { background-color: #f8f9fa; text-align: left; }
                        .text-right { text-align: right; }
                        @media print {
                            body { margin: 0; padding: 0; }
                            .no-print { display: none !important; }
                        }
                    </style>
                </head>
                <body onload="window.print();">
                    \${content}
                    <div class="no-print" style="text-align: center; margin-top: 20px;">
                        <button onclick="window.print()" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">Print</button>
                        <button onclick="window.close()" style="padding: 10px 20px; background: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer; margin-left: 10px;">Close</button>
                    </div>
                </body>
            </html>`);
        printWindow.document.close();
    }
});
</script>

<div class="modal fade" id="sessionExpiredModal" tabindex="-1" role="dialog" aria-labelledby="sessionExpiredModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="sessionExpiredModalLabel">Session Expired</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Your session has expired. Please log in again to continue.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="redirectToLogin()">OK</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>