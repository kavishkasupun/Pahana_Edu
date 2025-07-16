<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:if test="${category != null}">Edit Category</c:if>
        <c:if test="${category == null}">Add New Category</c:if>
    </title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body id="reportsPage">
    <div class="" id="home">
        <nav class="navbar navbar-expand-xl">
            <div class="container h-100">
                <a class="navbar-brand" href="index.jsp">
                    <h1 class="tm-site-title mb-0">Product Admin</h1>
                </a>
                <button class="navbar-toggler ml-auto mr-0" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fas fa-bars tm-nav-icon"></i>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto h-100">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">
                                <i class="fas fa-tachometer-alt"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="CategoryServlet?action=list">
                                <i class="fas fa-list-alt"></i>
                                Categories
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="products.jsp">
                                <i class="fas fa-shopping-cart"></i>
                                Products
                            </a>
                        </li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link d-block" href="${pageContext.request.contextPath}/Auth/index.jsp">
                                Admin, <b>Logout</b>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col">
                    <p class="text-white mt-5 mb-5">Welcome back, <b>Admin</b></p>
                </div>
            </div>
            
            <div class="row tm-content-row">
                <div class="col-12">
                    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
                        <div class="row">
                            <div class="col-12">
                                <h2 class="tm-block-title">
                                    <c:if test="${category != null}">Edit Category</c:if>
                                    <c:if test="${category == null}">Add New Category</c:if>
                                </h2>
                            </div>
                        </div>
                        
                        <div class="row tm-edit-product-row">
                            <div class="col-xl-6 col-lg-6 col-md-12">
                                <form action="CategoryServlet" method="post" class="tm-edit-product-form">
                                    <c:if test="${category != null}">
                                        <input type="hidden" name="id" value="${category.categoryId}" />
                                    </c:if>
                                    
                                    <input type="hidden" name="action" 
                                           value="${category == null ? 'insert' : 'update'}" />
                                    
                                    <div class="form-group mb-3">
                                        <label for="name">Category Name</label>
                                        <input id="name" name="name" type="text" class="form-control validate" 
                                               value="${category.categoryName}" required />
                                    </div>
                                    
                                    <div class="form-group mb-3">
                                        <label for="description">Description</label>
                                        <textarea id="description" name="description" class="form-control validate" 
                                                  rows="3">${category.description}</textarea>
                                    </div>
                                    
                                    <div class="form-group mt-4">
                                        <button type="submit" class="btn btn-primary btn-block">
                                            <c:if test="${category != null}">Update</c:if>
                                            <c:if test="${category == null}">Add</c:if>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/CategoryServlet?action=list" class="btn btn-danger btn-block">
                                            Cancel
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="tm-footer row tm-mt-small">
            <div class="col-12 font-weight-light">
                <p class="text-center text-white mb-0 px-4 small">
                    Copyright &copy; <b>2023</b> All rights reserved. 
                    Design: <a rel="nofollow noopener" href="https://templatemo.com" class="tm-footer-link">Template Mo</a>
                </p>
            </div>
        </footer>
    </div>

    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>