<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Invoice</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
    <style>
        .invoice-container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .invoice-header { text-align: center; margin-bottom: 30px; }
        .invoice-table { width: 100%; margin-bottom: 30px; }
        .text-right { text-align: right; }
        .action-buttons { margin-top: 20px; }
        .error-container { max-width: 800px; margin: 50px auto; padding: 20px; text-align: center; }
        
        /* Print Styles */
        @media print {
            body * {
                visibility: hidden;
            }
            .print-section, .print-section * {
                visibility: visible;
            }
            .print-section {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }
            .action-buttons, .no-print {
                display: none !important;
            }
            .invoice-container {
                max-width: 100%;
                padding: 0;
                margin: 0;
            }
            .invoice-header {
                border-bottom: 2px solid #000;
                padding-bottom: 20px;
                margin-bottom: 20px;
            }
            .customer-details {
                margin-bottom: 20px;
                padding: 10px;
                border: 1px solid #ddd;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f8f9fa;
            }
            .text-right {
                text-align: right;
            }
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${not empty invoice and not empty items and not empty customer}">
            <div class="invoice-container print-section">
                <div class="invoice-header">
                    <h2>Pahana Edu</h2>
                    <h3>Invoice #${invoice.invoiceId}</h3>
                    <p>Date: ${invoice.invoiceDate}</p>
                </div>
                
                <div class="customer-details">
                    <h4>Customer Details</h4>
                    <p><strong>Name:</strong> ${customer.name}</p>
                    <p><strong>Account #:</strong> ${customer.accountNumber}</p>
                    <p><strong>Phone:</strong> ${customer.telephone}</p>
                    <p><strong>Email:</strong> ${customer.email}</p>
                    <p><strong>Address:</strong> ${customer.address}</p>
                </div>
                
                <table class="table invoice-table">
                    <thead class="thead-light">
                        <tr>
                            <th>Item</th>
                            <th class="text-right">Qty</th>
                            <th class="text-right">Unit Price</th>
                            <th class="text-right">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>${item.product.productName}</td>
                                <td class="text-right">${item.quantity}</td>
                                <td class="text-right">Rs. ${item.unitPrice}</td>
                                <td class="text-right">Rs. ${item.total}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Subtotal:</strong></td>
                            <td class="text-right"><strong>Rs. ${invoice.subtotal}</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Amount Paid:</strong></td>
                            <td class="text-right"><strong>Rs. ${invoice.amountPaid}</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Balance:</strong></td>
                            <td class="text-right"><strong>Rs. ${invoice.balance}</strong></td>
                        </tr>
                    </tfoot>
                </table>
                
                <div class="text-center mt-4">
                    <p>Thank you for your business!</p>
                    <p>Pahana Edu - Quality Education Materials</p>
                </div>
            </div>
            
            <div class="container action-buttons no-print">
                <div class="row justify-content-center">
                    <div class="col-md-8 text-center">
                        <button onclick="printInvoice()" class="btn btn-primary">
                            <i class="fa fa-print"></i> Print Invoice
                        </button>
                        <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new" 
                           class="btn btn-success">
                            <i class="fa fa-plus"></i> New Sale
                        </a>
                        <a href="${pageContext.request.contextPath}/InvoiceServlet?action=report" 
                           class="btn btn-secondary">
                            <i class="fa fa-list"></i> View All Sales
                        </a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="error-container">
                <div class="alert alert-danger">
                    <h4>Error Loading Invoice</h4>
                    <p>${not empty errorMessage ? errorMessage : 'Invoice details not found'}</p>
                </div>
                <a href="${pageContext.request.contextPath}/InvoiceServlet?action=list" class="btn btn-primary">
                    Back to Sales List
                </a>
            </div>
        </c:otherwise>
    </c:choose>
    
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script>
        function printInvoice() {
            window.print();
        }
        
        // Auto-print if print parameter is in URL
        if(window.location.search.includes('print=true')) {
            window.print();
        }
    </script>
</body>
</html>