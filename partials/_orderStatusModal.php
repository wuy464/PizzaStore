<style>
    /* .modal-body {
        background-color: #eeeeee;
        font-family: 'Open Sans', serif
    } */

    .card {
        position: relative;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        -ms-flex-direction: column;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 0.10rem
    }

    .card-header:first-child {
        border-radius: calc(0.37rem - 1px) calc(0.37rem - 1px) 0 0
    }

    .card-header {
        padding: 0.75rem 1.25rem;
        margin-bottom: 0;
        background-color: #fff;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1)
    }

    .track {
        position: relative;
        background-color: #ddd;
        height: 7px;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        margin-bottom: 60px;
        margin-top: 50px
    }

    .track .step {
        -webkit-box-flex: 1;
        -ms-flex-positive: 1;
        flex-grow: 1;
        width: 25%;
        margin-top: -18px;
        text-align: center;
        position: relative
    }

    .track .step.active:before {
        background: #FF5722
    }

    .track .step::before {
        height: 7px;
        position: absolute;
        content: "";
        width: 100%;
        left: 0;
        top: 18px
    }

    .track .step.active .icon {
        background: #ee5435;
        color: #fff
    }

    .track .step.deactive:before {
        background: #030303;
    }

    .track .step.deactive .icon {
        background: #030303;
        color: #fff
    }

    .track .icon {
        display: inline-block;
        width: 40px;
        height: 40px;
        line-height: 40px;
        position: relative;
        border-radius: 100%;
        background: #ddd
    }

    .track .step.active .text {
        font-weight: 400;
        color: #000
    }

    .track .text {
        display: block;
        margin-top: 7px
    }

    .btn-warning {
        color: #ffffff;
        background-color: #ee5435;
        border-color: #ee5435;
        border-radius: 1px
    }

    .btn-warning:hover {
        color: #ffffff;
        background-color: #ff2b00;
        border-color: #ff2b00;
        border-radius: 1px
    }
    
</style>
<?php 
    $statusmodalsql = "SELECT * FROM `orders` WHERE `userId`= $userId";
    $statusmodalresult = mysqli_query($conn, $statusmodalsql);
    while($statusmodalrow = mysqli_fetch_assoc($statusmodalresult)){
        $orderid = $statusmodalrow['orderId'];
        $status = $statusmodalrow['orderStatus'];
        if ($status == 0) 
            $tstatus = "Đã chuyển giao.";
        elseif ($status == 1) 
            $tstatus = "Đơn hàng được xác nhận.";
        elseif ($status == 2)
            $tstatus = "Đơn hàng chuẩn bị vận chuyển.";
        elseif ($status == 3)
            $tstatus = "Bánh đang giao!";
        elseif ($status == 4) 
            $tstatus = "Đã giao hàng.";
        elseif ($status == 5) 
            $tstatus = "Từ chối đơn hàng.";
        else
            $tstatus = "Đơn hàng bị hủy.";

        if($status >= 1 && $status <= 4) {
            $deliveryDetailSql = "SELECT * FROM `deliverydetails` WHERE `orderId`= $orderid";
            $deliveryDetailResult = mysqli_query($conn, $deliveryDetailSql);
            $deliveryDetailRow = mysqli_fetch_assoc($deliveryDetailResult);
            $trackId = $deliveryDetailRow['id'];
            $deliveryBoyName = $deliveryDetailRow['deliveryBoyName'];
            $deliveryBoyPhoneNo = $deliveryDetailRow['deliveryBoyPhoneNo'];
            $deliveryTime = $deliveryDetailRow['deliveryTime'];
            if($status == 4)
                $deliveryTime = 'xx';
        }
        else {
            $trackId = 'xxxxx';
            $deliveryBoyName = '';
            $deliveryBoyPhoneNo = '';
            $deliveryTime = 'xx';
        }

?>
<!-- Modal -->
<div class="modal fade" id="orderStatus<?php echo $orderid; ?>" tabindex="-1" role="dialog" aria-labelledby="orderStatus<?php echo $orderid; ?>" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderStatus<?php echo $orderid; ?>">Ghi chú đơn hàng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="printThis">
                <div class="container" style="padding-right: 0px;padding-left: 0px;">
                    <article class="card">
                        <div class="card-body">
                            <h6><strong>ID đơn hàng:</strong> #<?php echo $orderid; ?></h6>
                            <article class="card">
                                <div class="card-body row">
                                    <div class="col"> <strong>Thời gian dự tính:</strong> <br><?php echo $deliveryTime; ?> phút </div>
                                    <div class="col"> <strong>Ship bởi:</strong> <br> <?php echo $deliveryBoyName; ?> | <i class="fa fa-phone"></i> <?php echo $deliveryBoyPhoneNo; ?> </div>
                                    <div class="col"> <strong>Ghi chú:</strong> <br> <?php echo $tstatus; ?> </div>
                                    <div class="col"> <strong> #:</strong> <br> <?php echo $trackId; ?> </div>
                                </div>
                            </article>
                            <div class="track">
                            <?php
                                if($status == 0){
                                      echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                            <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng được xác nhận</span> </div>
                                            <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng chuẩn bị vận chuyển</span> </div>
                                            <div class="step"> <span class="icon"> <i class="fa fa-truck"></i> </span> <span class="text">Bánh đang giao! </span> </div>
                                            <div class="step"> <span class="icon"> <i class="fa fa-box"></i> </span> <span class="text">Đã giao hàng</span> </div>';
                                }
                                elseif($status == 1){
                                    echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                          <div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đơn hàng được xác nhận</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng chuẩn bị vận chuyển</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-truck"></i> </span> <span class="text">Bánh đang giao! </span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-box"></i> </span> <span class="text">Đã giao hàng</span> </div>';
                                }
                                elseif($status == 2){
                                    echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                          <div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đơn hàng được xác nhận</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng chuẩn bị vận chuyển</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-truck"></i> </span> <span class="text">Bánh đang giao! </span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-box"></i> </span> <span class="text">Đã giao hàng</span> </div>';
                                }
                                elseif($status == 3){
                                    echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                          <div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đơn hàng được xác nhận</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng chuẩn bị vận chuyển</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-truck"></i> </span> <span class="text">Bánh đang giao! </span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-box"></i> </span> <span class="text">Đã giao hàng</span> </div>';
                                }
                                elseif($status == 4){
                                    echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                          <div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đơn hàng được xác nhận</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng chuẩn bị vận chuyển</span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-truck"></i> </span> <span class="text">Bánh đang giao! </span> </div>
                                          <div class="step"> <span class="icon"> <i class="fa fa-box"></i> </span> <span class="text">Đã giao hàng</span> </div>';
                                } 
                                elseif($status == 5){
                                    echo '<div class="step active"> <span class="icon"> <i class="fa fa-check"></i> </span> <span class="text">Đã chuyển giao</span> </div>
                                          <div class="step deactive"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Từ chối đơn hàng.</span> </div>';
                                }
                                else {
                                    echo '<div class="step deactive"> <span class="icon"> <i class="fa fa-times"></i> </span> <span class="text">Đơn hàng bị hủy.</span> </div>';
                                }
                            ?>
                            </div>
                            <a href="contact.php" class="btn btn-warning" data-abc="true">Trợ giúp <i class="fa fa-chevron-right"></i></a>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    </div>
</div>
<?php
    }
?>

