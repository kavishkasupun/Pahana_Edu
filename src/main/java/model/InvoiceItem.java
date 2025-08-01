package model;

public class InvoiceItem {
    private int itemId;
    private int invoiceId;
    private int productId;
    private Product product;  // Add this field
    private int quantity;
    private double unitPrice;
    private double total;
    
    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public int getInvoiceId() { return invoiceId; }
    public void setInvoiceId(int invoiceId) { this.invoiceId = invoiceId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public Product getProduct() { return product; }  // Add this getter
    public void setProduct(Product product) { this.product = product; }  // Add this setter
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}