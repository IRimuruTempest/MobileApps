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
$anime_nameValue = $_POST['anime_nameValue'];
$seasonValue = $_POST['seasonValue'];
$partValue = $_POST['partValue'];
$japanese_dictionaryValue = $_POST['japanese_dictionaryValue'];
$english_dictionaryValue = $_POST['english_dictionaryValue'];
$turkish_dictionaryValue = $_POST['turkish_dictionaryValue'];
$useridValue = $_POST['useridValue'];

// Insert data into the database
$sql = "INSERT INTO anime_dictionary (anime_name, season, part, japanese_dictionary, english_dictionary, turkish_dictionary, user_id) VALUES ('$anime_nameValue', '$seasonValue', '$partValue', '$japanese_dictionaryValue', '$english_dictionaryValue', '$turkish_dictionaryValue', '$useridValue')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>