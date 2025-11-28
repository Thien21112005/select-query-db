package murach.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;

public class DBUtil {

    public static Connection getConnection() throws ServletException {
        try {
            // Load the driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Lấy từ env vars (set trong IntelliJ local hoặc Render production)
            String dbURL = System.getenv("DB_URL");
            String username = System.getenv("DB_USERNAME");
            String password = System.getenv("DB_PASSWORD");

            if (dbURL == null || username == null || password == null) {
                throw new ServletException("Missing database environment variables");
            }

            return DriverManager.getConnection(dbURL, username, password);
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error loading the database driver: " + e.getMessage());
        } catch (SQLException e) {
            throw new ServletException("Error connecting to the database: " + e.getMessage());
        }
    }
}