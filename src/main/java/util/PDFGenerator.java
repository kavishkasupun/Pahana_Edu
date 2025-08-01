package util;

import model.Sale;
import model.SaleItem;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PDFGenerator {
    private static final Font TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    private static final Font SUBTITLE_FONT = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
    private static final Font NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 12);
    private static final Font BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);

    public static String generateInvoice(Sale sale, String basePath) throws Exception {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String fileName = "invoice_" + sale.getSaleId() + "_" + dateFormat.format(new Date()) + ".pdf";
        String filePath = basePath + File.separator + fileName;
        
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(filePath));
        document.open();
        
        // Add title
        Paragraph title = new Paragraph("PAHANA EDU - INVOICE", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);
        
        // Add invoice details
        PdfPTable detailsTable = new PdfPTable(2);
        detailsTable.setWidthPercentage(100);
        detailsTable.setSpacingBefore(10);
        detailsTable.setSpacingAfter(10);
        
        addDetailRow(detailsTable, "Invoice Number:", "INV-" + sale.getSaleId());
        addDetailRow(detailsTable, "Date:", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sale.getSaleDate()));
        addDetailRow(detailsTable, "Customer:", sale.getCustomerName());
        
        document.add(detailsTable);
        
        // Add items table
        PdfPTable itemsTable = new PdfPTable(4);
        itemsTable.setWidthPercentage(100);
        itemsTable.setSpacingBefore(20);
        itemsTable.setSpacingAfter(20);
        
        // Add table headers
        addTableHeader(itemsTable, "Product");
        addTableHeader(itemsTable, "Quantity");
        addTableHeader(itemsTable, "Unit Price");
        addTableHeader(itemsTable, "Subtotal");
        
        // Add items
        for (SaleItem item : sale.getItems()) {
            addTableCell(itemsTable, item.getProductName());
            addTableCell(itemsTable, String.valueOf(item.getQuantity()));
            addTableCell(itemsTable, String.format("Rs. %.2f", item.getUnitPrice()));
            addTableCell(itemsTable, String.format("Rs. %.2f", item.getSubtotal()));
        }
        
        document.add(itemsTable);
        
        // Add totals
        PdfPTable totalsTable = new PdfPTable(2);
        totalsTable.setWidthPercentage(50);
        totalsTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
        
        addTotalRow(totalsTable, "Total Amount:", String.format("Rs. %.2f", sale.getTotalAmount()));
        addTotalRow(totalsTable, "Amount Paid:", String.format("Rs. %.2f", sale.getAmountPaid()));
        addTotalRow(totalsTable, "Balance:", String.format("Rs. %.2f", sale.getBalance()));
        
        document.add(totalsTable);
        
        // Add footer
        Paragraph footer = new Paragraph("\n\nThank you for your purchase!", NORMAL_FONT);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);
        
        document.close();
        
        return filePath;
    }

    private static void addDetailRow(PdfPTable table, String label, String value) {
        table.addCell(createCell(label, true));
        table.addCell(createCell(value, false));
    }

    private static void addTableHeader(PdfPTable table, String header) {
        PdfPCell cell = new PdfPCell(new Phrase(header, BOLD_FONT));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);
    }

    private static void addTableCell(PdfPTable table, String text) {
        table.addCell(createCell(text, false));
    }

    private static void addTotalRow(PdfPTable table, String label, String value) {
        table.addCell(createCell(label, true));
        table.addCell(createCell(value, false));
    }

    private static PdfPCell createCell(String text, boolean bold) {
        PdfPCell cell = new PdfPCell(new Phrase(text, bold ? BOLD_FONT : NORMAL_FONT));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(5);
        return cell;
    }
}