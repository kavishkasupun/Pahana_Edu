<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
    <style>
        .action-btns a {
            margin-right: 5px;
        }
        .search-box {
            margin-bottom: 20px;
        }
        /* Responsive table styles */
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        /* Mobile view styles */
        @media (max-width: 768px) {
            .tm-product-table-container {
                padding: 0;
            }
            .table thead {
                display: none;
            }
            .table tr {
                display: block;
                margin-bottom: 1rem;
                border: 1px solid #dee2e6;
                border-radius: 0.25rem;
                background-color: #2c3e50;
            }
            .table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem;
                text-align: right;
                border-bottom: 1px solid #3a4b5c;
            }
            .table td:before {
                content: attr(data-label);
                font-weight: bold;
                margin-right: 1rem;
                text-align: left;
                color: #f8f9fa;
            }
            .action-btns {
                display: flex;
                justify-content: flex-end;
            }
            .dataTables_length, .dataTables_filter {
                margin-bottom: 15px;
            }
        }
        /* Filter controls */
        .filter-controls {
            margin-bottom: 15px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        .filter-controls .form-control, .filter-controls .form-select {
            min-width: 150px;
            background-color: #3a4b5c;
            color: #fff;
            border: 1px solid #4e5d6c;
        }
        .filter-controls .form-control:focus, .filter-controls .form-select:focus {
            background-color: #3a4b5c;
            color: #fff;
            border-color: #5cb3fd;
            box-shadow: 0 0 0 0.2rem rgba(23, 162, 255, 0.25);
        }
        .filter-controls label {
            color: #fff;
            margin-right: 10px;
        }
        .btn-group-vertical {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .dt-buttons {
            margin-bottom: 15px;
        }
        /* DataTables custom styles */
        .dataTables_wrapper .dataTables_length select {
            background-color: #3a4b5c;
            color: #fff;
            border: 1px solid #4e5d6c;
        }
        .dataTables_wrapper .dataTables_filter input {
            background-color: #3a4b5c;
            color: #fff;
            border: 1px solid #4e5d6c;
        }
        .dataTables_wrapper .dataTables_info {
            color: #fff;
        }
        .dataTables_wrapper .paginate_button {
            color: #fff !important;
        }
        .dataTables_wrapper .paginate_button.current {
            background: #17a2b8 !important;
            border-color: #17a2b8 !important;
        }
        .dataTables_wrapper .paginate_button:hover {
            background: #3a4b5c !important;
            border-color: #4e5d6c !important;
        }
    </style>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/Admin/adminDashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/CategoryServlet?action=list">
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
                    <div class="tm-bg-primary-dark tm-block tm-block-products">
                        <div class="tm-product-table-container">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="tm-block-title">Categories</h2>
                                <a href="${pageContext.request.contextPath}/CategoryServlet?action=new" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Add New Category
                                </a>
                            </div>
                            
                            <!-- Search and Filter Box -->
                            <div class="filter-controls">
                                <!-- Search Box -->
                                <form action="${pageContext.request.contextPath}/CategoryServlet" method="get" class="search-box">
                                    <input type="hidden" name="action" value="search">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="keyword" placeholder="Search categories..." 
                                               value="${param.keyword}">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="submit">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                
                                <!-- Reset Filters Button -->
                                <button class="btn btn-secondary btn-sm reset-filters">
                                    <i class="fas fa-sync-alt"></i> Reset
                                </button>
                            </div>
                            
                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            
                            <div class="table-responsive">
                                <table id="categoryTable" class="table table-hover tm-table-small tm-product-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>CATEGORY NAME</th>
                                            <th>DESCRIPTION</th>
                                            <th>CREATED AT</th>
                                            <th>UPDATED AT</th>
                                            <th>ACTIONS</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty categories}">
                                                <tr>
                                                    <td colspan="6" class="text-center">No categories found</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="category" items="${categories}">
                                                    <tr>
                                                        <td data-label="ID">${category.categoryId}</td>
                                                        <td data-label="Name">${category.categoryName}</td>
                                                        <td data-label="Description">${category.description}</td>
                                                        <td data-label="Created"><fmt:formatDate value="${category.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                        <td data-label="Updated"><fmt:formatDate value="${category.updatedAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                        <td data-label="Actions" class="action-btns">
                                                            <a href="${pageContext.request.contextPath}/CategoryServlet?action=edit&id=${category.categoryId}" 
                                                               class="btn btn-info btn-sm">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/CategoryServlet?action=delete&id=${category.categoryId}" 
                                                               class="btn btn-danger btn-sm"
                                                               onclick="return confirm('Are you sure you want to delete this category?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
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

    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable with responsive and filtering features
            var table = $('#categoryTable').DataTable({
                responsive: {
                    details: {
                        type: 'column',
                        target: 'tr',
                        display: $.fn.dataTable.Responsive.display.modal({
                            header: function(row) {
                                var data = row.data();
                                return 'Details for ' + data[1]; // Category Name
                            }
                        }),
                        renderer: $.fn.dataTable.Responsive.renderer.tableAll({
                            tableClass: 'table'
                        })
                    }
                },
                dom: '<"top"<"row"<"col-md-6"B><"col-md-6"f>>>rt<"bottom"<"row"<"col-md-6"l><"col-md-6"p>>><"clear">',
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn btn-secondary',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'csv',
                        className: 'btn btn-secondary',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'print',
                        className: 'btn btn-secondary',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        className: 'btn btn-secondary',
                        text: 'Columns'
                    }
                ],
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search categories...",
                    lengthMenu: "Show _MENU_ categories per page",
                    info: "Showing _START_ to _END_ of _TOTAL_ categories",
                    infoEmpty: "No categories available",
                    infoFiltered: "(filtered from _MAX_ total categories)",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous"
                    }
                },
                columnDefs: [
                    { responsivePriority: 1, targets: 0 }, // ID
                    { responsivePriority: 2, targets: 1 }, // Name
                    { responsivePriority: 3, targets: -1 }, // Actions
                    { orderable: false, targets: -1 } // Disable sorting for Actions column
                ],
                initComplete: function() {
                    // Add individual column filters
                    this.api().columns().every(function() {
                        var column = this;
                        if (column.index() === 1) { // Only for Category Name column
                            var select = $('<select class="form-select"><option value="">All Categories</option></select>')
                                .appendTo($('.filter-controls'))
                                .on('change', function() {
                                    var val = $.fn.dataTable.util.escapeRegex($(this).val());
                                    column.search(val ? '^' + val + '$' : '', true, false).draw();
                                });
                            
                            column.data().unique().sort().each(function(d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>');
                            });
                        }
                    });
                }
            });
            
            // Reset filters
            $('.reset-filters').on('click', function() {
                table.search('').columns().search('').draw();
                $('.form-select').val('');
            });
            
            // Adjust layout on window resize
            $(window).on('resize', function() {
                table.responsive.recalc();
            });
        });
    </script>
</body>
</html>