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
$incomeName = $_POST['IncomeName'];
$incomeValue = $_POST['IncomeValue']; // int olarak dönüştürdük
$userID = $_POST['UserID']; // int olarak dönüştürdük
$incomeDate = $_POST['IncomeDate']; // Tarih bilgisini al
$incomePeriod = $_POST['IncomePeriod']; // Dönem bilgisini al

// Ekleme işlemi
$stmt = $conn->prepare("INSERT INTO incomes (income_name, income_amount, user_id, IncomeDate, IncomePeriod) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sdisi", $incomeName, $incomeValue, $userID, $incomeDate, $incomePeriod);

if ($stmt->execute()) {
    echo "Yeni kayıt başarıyla eklendi";
} else {
    echo "Hata: " . $stmt->error;
}

// Bağlantıyı kapat
$stmt->close();
$conn->close();
?>