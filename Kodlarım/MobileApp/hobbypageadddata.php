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

// Get data from Flutter (sanitize and validate input)
$hobbyName = mysqli_real_escape_string($conn, $_POST['hobbyName']);
$useridValue = mysqli_real_escape_string($conn, $_POST['useridValue']);
$buttonid = 1;

// Insert data into the 'hobby' table
$sqlHobby = "INSERT INTO hobby (hobby_name, user_id) VALUES ('$hobbyName', '$useridValue')";

if ($conn->query($sqlHobby) === TRUE) {
    echo "Hobby data inserted successfully<br>";
} else {
    echo "Error inserting hobby data: " . $conn->error . "<br>";
}

// Insert data into the 'chain' table
$sqlChain = "INSERT INTO chain (hobby_name, user_id, button_id) VALUES ('$hobbyName', '$useridValue', '$buttonid')";

if ($conn->query($sqlChain) === TRUE) {
    echo "Chain data inserted successfully";
} else {
    echo "Error inserting chain data: " . $conn->error;
}

$conn->close();
?>