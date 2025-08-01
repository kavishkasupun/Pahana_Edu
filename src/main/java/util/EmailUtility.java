package util;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {
    private static final String HOST = "smtp.gmail.com";
    private static final String USER = "kavishkasupunpathiraja@gmail.com"; // your Gmail
    private static final String PASSWORD = "zdglcgnmqdvotlld"; // app password without spaces/line breaks
    private static final int PORT = 587;

    public static void sendEmail(String to, String subject, String messageText) throws Exception {
        sendEmail(to, subject, messageText, false);
    }

    public static void sendEmail(String to, String subject, String messageText, boolean isHtml) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        
        // Additional properties for better reliability
        props.put("mail.smtp.ssl.trust", HOST);
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.timeout", "5000");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USER, PASSWORD);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Set the content type based on isHtml flag
            if (isHtml) {
                message.setContent(messageText, "text/html; charset=utf-8");
            } else {
                message.setText(messageText);
            }

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send email", e);
        }
    }

    public static void sendEmailWithAttachment(String to, String subject, String messageText, String attachmentPath) 
            throws Exception {
        sendEmailWithAttachment(to, subject, messageText, attachmentPath, false);
    }

    public static void sendEmailWithAttachment(String to, String subject, String messageText, 
            String attachmentPath, boolean isHtml) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        
        // Additional properties for better reliability
        props.put("mail.smtp.ssl.trust", HOST);
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.timeout", "5000");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USER, PASSWORD);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Create the message part
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            
            // Set content type based on isHtml flag
            if (isHtml) {
                messageBodyPart.setContent(messageText, "text/html; charset=utf-8");
            } else {
                messageBodyPart.setText(messageText);
            }

            // Create a multipart message
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            // Add attachment if provided
            if (attachmentPath != null && !attachmentPath.isEmpty()) {
                MimeBodyPart attachmentBodyPart = new MimeBodyPart();
                DataSource source = new FileDataSource(attachmentPath);
                attachmentBodyPart.setDataHandler(new DataHandler(source));
                attachmentBodyPart.setFileName(source.getName());
                multipart.addBodyPart(attachmentBodyPart);
            }

            // Set the complete message parts
            message.setContent(multipart);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send email", e);
        }
    }
    
    public static void sendHtmlEmail(String to, String subject, String htmlContent) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.ssl.trust", HOST);
        
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USER, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            
            // Set HTML content with proper MIME type
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send email", e);
        }
    }
}