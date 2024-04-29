package Chargement;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.Cell;



public class InsertionClientOracle {
			
    public static void main(String[] args) throws BiffException, IOException {
    	Connection connection = null;
    	// Connexion à la base de données Oracle
	    try {
	        Class.forName("oracle.jdbc.driver.OracleDriver");
	        connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/freepdb1", "TP", "TP");
	        if (connection != null) {
	            System.out.println("Connexion à la base de données Oracle établie avec succès.");
	            
	            File fichierExcel = new File("C:\\Users\\taouf\\OneDrive\\Documents\\LBD\\L4\\BD_ETL\\src\\BD\\Clients.xls");
	            Workbook workbook = Workbook.getWorkbook(fichierExcel);
	            Sheet feuille = workbook.getSheet(0); // Première feuille

	            String insertQuery = "INSERT INTO D_CLIENT (ID_CLIENT, NOM, FONCTION) VALUES (?, ?, ?)";
	            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
	            
	            for (int i = 1; i <  feuille.getRows(); i++) {
	                Cell[] ligne = feuille.getRow(i);

	                // Vérifier si la ligne contient au moins 3 colonnes
	                if (ligne.length >= 3) {

	                // Récupérer les valeurs des colonnes de chaque ligne
	                String valeur1 = ligne[0].getContents();
	                String valeur2 = ligne[1].getContents();
	                String valeur3 = ligne[2].getContents();

	                // Remplacer les ? dans la requête préparée avec les valeurs récupérées
	                preparedStatement.setString(1, valeur1);
	                preparedStatement.setString(2, valeur2);
	                preparedStatement.setString(3, valeur3);

	                // Exécuter l'insertion
	                preparedStatement.executeUpdate();
	                }
	            }

	            System.out.println("Insertion terminée avec succès.");

	            workbook.close();
	            preparedStatement.close();
	        } else {
	            System.out.println("Échec de la connexion à la base de données Oracle.");
	        }
	    
	    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
	    } 
    }
}
