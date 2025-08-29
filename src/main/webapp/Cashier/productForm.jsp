<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Pahana Edu - ${not empty product ? 'Edit' : 'Add'} Product</title>
  
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
  
  <style>
    .image-preview {
      max-width: 200px;
      max-height: 200px;
      display: block;
      margin-bottom: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 5px;
    }
    .image-preview-container {
      text-align: center;
      margin-bottom: 20px;
    }
    .form-group.required label:after {
      content: " *";
      color: red;
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
        <div class="col-12 col-lg-8 mx-auto">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">${not empty product ? 'Edit' : 'Add'} Product</h4>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/CashierProductServlet?action=${not empty product ? 'update' : 'insert'}" method="post" enctype="multipart/form-data" id="productForm">
                <c:if test="${not empty product}">
                  <input type="hidden" name="id" value="${product.productId}">
                </c:if>
                
                <div class="form-group required">
                  <label for="productName">Product Name</label>
                  <input type="text" class="form-control" id="productName" name="productName" 
                         value="${product.productName}" required>
                </div>
                
                <div class="form-group required">
                  <label for="categoryId">Category</label>
                  <select class="form-control" id="categoryId" name="categoryId" required>
                    <option value="">Select a category</option>
                    <c:forEach var="category" items="${categories}">
                      <option value="${category.categoryId}" ${product.categoryId == category.categoryId ? 'selected' : ''}>
                        ${category.categoryName}
                      </option>
                    </c:forEach>
                  </select>
                </div>
                
                <div class="form-group">
                  <label for="description">Description</label>
                  <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                </div>
                
                <div class="form-group required">
                  <label for="price">Price (Rs.)</label>
                  <input type="number" class="form-control" id="price" name="price" 
                         value="${product.price}" step="0.01" min="0" required>
                </div>
                
                <div class="form-group required">
                  <label for="quantity">Quantity in Stock</label>
                  <input type="number" class="form-control" id="quantity" name="quantity" 
                         value="${not empty product ? product.quantity : 0}" min="0" required>
                </div>
                
                <div class="form-group">
                  <label for="image">Product Image</label>
                  <div class="image-preview-container">
                    <c:if test="${not empty product.imageBase64}">
                      <img id="imagePreview" src="data:image/jpeg;base64,${product.imageBase64}" class="image-preview" alt="Current Product Image">
                    </c:if>
                    <c:if test="${empty product.imageBase64}">
                      <img id="imagePreview" class="image-preview" style="display: none;">
                    </c:if>
                  </div>
                  <input type="file" class="form-control-file" id="image" name="image" accept="image/*">
                  <small class="form-text text-muted">Max file size: 10MB. Accepted formats: JPEG, PNG</small>
                </div>
                
                <div class="form-group text-center">
                  <button type="submit" class="btn btn-primary mr-2">
                    <i class="fa fa-save"></i> Save
                  </button>
                  <a href="${pageContext.request.contextPath}/CashierProductServlet?action=list" class="btn btn-light">
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
// Image preview functionality
document.getElementById('image').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('imagePreview');
            preview.src = e.target.result;
            preview.style.display = 'block';
        }
        reader.readAsDataURL(file);
    }
});

// Form validation and success message
document.getElementById('productForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Basic validation
    const productName = document.getElementById('productName').value.trim();
    const categoryId = document.getElementById('categoryId').value;
    const price = parseFloat(document.getElementById('price').value);
    const quantity = parseInt(document.getElementById('quantity').value);
    
    if (!productName || !categoryId || isNaN(price) || isNaN(quantity)) {
        Swal.fire({
            icon: 'error',
            title: 'Validation Error',
            text: 'Please fill all required fields',
            timer: 3000,
            showConfirmButton: false
        });
        return;
    }
    
    if (price < 0) {
        Swal.fire({
            icon: 'error',
            title: 'Invalid Price',
            text: 'Price cannot be negative'
        });
        return;
    }
    
    if (quantity < 0) {
        Swal.fire({
            icon: 'error',
            title: 'Invalid Quantity',
            text: 'Quantity cannot be negative'
        });
        return;
    }
    
    const fileInput = document.getElementById('image');
    if (fileInput.files.length > 0) {
        const file = fileInput.files[0];
        const fileSize = file.size / 1024 / 1024; // in MB
        if (fileSize > 10) {
            Swal.fire({
                icon: 'error',
                title: 'File Too Large',
                text: 'File size exceeds 10MB limit'
            });
            return;
        }
    }
    
    // Show confirmation dialog
    Swal.fire({
        title: 'Are you sure?',
        text: '${not empty product ? "Update" : "Add"} this product?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, ${not empty product ? "update" : "add"} it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading message
            Swal.fire({
                title: 'Processing...',
                text: 'Please wait while we save your product',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading()
                }
            });
            
            // Submit the form
            this.submit();
        }
    });
});

// Check for error message from session and show SweetAlert
<c:if test="${not empty sessionScope.errorMessage}">
    Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: '${sessionScope.errorMessage}'
    });
    <c:remove var="errorMessage" scope="session"/>
</c:if>
</script>
</body>
</html>