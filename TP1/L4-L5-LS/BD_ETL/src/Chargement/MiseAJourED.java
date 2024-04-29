package Chargement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MiseAJourED {
	public void updateDimensionProduit(String cheminBaseDonneesOracle, String cheminSQLite) {
    // Méthode pour mettre à jour la dimension Produit
	Connection connection = null;
    Connection connectionOracle = null;

    try {
        // Connexion à la base de données SQLite
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:" + cheminSQLite);
        if (connection != null) {
            System.out.println("Connexion à la base de données SQLite établie avec succès.");
        } else {
            System.out.println("Échec de la connexion à la base de données SQLite.");
            return;
        }

        // Connexion à la base de données Oracle
        Class.forName("oracle.jdbc.driver.OracleDriver");
        connectionOracle = DriverManager.getConnection("jdbc:oracle:thin:@" + cheminBaseDonneesOracle, "TP", "TP");
        if (connectionOracle != null) {
            System.out.println("Connexion à la base de données Oracle établie avec succès.");
        } else {
            System.out.println("Échec de la connexion à la base de données Oracle.");
            return;
        }

        // Requête de mise à jour
        String updateQuery = "UPDATE D_PRODUIT SET NOM_P = ? WHERE ID_PRODUIT = ?";

        // Préparation de la requête
        try (PreparedStatement updateStatement = connectionOracle.prepareStatement(updateQuery)) {
            // Attribution des valeurs aux paramètres
            updateStatement.setString(1, "Chef Anton's Cajun Seasoning MODIF");
            updateStatement.setInt(2, 4);

            // Exécution de la requête d'update
            int rowsUpdated = updateStatement.executeUpdate();
            System.out.println(rowsUpdated + " lignes mises à jour.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Fermeture des connexions
        try {
            if (connection != null) connection.close();
            if (connectionOracle != null) connectionOracle.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
	 
		public static void main(String[] args) {
			MiseAJourED update = new MiseAJourED();
		    update.updateDimensionProduit("localhost:1521/freepdb1", "C:\\Users\\taouf\\OneDrive\\Documents\\LBD\\L4\\BD_ETL\\src\\BD\\comptoir.db");

		}
}
