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
$englishWord = $_POST['englishWord'];
$turkishWord = $_POST['turkishWord'];
$currentUser = $_POST['currentUser'];

// Insert data into the database
$sql = "INSERT INTO kelimeler (eng_user_id, english_word, turkish_word) VALUES ('$currentUser', '$englishWord', '$turkishWord')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>