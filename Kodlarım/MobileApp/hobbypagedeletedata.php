<?php
// Veritabanı bağlantısı
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

$conn = new mysqli($host, $username, $password, $database);

// Bağlantıyı kontrol et
if ($conn->connect_error) {
    die("Bağlantı hatası: " . $conn->connect_error);
}

// Değişkenleri al
$hobbyName = trim($_POST['hobbyName']);
$userID = trim($_POST['userID']);
// SQL sorgusu
$stmt = $conn->prepare("DELETE FROM hobby WHERE user_id = ? AND hobby_name = ?");
$stmt->bind_param("ss", $userID, $hobbyName);
$stmt->execute();
$stmt->close();

// Sorguyu çalıştır
if ($conn->query($sql) === TRUE) {
    echo "Veri başarıyla silindi";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Bağlantıyı kapat
$conn->close();
?>
