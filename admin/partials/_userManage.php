<?php
    include '_dbconnect.php';

if($_SERVER["REQUEST_METHOD"] == "POST") {

    if(isset($_POST['removeUser'])) {
        $Id = $_POST["Id"];
        $sql = "DELETE FROM `users` WHERE `id`='$Id'";   
        $result = mysqli_query($conn, $sql);
        echo "<script>alert('Xóa');
            window.location=document.referrer;
            </script>";
    }
    
    if(isset($_POST['createUser'])) {
        $username = $_POST["username"];
        $firstName = $_POST["firstName"];
        $lastName = $_POST["lastName"];
        $email = $_POST["email"];
        $phone = $_POST["phone"];
        $userType = $_POST["userType"];
        $password = $_POST["password"];
        $cpassword = $_POST["cpassword"];
        
        // Check khi có tên tài khoản đã có từ trước
        $existSql = "SELECT * FROM `users` WHERE username = '$username'";
        $result = mysqli_query($conn, $existSql);
        $numExistRows = mysqli_num_rows($result);
        if($numExistRows > 0){
            echo "<script>alert('Tên tài khoản đã tồn tại');
                    window.location=document.referrer;
                </script>";
        }
        else{
            if(($password == $cpassword)){
                $hash = password_hash($password, PASSWORD_DEFAULT);
                $sql = "INSERT INTO `users` ( `username`, `firstName`, `lastName`, `email`, `phone`, `userType`, `password`, `joinDate`) VALUES ('$username', '$firstName', '$lastName', '$email', '$phone', '$userType', '$hash', current_timestamp())";   
                $result = mysqli_query($conn, $sql);
                if ($result){
                    echo "<script>alert('Thành công');
                            window.location=document.referrer;
                        </script>";
                }else {
                    echo "<script>alert('lỗi!');
                            window.location=document.referrer;
                        </script>";
                }
            }
            else{
                echo "<script>alert('Mật khẩu không phù hợp');
                    window.location=document.referrer;
                </script>";
            }
        }
    }
    if(isset($_POST['editUser'])) {
        $id = $_POST["userId"];
        $firstName = $_POST["firstName"];
        $lastName = $_POST["lastName"];
        $email = $_POST["email"];
        $phone = $_POST["phone"];
        $userType = $_POST["userType"];

        $sql = "UPDATE `users` SET `firstName`='$firstName', `lastName`='$lastName', `email`='$email', `phone`='$phone', `userType`='$userType' WHERE `id`='$id'";   
        $result = mysqli_query($conn, $sql);
        if ($result){
            echo "<script>alert('update thành công');
                window.location=document.referrer;
                </script>";
        }
        else {
            echo "<script>alert('lỗi!');
                window.location=document.referrer;
                </script>";
        }
    }
    
    if(isset($_POST['updateProfilePhoto'])) {
        $id = $_POST["userId"];
        $check = getimagesize($_FILES["userimage"]["tmp_name"]);
        if($check !== false) {
            $newfilename = "person-".$id.".jpg";

            $uploaddir = $_SERVER['DOCUMENT_ROOT'].'/OnlinePizzaDelivery/img/';
            $uploadfile = $uploaddir . $newfilename;

            if (move_uploaded_file($_FILES['userimage']['tmp_name'], $uploadfile)) {
                echo "<script>alert('Thành công');
                        window.location=document.referrer;
                    </script>";
            } else {
                echo "<script>alert('lỗi!');
                        window.location=document.referrer;
                    </script>";
            }
        }
        else{
            echo '<script>alert("Xin hãy chọn ảnh để upload.");
            window.location=document.referrer;
                </script>';
        }
    }
    
    if(isset($_POST['removeProfilePhoto'])) {
        $id = $_POST["userId"];
        $filename = $_SERVER['DOCUMENT_ROOT']."/OnlinePizzaDelivery/img/person-".$id.".jpg";
        if (file_exists($filename)) {
            unlink($filename);
            echo "<script>alert('Xóa');
                window.location=document.referrer;
            </script>";
        }
        else {
            echo "<script>alert('Ảnh chưa có sẵn.');
                window.location=document.referrer;
            </script>";
        }
    }
}
?>