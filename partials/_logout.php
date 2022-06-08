<?php

session_start();
echo "Đang LogOut, xin vui lòng đợi giây lát...";
unset($_SESSION["loggedin"]);
unset($_SESSION["username"]);
unset($_SESSION["userId"]);

header("location: /OnlinePizzaDelivery/index.php");
?>