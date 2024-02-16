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

// Get current date and time
$login_time = date('Y-m-d H:i:s');

// Query to check user credentials using prepared statement
$query = "SELECT * FROM users WHERE user_username = ? AND user_password = ?";
$stmt = $connection->prepare($query);
$stmt->bind_param("ss", $username, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Login successful
    $row = $result->fetch_assoc();
    $user_id = $row['user_id'];

    // Insert login time into user_login_history table
    $insert_query = "INSERT INTO user_login_history (user_id, login_time) VALUES (?, ?)";
    $insert_stmt = $connection->prepare($insert_query);
    $insert_stmt->bind_param("is", $user_id, $login_time);
    $insert_stmt->execute();

    $response['success'] = true;
    $response['message'] = 'Login successful';
    $response['user_id'] = $user_id;
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