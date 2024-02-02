<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$data = json_decode(file_get_contents("php://input"));

// Validate the received data (add more validation as needed)
if (isset($data->username) && isset($data->password)) {
    $username = $data->username;
    $password = $data->password;

    // Perform database operations or other necessary actions here

    // Example: Insert data into a database
    $servername = "localhost";
    $username_db = "root";
    $password_db = "";
    $dbname = "flutterapp";

    $conn = new mysqli($servername, $username_db, $password_db, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "INSERT INTO users (user_username, user_password) VALUES ('$username', '$password')";

    if ($conn->query($sql) === TRUE) {
        $user_id = $conn->insert_id; // Retrieve the last inserted ID
        $response = ["message" => "Signup successful", "user_id" => $user_id];
        echo json_encode($response);
    } else {
        $response = ["message" => "Error during signup: " . $conn->error];
        echo json_encode($response);
    }

    $conn->close();
} else {
    $response = ["message" => "Invalid data received"];
    echo json_encode($response);
}
?>