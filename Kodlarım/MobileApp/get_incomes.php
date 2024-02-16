<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "flutterapp";

// MySQL bağlantısını oluştur
$conn = new mysqli($host, $username, $password, $database);

// Bağlantıyı kontrol et
if ($conn->connect_error) {
    die("Bağlantı hatası: " . $conn->connect_error);
}

$currentUser = $_GET['user_id']; // Flutter tarafından gönderilen kullanıcı kimliği

// Veritabanından veri çekme sorgusu
$sql = "SELECT income_name, income_amount, IncomePeriod, IncomeDate FROM incomes WHERE user_id = '$currentUser'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $output = array();
    while($row = $result->fetch_assoc()) {
        // Veritabanından alınan tarihi ISO 8601 formatına dönüştür
        $row["IncomeDate"] = date("c", strtotime($row["IncomeDate"]));
        $output[] = $row;
    }
    echo json_encode($output);
} else {
    echo json_encode(array()); // Veri bulunamadığında boş bir JSON dizi döndürün
}
$conn->close();
?>