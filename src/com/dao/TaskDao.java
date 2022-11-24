package com.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Task;

public class TaskDao {
	private String jdbcURL = "jdbc:mysql://localhost:3306/project?useSSL=false";
	private String jdbcUsername = "root";
	private String jdbcPassword = "root";
	
	private static final String INSERT_TASK_SQL = "insert into task (name, email, address, phone, city, country, education, photo) "+
													" values (?,?,?,?,?,?,?,?);";
	private static final String SELECT_TASK_BY_ID = "select name, email, address, phone, city, country, education from task where id =?";
	private static final String SELECT_TASK_PEEK = "select id, name, date, city from task ";
	private static final String DELETE_TASK_SQL = "delete from task where id = ?;";
	private static final String UPDATE_TASK_SQL = "update task set name = ?,email= ?, address=?, phone=?, city=?, country =?, education =?, photo =? where id = ?;";
	private static final String VIEW_DATA = "select name, email, address, phone, city, country, education, photo from task where id=?;";
	public TaskDao() {
	}
	
	// connection
	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}
	
	// insert
	public void insertTask(Task task) throws FileNotFoundException  {
		System.out.println(INSERT_TASK_SQL);
		// try-with-resource statement will auto close the connection.
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TASK_SQL)) {
			preparedStatement.setString(1, task.getName());
			preparedStatement.setString(2, task.getEmail());
			preparedStatement.setString(3, task.getAddress());
			preparedStatement.setString(4, task.getPhone());
			preparedStatement.setString(5, task.getCity());
			preparedStatement.setString(6, task.getCountry());
			preparedStatement.setString(7, task.getEducation());
			String img = task.getPhoto();
			File file = new File (img);
			FileInputStream fis = new FileInputStream(file);
			int len = (int)file.length();
			preparedStatement.setBinaryStream(8, (InputStream)fis, len);
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			printSQLException(e);
		
		}
	}
	
	// View by ID
	public Task viewtask (int id) {
		Task task = null;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(SELECT_TASK_BY_ID);) {
			statement.setInt(1, id);
			System.out.println(statement);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String name = rs.getString("name");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String city = rs.getString("city");
				String country = rs.getString("country");
				String education = rs.getString("education");
				task = new Task (id, name, email, address, phone, city, country, education);
			}
			}catch (SQLException e) {
				printSQLException(e);
			}
			return task;
	} 
	//View record
	public List<Task> PeekTask() {
		List<Task> task = new ArrayList<>();
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(SELECT_TASK_PEEK);) {
			System.out.println(statement);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id"); //id, name, date, city
				String name = rs.getString("name");
				String date = rs.getString("date");
				String city = rs.getString("city");
				task.add(new Task(id, name, date, city));
			}
		}catch (SQLException e) {
			printSQLException(e);
		}
		return task;
	}
	
	// delete
	public boolean deleteTask (int id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(DELETE_TASK_SQL);) {
			statement.setInt(1, id);
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}
	
	// Update
	public boolean updateTask (Task task) throws SQLException, FileNotFoundException {
		boolean rowUpdate;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(UPDATE_TASK_SQL);){
			System.out.println("Update task "+statement);
			statement.setString(1, task.getName()); //name, email, address, phone, city, country, education, photo
			statement.setString(2, task.getEmail());
			statement.setString(3, task.getAddress());
			statement.setString(4, task.getPhone());
			statement.setString(5, task.getCity());
			statement.setString(6, task.getCountry());
			statement.setString(7, task.getEducation());
			String img = task.getPhoto();
			File file = new File (img);
			FileInputStream fis = new FileInputStream(file);
			int len = (int)file.length();
			statement.setBinaryStream(8, (InputStream)fis, len);
			statement.setInt(9, task.getId());
			rowUpdate = statement.executeUpdate() > 0;
		}
		return rowUpdate;
	}
	//View Data
	public Task selectdata (int id) {
		Task task = null;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(VIEW_DATA);) {
			statement.setInt(1, id);
			System.out.println(statement);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String name = rs.getString("name");
				String email = rs.getString("email");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String city = rs.getString("city");
				String country = rs.getString("country");
				String education = rs.getString("education");
				Blob img = rs.getBlob("photo");
				byte image [] = img.getBytes(1, (int)img.length());
				task = new Task (id, name, email, address, phone, city, country, education, image);
			}
			}catch (SQLException e) {
				printSQLException(e);
			}return task;
	}
	
	// error
	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if (e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " + e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}
	}
}