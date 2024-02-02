<?php
// Replace these values with your actual database credentials
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

// Establish a connection to the MySQL database
$connection = new mysqli($host, $username, $password, $database);

// Check the connection
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

$username = $connection->real_escape_string($_POST['username']);
$password = $connection->real_escape_string($_POST['password']);

// Query to check user credentials using prepared statement
$query = "SELECT * FROM users WHERE user_username = ? AND user_password = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("ss", $username, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Login successful
    $row = $result->fetch_assoc();
    $response['success'] = true;
    $response['message'] = 'Login successful';
    $response['user_id'] = $row['user_id']; // Replace 'userID' with your actual column name
} else {
    // Login failed
    $response['success'] = false;
    $response['message'] = 'Invalid username or password';
}

// Return JSON response to Flutter app
header('Content-Type: application/json');
echo json_encode($response);

// Close the database connection
$connection->close();
?>