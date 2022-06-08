<?php
include '_dbconnect.php';
session_start();

if($_SERVER["REQUEST_METHOD"] == "POST") {
    $userId = $_SESSION['userId'];
    
    $email = $_POST["email"];
    $phone = $_POST["phone"];
    $orderId = $_POST["orderId"];
    $message = $_POST["message"];
    $password = $_POST["password"];

    // Check mật khẩu xem đã đủ điều kiện hoặc không?
    $passSql = "SELECT * FROM users WHERE id='$userId'"; 
    $passResult = mysqli_query($conn, $passSql);
    $passRow=mysqli_fetch_assoc($passResult);
    
    if (password_verify($password, $passRow['password'])){
        $sql = "INSERT INTO `contact` (`userId`, `email`, `phoneNo`, `orderId`, `message`, `time`) VALUES ('$userId', '$email', '$phone', '$orderId', '$message', current_timestamp())";
        $result = mysqli_query($conn, $sql);
        $contactId = $conn->insert_id;
        echo '<script>alert("Cảm ơn đã liên hệ với chúng tôi, ID liên hệ của bạn là ' .$contactId. '. Chúng tôi sẽ liên hệ với bạn sớm nhất có thể.");
                    window.location.href="http://localhost/OnlinePizzaDelivery/index.php";  
                    </script>';
                    exit();
    }
    else{
        echo "<script>alert('Mật khẩu không đúng!!');
                window.history.back(1);
                </script>";
    }
    
}
?>