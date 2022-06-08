<?php

session_start();
echo "Đang LogOut, xin hãy đợi trong giây lát...";
unset($_SESSION["adminloggedin"]);
unset($_SESSION["adminusername"]);
unset($_SESSION["adminuserId"]);


header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
