<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

// Veritabanı bağlantısını oluştur
$conn = new mysqli($host, $username, $password, $database);

// Bağlantıyı kontrol et
if ($conn->connect_error) {
    die("Bağlantı başarısız: " . $conn->connect_error);
}

// Prepare the statement to prevent SQL injection
$current_user = mysqli_real_escape_string($conn, $_POST['current_user']);
$current_hobby = mysqli_real_escape_string($conn, $_POST['current_hobby']);

$query = "SELECT button_id, button_status FROM chain WHERE user_id=? AND hobby_name=?";
$stmt = $conn->prepare($query);
$stmt->bind_param("is", $current_user, $current_hobby);
$stmt->execute();
$result = $stmt->get_result();

if ($result) {
    $buttonStatuses = array();

    while ($row = $result->fetch_assoc()) {
        // Buton ID'sini 1 eksiğini al
        $button_id = $row['button_id'] - 1;
        $buttonStatuses[$button_id] = $row['button_status'];
    }

    echo json_encode(array("status" => "success", "data" => $buttonStatuses));
} else {
    // Provide user-friendly error message
    echo json_encode(array("status" => "error", "message" => "Veriler alınamadı."));
}

// Close statement and database connection
$stmt->close();
$conn->close();
?>