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

// Check if a record already exists for the given user, hobby, and day
$stmt_check = $conn->prepare("SELECT * FROM chain WHERE user_id = ? AND hobby_name = ? AND button_id = ?");
$stmt_check->bind_param("iss", $current_user, $current_hobby, $day);
$stmt_check->execute();

$result = $stmt_check->get_result();
if ($result->num_rows > 0) {
    // Record already exists, you may choose to update it instead
    echo json_encode(array("success" => false, "message" => "Record already exists for user, hobby, and day."));
} else {
    // Record doesn't exist, insert a new one
    $stmt_insert = $conn->prepare("INSERT INTO chain (user_id, hobby_name, button_id, button_status) VALUES (?, ?, ?, 1)");
    $stmt_insert->bind_param("iss", $current_user, $current_hobby, $day);

    if ($stmt_insert->execute()) {
        echo json_encode(array("success" => true, "message" => "Record inserted successfully"));
    } else {
        echo json_encode(array("success" => false, "message" => "Error inserting record: " . $stmt_insert->error));
    }

    $stmt_insert->close();
}

$stmt_check->close();
$conn->close();
?>