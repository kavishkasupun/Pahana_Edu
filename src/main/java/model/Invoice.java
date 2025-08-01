package model;

import java.sql.Timestamp;

public class Invoice {
    private int invoiceId;
    private int customerId;
    private int userId;
    private double subtotal;
    private double total;
    private double amountPaid;
    private double balance;
    private Timestamp invoiceDate;
    
    // Getters and Setters
    public int getInvoiceId() { return invoiceId; }
    public void setInvoiceId(int invoiceId) { this.invoiceId = invoiceId; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    public double getAmountPaid() { return amountPaid; }
    public void setAmountPaid(double amountPaid) { this.amountPaid = amountPaid; }
    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }
    public Timestamp getInvoiceDate() { return invoiceDate; }
    public void setInvoiceDate(Timestamp invoiceDate) { this.invoiceDate = invoiceDate; }
}