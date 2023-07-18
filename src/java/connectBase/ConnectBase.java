/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connectBase;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Rabeasimbola
 */
public class ConnectBase {
    public Connection getConnexion() throws Exception{
        Class.forName("org.postgresql.Driver");
        Connection conn = (Connection) DriverManager.getConnection("jdbc:postgresql://localhost:5432/clinique","clinique","clinique");
        return conn;
    }
}
