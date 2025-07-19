<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>Forgot Password - Pahana Edu</title>
  
  <!-- loader-->
  <link href="${pageContext.request.contextPath}/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/assets/js/pace.min.js"></script>
  
  <!-- Bootstrap core CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  
  <!-- animate CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet" type="text/css"/>
  
  <!-- Icons CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet" type="text/css"/>
  
  <!-- Custom Style-->
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <style>
    .bg-theme1 {
      background: linear-gradient(45deg, #667eea, #764ba2);
    }
    .card-authentication1 {
      max-width: 450px;
    }
    .form-control:focus {
      box-shadow: 0 0 5px rgba(0, 110, 255, 0.5);
    }
  </style>
</head>

<body class="bg-theme bg-theme1">

<!-- start loader -->
<div id="pageloader-overlay" class="visible incoming">
  <div class="loader-wrapper-outer">
    <div class="loader-wrapper-inner">
      <div class="loader"></div>
    </div>
  </div>
</div>
<!-- end loader -->

<!-- Start wrapper-->
<div id="wrapper">

  <div class="loader-wrapper">
    <div class="lds-ring">
      <div></div>
      <div></div>
      <div></div>
      <div></div>
    </div>
  </div>
  
  <div class="card card-authentication1 mx-auto my-5">
    <div class="card-body">
      <div class="card-content p-2">
        <div class="text-center">
          <h1 class="tm-site-title mb-0">Pahana Edu</h1>
        </div>
        <div class="card-title text-uppercase text-center py-3">Forgot Password</div>
        
        <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
          <div class="form-group">
            <label for="email" class="sr-only">Email</label>
            <div class="position-relative has-icon-right">
              <input type="email" id="email" name="email" class="form-control input-shadow" placeholder="Enter Your Email" required>
              <div class="form-control-position">
                <i class="icon-envelope"></i>
              </div>
            </div>
          </div>
          
          <button type="submit" class="btn btn-light btn-block">Reset Password</button>
          
          <%
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            if (message != null) {
          %>
            <div class="alert alert-info mt-3"><%= message %></div>
          <% } %>
          <% if (error != null) { %>
            <div class="alert alert-danger mt-3"><%= error %></div>
          <% } %>
        </form>
      </div>
    </div>
    
    <div class="card-footer text-center py-3">
      <p class="text-warning mb-0">Remember your password? <a href="${pageContext.request.contextPath}/Auth/index.jsp">Sign In here</a></p>
    </div>
  </div>
  
  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  
  <!-- Custom scripts -->
  <script src="${pageContext.request.contextPath}/assets/js/app-script.js"></script>
</body>
</html>