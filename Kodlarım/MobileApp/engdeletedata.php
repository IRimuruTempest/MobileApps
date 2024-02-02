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
$eng_user_id = trim($_POST['eng_user_id']);
$english_word = trim($_POST['english_word']);
$turkish_word = trim($_POST['turkish_word']);
// SQL sorgusu
$stmt = $conn->prepare("DELETE FROM kelimeler WHERE eng_user_id = ? AND english_word = ? AND turkish_word = ?");
$stmt->bind_param("sss", $eng_user_id, $english_word, $turkish_word);
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