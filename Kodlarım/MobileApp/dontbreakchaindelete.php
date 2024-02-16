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

// Retrieve data from Flutter app
$current_user = $_POST['current_user'];
$current_hobby = $_POST['current_hobby'];
$day = $_POST['day'];

// Check if a record exists for the given user, hobby, and day
$stmt_check = $conn->prepare("SELECT * FROM chain WHERE user_id = ? AND hobby_name = ? AND button_id = ?");
$stmt_check->bind_param("iss", $current_user, $current_hobby, $day);
$stmt_check->execute();

$result = $stmt_check->get_result();
if ($result->num_rows > 0) {
    // Record exists, proceed with deletion
    $stmt_delete = $conn->prepare("DELETE FROM chain WHERE user_id = ? AND hobby_name = ? AND button_id = ?");
    $stmt_delete->bind_param("iss", $current_user, $current_hobby, $day);

    if ($stmt_delete->execute()) {
        echo json_encode(array("success" => true, "message" => "Record deleted successfully"));
    } else {
        echo json_encode(array("success" => false, "message" => "Error deleting record: " . $stmt_delete->error));
    }

    $stmt_delete->close();
} else {
    // Record doesn't exist, you may choose to handle it accordingly
    echo json_encode(array("success" => false, "message" => "Record not found for user, hobby, and day."));
}

$stmt_check->close();
$conn->close();
?>