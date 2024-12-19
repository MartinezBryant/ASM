import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class PopOutWindowExample {

    public static void main(String[] args) {
        // Set the look and feel to the system's default
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Main frame setup
        JFrame mainFrame = new JFrame("Main Window");
        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        mainFrame.setSize(400, 300);
        mainFrame.setLocationRelativeTo(null); // Center on screen

        // Create a button to open the pop-out window
        JButton popOutButton = new JButton("Open Pop Out Window");
        popOutButton.setFocusPainted(false);
        popOutButton.setBackground(new Color(70, 130, 180)); // Steel blue color
        popOutButton.setForeground(Color.WHITE);
        popOutButton.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20)); // Padding

        // Add action listener to the button
        popOutButton.addActionListener((ActionEvent e) -> openPopOutWindow());

        // Panel to hold the button
        JPanel panel = new JPanel();
        panel.setBackground(Color.WHITE);
        panel.setBorder(BorderFactory.createEmptyBorder(50, 50, 50, 50)); // Padding around the panel
        panel.add(popOutButton);

        mainFrame.add(panel);
        mainFrame.setVisible(true);
    }

    private static void openPopOutWindow() {
        // Create a new JFrame for the pop-out window
        JFrame popOutFrame = new JFrame("Pop Out Window");
        popOutFrame.setSize(300, 200);
        popOutFrame.setLocationRelativeTo(null); // Center on screen
        popOutFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); // Close only the pop-out

        // Create a label and button for the pop-out window
        JLabel label = new JLabel("This is a pop-out window!", JLabel.CENTER);
        label.setFont(new Font("Arial", Font.BOLD, 16));

        JButton closeButton = new JButton("Close");
        closeButton.addActionListener(e -> popOutFrame.dispose());

        // Create a panel for layout
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        panel.add(label, BorderLayout.CENTER);
        panel.add(closeButton, BorderLayout.SOUTH);

        popOutFrame.add(panel);
        popOutFrame.setVisible(true);
    }
}
