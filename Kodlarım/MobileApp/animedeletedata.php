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
$anim_user_id = trim($_POST['anim_user_id']);
$japanese_word = trim($_POST['japanese_word']);
$english_word = trim($_POST['english_word']);
$turkish_word = trim($_POST['turkish_word']);
// SQL sorgusu
$stmt = $conn->prepare("DELETE FROM anime_dictionary WHERE user_id = ? AND japanese_dictionary = ? AND english_dictionary = ? AND turkish_dictionary = ?");
$stmt->bind_param("ssss", $anim_user_id, $japanese_word, $english_word, $turkish_word);
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
