<?php
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

// Get data from Flutter
$currentUser = $_POST['currentUserId'];
$bookName = $_POST['BookName'];

// Fetch data from the database
$sql = "SELECT book_part FROM user_books_page WHERE user_id = '$currentUser' AND book_name = '$bookName'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode($data);
} else {
    echo json_encode(array()); // or echo "No data found for the specified user.";
}

$conn->close();
?>