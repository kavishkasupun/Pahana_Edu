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
    </style>
</head>
<body>
    <div class="invoice-container">
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
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/InvoiceServlet?action=print&id=${invoice.invoiceId}" 
               class="btn btn-primary" target="_blank">
                <i class="fa fa-print"></i> Print Invoice
            </a>
            <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new" 
               class="btn btn-success">
                <i class="fa fa-plus"></i> New Sale
            </a>
            <a href="${pageContext.request.contextPath}/InvoiceServlet?action=list" 
               class="btn btn-secondary">
                <i class="fa fa-list"></i> View All Sales
            </a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
</body>
</html>