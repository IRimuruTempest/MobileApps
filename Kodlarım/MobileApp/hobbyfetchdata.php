<?php
// Replace with your database credentials
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

// Create connection
$conn = new mysqli($host, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get user ID from the POST request
$userID = $_POST['useridValue'];

// Use prepared statement to avoid SQL injection
$sql = "SELECT hobby_name FROM hobby WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userID);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Output data as JSON array
    $output = array();
    while($row = $result->fetch_assoc()) {
        $output[] = $row['hobby_name'];
    }
    echo json_encode($output);
} else {
    echo "No hobbies found for the user.";
}

$stmt->close();
$conn->close();
?>