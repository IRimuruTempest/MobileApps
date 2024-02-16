<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

// Veritabanı bağlantısını oluştur
$conn = new mysqli($host, $username, $password, $database);

// Bağlantıyı kontrol et
if ($conn->connect_error) {
    die("Veritabanına bağlanılamadı: " . $conn->connect_error);
}

// Flutter uygulamasından gelen POST verilerini al
$userID = $_POST['UserID']; // int olarak dönüştürdük
$spendingName = $_POST['SpendingName'];

// Silme işlemi
$sql = "DELETE FROM spendings WHERE user_id = $userID AND spending_name = '$spendingName'";

if ($conn->query($sql) === TRUE) {
    echo "Gelir başarıyla silindi";
} else {
    echo "Hata: " . $sql . "<br>" . $conn->error;
}

// Bağlantıyı kapat
$conn->close();
?>