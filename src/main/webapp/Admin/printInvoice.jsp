<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Invoice - Pahana Edu</title>
  
  <!-- Bootstrap core CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
  
  <!-- Icons CSS-->
  <link href="${pageContext.request.contextPath}/assets/css/icons.css" rel="stylesheet" type="text/css"/>
  
  <!-- Custom Style-->
  <link href="${pageContext.request.contextPath}/assets/css/app-style.css" rel="stylesheet"/>
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <style>
    body { 
      font-family: Arial, sans-serif; 
      margin: 0; 
      padding: 20px; 
      color: #333; 
      background-color: white !important;
    }
    .invoice-box { 
      max-width: 800px; 
      margin: auto; 
      padding: 30px; 
      border: 1px solid #eee; 
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.15); 
      background-color: white;
    }
    .header { 
      display: flex; 
      justify-content: space-between; 
      margin-bottom: 20px; 
    }
    .logo { 
      text-align: center; 
    }
    .logo img { 
      max-width: 150px; 
    }
    .invoice-title { 
      text-align: center; 
      margin: 20px 0; 
    }
    .customer-info { 
      margin-bottom: 30px; 
    }
    table { 
      width: 100%; 
      line-height: inherit; 
      text-align: left; 
      border-collapse: collapse; 
    }
    table td, table th { 
      padding: 12px; 
      border-bottom: 1px solid #eee; 
    }
    table th { 
      background: #f5f5f5; 
    }
    .text-right { 
      text-align: right; 
    }
    .text-center { 
      text-align: center; 
    }
    .totals { 
      margin-top: 30px; 
    }
    .footer { 
      margin-top: 50px; 
      text-align: center; 
      font-size: 0.9em; 
      color: #777; 
    }
    .no-print { 
      margin-top: 20px;
      text-align: center;
    }
    .btn {
      padding: 8px 20px;
      border-radius: 4px;
      font-weight: 500;
      text-decoration: none;
      margin: 0 5px;
    }
    .btn-primary {
      background-color: #4680ff;
      color: white;
      border: 1px solid #4680ff;
    }
    .btn-primary:hover {
      background-color: #3a6fd3;
      border-color: #3a6fd3;
    }
    .btn-secondary {
      background-color: #6c757d;
      color: white;
      border: 1px solid #6c757d;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #545b62;
    }
    .btn-info {
      background-color: #17a2b8;
      color: white;
      border: 1px solid #17a2b8;
    }
    .btn-info:hover {
      background-color: #138496;
      border-color: #117a8b;
    }
    @media print {
      body { 
        padding: 0; 
        background-color: white !important;
      }
      .no-print { 
        display: none; 
      }
      .invoice-box { 
        box-shadow: none; 
        border: none; 
      }
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <div class="invoice-box">
    <div class="header">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" alt="Logo">
        <h2>Pahana Edu</h2>
      </div>
      <div>
        <h3>INVOICE</h3>
        <p>#${invoice.invoiceId}</p>
        <p>Date: ${invoice.invoiceDate}</p>
      </div>
    </div>
    
    <div class="customer-info">
      <h4>Customer Details</h4>
      <p><strong>Name:</strong> ${customer.name}</p>
      <p><strong>Account No:</strong> ${customer.accountNumber}</p>
      <p><strong>Email:</strong> ${customer.email}</p>
      <c:if test="${not empty customer.telephone}">
        <p><strong>Phone:</strong> ${customer.telephone}</p>
      </c:if>
      <c:if test="${not empty customer.address}">
        <p><strong>Address:</strong> ${customer.address}</p>
      </c:if>
    </div>
    
    <table>
      <thead>
        <tr>
          <th>Item</th>
          <th>Qty</th>
          <th>Price</th>
          <th class="text-right">Subtotal</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${items}">
          <tr>
            <td>${item.product.productName}</td>
            <td>${item.quantity}</td>
            <td>Rs. ${String.format("%.2f", item.unitPrice)}</td>
            <td class="text-right">Rs. ${String.format("%.2f", item.total)}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    
    <div class="totals">
      <table>
        <tr>
          <td><strong>Subtotal:</strong></td>
          <td class="text-right"><strong>Rs. ${String.format("%.2f", invoice.subtotal)}</strong></td>
        </tr>
        <tr>
          <td><strong>Amount Paid:</strong></td>
          <td class="text-right"><strong>Rs. ${String.format("%.2f", invoice.amountPaid)}</strong></td>
        </tr>
        <tr>
          <td><strong>Balance:</strong></td>
          <td class="text-right"><strong>Rs. ${String.format("%.2f", invoice.balance)}</strong></td>
        </tr>
      </table>
    </div>
    
    <div class="footer">
      <p>Thank you for your purchase!</p>
      <p>Pahana Edu - ${java.time.Year.now().getValue()}</p>
    </div>
    
    <div class="no-print">
      <button onclick="window.print()" class="btn btn-primary">
        <i class="fa fa-print"></i> Print Invoice
      </button>
      <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new" class="btn btn-secondary">
        <i class="fa fa-plus"></i> New Sale
      </a>
      <a href="${pageContext.request.contextPath}/InvoiceServlet?action=report" class="btn btn-info">
        <i class="fa fa-chart-bar"></i> Sales Report
      </a>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
</body>
</html>