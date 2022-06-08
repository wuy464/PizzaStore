<?php 
    $itemModalSql = "SELECT * FROM `orders`";
    $itemModalResult = mysqli_query($conn, $itemModalSql);
    while($itemModalRow = mysqli_fetch_assoc($itemModalResult)){
        $orderid = $itemModalRow['orderId'];
        $userid = $itemModalRow['userId'];
        $orderStatus = $itemModalRow['orderStatus'];
    
?>

<div class="modal fade" id="orderStatus<?php echo $orderid; ?>" tabindex="-1" role="dialog" aria-labelledby="orderStatus<?php echo $orderid; ?>" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: rgb(111 202 203);">
        <h5 class="modal-title" id="orderStatus<?php echo $orderid; ?>">Ghi chú đơn hàng vận chuyển</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="partials/_orderManage.php" method="post" style="border-bottom: 2px solid #dee2e6;">
            <div class="text-left my-2">    
                <b><label for="name">Ghi chú</label></b>
                <div class="row mx-2">
                <input class="form-control col-md-3" id="status" name="status" value="<?php echo $orderStatus; ?>" type="number" min="0" max="6" required>    
                <button type="button" class="btn btn-secondary ml-1" data-container="body" data-toggle="popover" title="User Types" data-placement="bottom" data-html="true" data-content="0=Đơn hàng được chuyển giao.<br> 1=Đơn hàng được xác nhận.<br> 2=Đơn hàng chuẩn bị vận chuyển.<br> 3=Bánh đang giao!<br> 4=Đã giao hàng.<br> 5=Từ chối nhận hàng.<br> 6=Đơn hàng bị hủy.">
                    <i class="fas fa-info"></i>
                </button>
                </div>
            </div>
            <input type="hidden" id="orderId" name="orderId" value="<?php echo $orderid; ?>">
            <button type="submit" class="btn btn-success mb-2" name="updateStatus">Update</button>
        </form>
        <?php 
            $deliveryDetailSql = "SELECT * FROM `deliverydetails` WHERE `orderId`= $orderid";
            $deliveryDetailResult = mysqli_query($conn, $deliveryDetailSql);
            $deliveryDetailRow = mysqli_fetch_assoc($deliveryDetailResult);
            $trackId = isset($deliveryDetailRow['id']) ? $deliveryDetailRow['id'] : '';
            $deliveryBoyName = isset($deliveryDetailRow['deliveryBoyName']) ? $deliveryDetailRow['deliveryBoyName'] : '';
            $deliveryBoyPhoneNo = isset($deliveryDetailRow['deliveryBoyPhoneNo']) ? $deliveryDetailRow['deliveryBoyPhoneNo'] : '';
            $deliveryTime = isset($deliveryDetailRow['deliveryTime']) ? $deliveryDetailRow['deliveryTime'] : '';
            if($orderStatus>0 && $orderStatus<5) { 
        ?>
            <form action="partials/_orderManage.php" method="post">
                <div class="text-left my-2">
                    <b><label for="name">Tên nhân viên giao hàng</label></b>
                    <input class="form-control" id="name" name="name" value="<?php echo $deliveryBoyName; ?>" type="text" required>
                </div>
                <div class="text-left my-2 row">
                    <div class="form-group col-md-6">
                        <b><label for="phone">Số điện thoại</label></b>
                        <input class="form-control" id="phone" name="phone" value="<?php echo $deliveryBoyPhoneNo; ?>" type="tel" required pattern="[0-9]{10}">
                    </div>
                    <div class="form-group col-md-6">
                        <b><label for="catId">Thời gian dự tính</label></b>
                        <input class="form-control" id="time" name="time" value="<?php echo $deliveryTime; ?>" type="number" min="1" max="120" required>
                    </div>
                </div>
                <input type="hidden" id="trackId" name="trackId" value="<?php echo $trackId; ?>">
                <input type="hidden" id="orderId" name="orderId" value="<?php echo $orderid; ?>">
                <button type="submit" class="btn btn-success" name="updateDeliveryDetails">Update</button>
            </form>
        <?php } ?>
      </div>
    </div>
  </div>
</div>

<?php
    }
?>

<style>
    .popover {
        top: -77px !important;
    }
</style>

<script>
    $(function () {
        $('[data-toggle="popover"]').popover();
    });
</script>