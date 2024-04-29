package Chargement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ChargementED {
	
	public void chargerDimensionProduit (String cheminBaseDonneesorcale , String chemainsqlite) {
		Connection connection = null;
		Connection connection1 = null;
		String[] columns = {"RefProduit", "NomDuProduit", "CodeCategorie"}; 
		String[] columnsreceive = {"ID_PRODUIT", "NOM_P" , "CATEGORIES"};
	    try {
	        // Connexion à la base de données SQLite
	        Class.forName("org.sqlite.JDBC");
	        connection = DriverManager.getConnection("jdbc:sqlite:" + chemainsqlite);
	        if (connection != null) {
	            System.out.println("Connexion à la base de données SQLite établie avec succès.");
	            
	            
             
	        } else {
	            System.out.println("Échec de la connexion à la base de données SQLite.");
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    } 

	    // Connexion à la base de données Oracle
	    try {
	        Class.forName("oracle.jdbc.driver.OracleDriver");
	        connection1 = DriverManager.getConnection("jdbc:oracle:thin:@" + cheminBaseDonneesorcale, "TP", "TP");
	        if (connection1 != null) {
	            System.out.println("Connexion à la base de données Oracle établie avec succès.");
	            String selectQuery = constructSelectQuery("Produits", columns);
	            
	            try (
	                Statement sourceStatement = connection.createStatement();
	                ResultSet resultSet = sourceStatement.executeQuery(selectQuery);
	                PreparedStatement insertStatement = connection1.prepareStatement(constructInsertQuery("D_PRODUIT", columnsreceive));
	            ) {
	                // Boucle sur les résultats du SELECT et insertion dans la table cible
	                while (resultSet.next()) {
	                    // Définir les valeurs des colonnes pour l'insertion
	                    for (int i = 0; i < columns.length; i++) {
	                        insertStatement.setObject(i + 1, resultSet.getObject(columns[i]));
	                    }
	                    // Exécution de la requête INSERT
	                    insertStatement.executeUpdate();
	                }
	                System.out.println("Insertions terminées avec succès.");
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	            
	        } else {
	            System.out.println("Échec de la connexion à la base de données Oracle.");
	        }
	        
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    } 
	}
		
    private String constructSelectQuery(String tableName, String[] columns) {
        StringBuilder queryBuilder = new StringBuilder("SELECT ");
        for (int i = 0; i < columns.length; i++) {
            queryBuilder.append(columns[i]);
            if (i < columns.length - 1) {
                queryBuilder.append(", ");
            }
        }
        queryBuilder.append(" FROM ").append(tableName);
        return queryBuilder.toString();
    }

    private String constructInsertQuery(String tableName, String[] columns) {
        StringBuilder queryBuilder = new StringBuilder("INSERT INTO ");
        queryBuilder.append(tableName).append(" (");
        for (int i = 0; i < columns.length; i++) {
            queryBuilder.append(columns[i]);
            if (i < columns.length - 1) {
                queryBuilder.append(", ");
            }
        }
        queryBuilder.append(") VALUES (");
        for (int i = 0; i < columns.length; i++) {
            queryBuilder.append("?");
            if (i < columns.length - 1) {
                queryBuilder.append(", ");
            }
        }
        queryBuilder.append(")");
        return queryBuilder.toString();
    }
    
    
	public static void main(String[] args) {
	    ChargementED chargementED = new ChargementED();
	    chargementED.chargerDimensionProduit("localhost:1521/freepdb1", "C:\\Users\\taouf\\OneDrive\\Documents\\LBD\\L4\\BD_ETL\\src\\BD\\comptoir.db");

	}

}



