<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>Login - Pahana Edu</title>
  
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
        <div class="card-title text-uppercase text-center py-3">Sign In</div>
        
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
          <div class="form-group">
            <label for="username" class="sr-only">Username or Email</label>
            <div class="position-relative has-icon-right">
              <input type="text" id="username" name="username" class="form-control input-shadow" placeholder="Enter Username or Email" required>
              <div class="form-control-position">
                <i class="icon-user"></i>
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="password" class="sr-only">Password</label>
            <div class="position-relative has-icon-right">
              <input type="password" id="password" name="password" class="form-control input-shadow" placeholder="Enter Password" required>
              <div class="form-control-position">
                <i class="icon-lock"></i>
              </div>
            </div>
          </div>
          
          <div class="form-row">
            <div class="form-group col-6">
              <div class="icheck-material-white">
                <input type="checkbox" id="user-checkbox"/>
                <label for="user-checkbox">Remember me</label>
              </div>
            </div>
            <div class="form-group col-6 text-right">
              <a href="${pageContext.request.contextPath}/Auth/forgot_password.jsp">Reset Password</a>
            </div>
          </div>
          
          <button type="submit" class="btn btn-light btn-block">Sign In</button>
          
          <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
          %>
            <div class="alert alert-danger mt-3"><%= error %></div>
          <% } %>
        </form>
      </div>
    </div>
    
    <div class="card-footer text-center py-3">
      <p class="text-warning mb-0">If you already have an account, please log in. Otherwise, contact Administrator Support. </p>
    </div>
  </div>
  
  <!--Start Back To Top Button-->
  <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
  <!--End Back To Top Button-->
  
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
  
  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
  
  <!-- Custom scripts -->
  <script src="${pageContext.request.contextPath}/assets/js/app-script.js"></script>
</body>
</html>