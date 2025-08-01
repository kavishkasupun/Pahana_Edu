<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Invoice - Pahana Edu</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 20px; color: #333; }
    .invoice-box { max-width: 800px; margin: auto; padding: 30px; border: 1px solid #eee; box-shadow: 0 0 10px rgba(0, 0, 0, 0.15); }
    .header { display: flex; justify-content: space-between; margin-bottom: 20px; }
    .logo { text-align: center; }
    .logo img { max-width: 150px; }
    .invoice-title { text-align: center; margin: 20px 0; }
    .customer-info { margin-bottom: 30px; }
    table { width: 100%; line-height: inherit; text-align: left; border-collapse: collapse; }
    table td, table th { padding: 12px; border-bottom: 1px solid #eee; }
    table th { background: #f5f5f5; }
    .text-right { text-align: right; }
    .text-center { text-align: center; }
    .totals { margin-top: 30px; }
    .footer { margin-top: 50px; text-align: center; font-size: 0.9em; color: #777; }
    @media print {
      body { padding: 0; }
      .no-print { display: none; }
      .invoice-box { box-shadow: none; border: none; }
    }
  </style>
</head>
<body>
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
    
    <div class="no-print text-center mt-4">
      <button onclick="window.print()" class="btn btn-primary">Print Invoice</button>
      <a href="${pageContext.request.contextPath}/InvoiceServlet?action=new" class="btn btn-secondary">New Sale</a>
    </div>
  </div>
</body>
</html>