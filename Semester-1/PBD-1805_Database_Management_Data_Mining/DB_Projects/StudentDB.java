import java.sql.*;
import java.util.Scanner;

public class StudentDB {
    static final String DB_URL = "jdbc:mysql://localhost:3306/studentdb";
    static final String USER = "root";
    static final String PASS = "password";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Scanner sc = new Scanner(System.in)) {

            while (true) {
                System.out.println("\n1. Add Student\n2. View All\n3. Update\n4. Delete\n5. Exit");
                System.out.print("Choose: ");
                int choice = sc.nextInt();

                switch (choice) {
                    case 1 -> {
                        System.out.print("Enter name and marks: ");
                        String name = sc.next();
                        int marks = sc.nextInt();
                        PreparedStatement ps = conn.prepareStatement("INSERT INTO student(name, marks) VALUES (?, ?)");
                        ps.setString(1, name);
                        ps.setInt(2, marks);
                        ps.executeUpdate();
                        System.out.println("Added!");
                    }
                    case 2 -> {
                        ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM student");
                        while (rs.next()) {
                            System.out.printf("%d - %s - %d%n", rs.getInt("id"), rs.getString("name"), rs.getInt("marks"));
                        }
                    }
                    case 3 -> {
                        System.out.print("Enter ID and new marks: ");
                        int id = sc.nextInt();
                        int marks = sc.nextInt();
                        PreparedStatement ps = conn.prepareStatement("UPDATE student SET marks=? WHERE id=?");
                        ps.setInt(1, marks);
                        ps.setInt(2, id);
                        ps.executeUpdate();
                        System.out.println("Updated!");
                    }
                    case 4 -> {
                        System.out.print("Enter ID to delete: ");
                        int id = sc.nextInt();
                        PreparedStatement ps = conn.prepareStatement("DELETE FROM student WHERE id=?");
                        ps.setInt(1, id);
                        ps.executeUpdate();
                        System.out.println("Deleted!");
                    }
                    case 5 -> System.exit(0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
