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
$spendingName = $_POST['SpendingName'];
$spendingValue = (int)$_POST['SpendingValue']; // int olarak dönüştürdük
$userID = (int)$_POST['UserID']; // int olarak dönüştürdük

// Ekleme işlemi
$sql = "INSERT INTO spendings (spending_name, spending_amount, user_id) VALUES ('$spendingName', '$spendingValue', '$userID')";

if ($conn->query($sql) === TRUE) {
    echo "Yeni kayıt başarıyla eklendi";
} else {
    echo "Hata: " . $sql . "<br>" . $conn->error;
}

// Bağlantıyı kapat
$conn->close();
?>