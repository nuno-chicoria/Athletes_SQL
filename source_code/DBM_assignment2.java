
package connectionMySql;
import java.sql.*;
import java.io.*;

public class connectionMySql {
	/**
	 * @author Tine Van Calster
	 * Ph.D. Department of Decision Sciences and Information Management
	 * KULeuven
	 * 
	 * @Student	Nuno Gonçalo Pires Chicória
	 * @Number	r0698632
	 * 
	 * @note		We assume that the user will input existing eventIDs.
	 */
	static
	{
		try
		{
			/* Type 4 Driver */
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (ClassNotFoundException e)
		{
			System.err.println("Could not load MySql driver.");
			System.err.println(e.getMessage());
			System.exit(1);
		}
	}

	public static void main (String args[])
	{
		String uname = null;
		String psswrd = null;
		int eventnr = 0;
		String nbparticipants;
		String eventname = null;

		 /* Reading log-in data (username and password) */
				try
				{
					BufferedReader br1 = new BufferedReader (new
							InputStreamReader(System.in));
					System.out.print("Enter your username on MySql: ");
					uname = br1.readLine();
					BufferedReader br2 = new BufferedReader(new
							InputStreamReader(System.in));
					System.out.print("Enter your password on MySql: ");
					psswrd = br2.readLine();
		
				}
				catch (IOException e)
				{
					System.out.print("Failed to get uname/passwd");
					System.out.println(":" + e.getMessage());
					System.exit(1);
				}

		/* Reading the desired event number */
		try
		{
			BufferedReader br3 = new BufferedReader(new
					InputStreamReader(System.in));
			System.out.print("Please enter the event number (if you want to quit enter 0): ");
			eventnr = Integer.parseInt(br3.readLine());
		}
		catch (IOException e)
		{
			System.out.print("Failed to get a valid event number");
			System.out.println(":" + e.getMessage());
			System.exit(1);
		}

		while (eventnr != 0) {
			/* Location of the database */
			String host = "jdbc:mysql://localhost/athletedb";
			/* Queries for the event */
			String queryEvent = "SELECT Name, Date, Location\n" + 
					"FROM event\n" + 
					"WHERE eventID = " + eventnr + ";";
			String queryEventNbParticipants = "SELECT COUNT(athleteID)\n" + 
					"FROM participation_ind\n" + 
					"WHERE eventID = " + eventnr + ";";
			String queryEventParticipants = "SELECT a.fname, a.lname, p.performance_in_minutes\n" + 
					"FROM athlete AS a\n" + 
					"INNER JOIN participation_ind AS p\n" + 
					"ON a.athleteID = p.athleteID\n" + 
					"WHERE eventID = " + eventnr + "\n" + 
					"ORDER BY p.Performance_in_minutes;";
			String queryEventManWinner = "SELECT a.fname, a.lname\n" +
					"FROM athlete AS a\n" +
					"INNER JOIN participation_ind AS p\n" +
					"ON a.athleteID = p.athleteID\n" +
					"WHERE eventID = " + eventnr + " AND p.performance_in_minutes = \n" +
					"	(SELECT MIN(p.performance_in_minutes)\n" +
					"	FROM athlete AS a\n" + "	INNER JOIN participation_ind AS p\n" +
					"	ON a.athleteID = p.athleteID\n" +
					"   WHERE a.sex = \"M\" AND eventID = " + eventnr + ");";
			String queryEventWomanWinner = "SELECT a.fname, a.lname\n" +
					"FROM athlete AS a\n" +
					"INNER JOIN participation_ind AS p\n" +
					"ON a.athleteID = p.athleteID\n" +
					"WHERE eventID = " + eventnr + " AND p.performance_in_minutes = \n" +
					"	(SELECT MIN(p.performance_in_minutes)\n" +
					"	FROM athlete AS a\n" +
					"	INNER JOIN participation_ind AS p\n" +
					"	ON a.athleteID = p.athleteID\n" +
					"   WHERE a.sex = \"F\" AND eventID = " + eventnr + ");";
			/* Querying the database for informations about the event */
			try {
				/* Connect to MySql database */
				Connection conn = DriverManager.getConnection(host, uname, psswrd);
				/* Create statement */
				Statement stmt = conn.createStatement();
				/* Execute the query */
				ResultSet rs1 = stmt.executeQuery(queryEvent);
				/* Output */
				rs1.next();
				System.out.print("The running event ");
				eventname = rs1.getString(1);
				System.out.print(eventname);
				System.out.print((" is organized on "));
				System.out.print(rs1.getString(2));
				System.out.print((" at "));
				System.out.print(rs1.getString(3));
				rs1.close();
				System.out.print("\n");
				System.out.print("***********************\n");
				ResultSet rs2 = stmt.executeQuery(queryEventNbParticipants);
				rs2.next();
				nbparticipants = rs2.getString(1);
				System.out.print(eventname);
				System.out.print(" has ");
				System.out.print(nbparticipants);
				System.out.print("  participants.");
				rs2.close();
				System.out.print("\n\n");
				System.out.print("First name // Last name // Performance\n");
				System.out.print("-----------------------\n");
				ResultSet rs3 = stmt.executeQuery(queryEventParticipants);
				while (rs3.next()) {
					System.out.print(rs3.getString(1));
					System.out.print((" // "));
					System.out.print(rs3.getString(2));
					System.out.print((" // "));
					if (rs3.getString(3) == null)
						System.out.print("***");
					else
						System.out.print(rs3.getString(3) + " minutes");
					System.out.print("\n");
				}
				rs3.close();
				System.out.print("\n");
				ResultSet rs4 = stmt.executeQuery(queryEventManWinner);
				System.out.print("The winner of " + eventname + " is ");
				if (!rs4.next())
					System.out.print("*** (men) and ");
				else
					System.out.print(rs4.getString(1) + " " + rs4.getString(2) + " (men) and ");
				rs4.close();
				ResultSet rs5 = stmt.executeQuery(queryEventWomanWinner);
				if (!rs5.next())
					System.out.print("*** (women).\n\n");
				else
					System.out.print(rs5.getString(1) + " " + rs5.getString(2) + " (women).\n\n");
				rs5.close();
				stmt.close();
				conn.close();
				
				try
				{
					BufferedReader br3 = new BufferedReader(new
							InputStreamReader(System.in));
					System.out.print("Please enter the event number (if you want to quit enter 0): ");
					eventnr = Integer.parseInt(br3.readLine());
				}
				catch (IOException e)
				{
					System.out.print("Failed to get a valid event number");
					System.out.println(":" + e.getMessage());
					System.exit(1);
				}
				
				
			} catch (SQLException e) {
				System.out.println("SQL Exception: ");
				System.err.println(e.getMessage());
			} 

		}
		System.out.print("End of session");
		System.exit(1);

	}

}
