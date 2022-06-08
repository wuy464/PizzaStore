-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2022 at 02:05 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categorieId` int(12) NOT NULL,
  `categorieName` varchar(255) NOT NULL,
  `categorieDesc` text NOT NULL,
  `categorieCreateDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categorieId`, `categorieName`, `categorieDesc`, `categorieCreateDate`) VALUES
(22, 'PIZZA CHAY', 'Pizza chay không những có hương vị thơm ngon như pizza mặn mà lại còn tốt cho sức khỏe hơn đấy', '2022-06-08 03:26:20'),
(23, 'PIZZA MẶN', 'Để nói đến pizza không thể nào không nhắc các loại hương vị mặn (Bò, mực tôm,,,) ngon khó tả, góp làm điểm nhấn chính cho tên lẫn mùi vị pizza)', '2022-06-08 03:31:09'),
(24, 'PIZZA HAWAII', 'Mang hương vị của Hawaii về căn bếp nhà bạn với chiếc pizza Hawaii thơm nức mũi. Màu đỏ của sốt cà chua điểm thêm chút xanh của các loại rau nhìn cực bắt mắt. Sốt cà chua khi nướng lên có mùi hương đặc trưng', '2022-06-08 03:34:41'),
(25, 'PIZZA SANDWICH', 'Biến tấu chiếc bánh sandwich thường ngày của bạn thành chiếc pizza nóng hổi, thơm lừng, cực hấp dẫn thôi nào. Lớp vỏ bánh sandwich khi được nướng lên cực giòn tan, thêm lớp phô mai tan chảy bên trên, mới chỉ nhìn thôi là đã thấy muốn ăn rồi', '2022-06-08 03:39:30'),
(26, 'PIZZA CHẢO', 'Đó là cách “nướng” pizza bằng chảo trên bếp, mang lại một trải nghiệm mới lạ cho người ăn với độ giòn từ vỏ ngon khó tưởng', '2022-06-08 03:45:19'),
(27, 'PIZZA KETO', 'Pizza keto với đế bánh có màu xanh cực bắt mắt sẽ khiến bạn ăn không ngừng. Được làm từ bông cải xanh xay nhuyễn nên khi ăn bạn sẽ cảm nhận được độ tươi ngon, thanh mát', '2022-06-08 03:49:12'),
(28, 'PIZZA PHÔ MAI', 'Pizza bắp phô mai thơm ngon, béo ngậy, lại vô cùng bổ dưỡng khi sử dụng phần nhân hoàn toàn từ rau củ giòn ngọt', '2022-06-08 03:52:15'),
(29, 'PIZZA MÌ TÔM', 'Một chiếc pizza \"đậm chất sinh viên\" đó chính là pizza mì gói. Chỉ với những nguyên liệu cực đơn giản là bạn đã có thể làm ngay món bánh thơm ngon này rồi', '2022-06-08 03:54:15'),
(30, 'ĐỒ UỐNG', 'Nước giải khát cho một bữa tiệc pizza là điều không thể thiếu', '2022-06-08 03:55:23'),
(31, 'TOPPINGS', 'Khách hàng có thể thêm các loại đồ ăn thêm tùy vào sở thích của từng người', '2022-06-08 03:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contactId` int(21) NOT NULL,
  `userId` int(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `phoneNo` bigint(21) NOT NULL,
  `orderId` int(21) NOT NULL DEFAULT 0 COMMENT 'If problem is not related to the order then order id = 0',
  `message` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contactreply`
--

CREATE TABLE `contactreply` (
  `id` int(21) NOT NULL,
  `contactId` int(21) NOT NULL,
  `userId` int(23) NOT NULL,
  `message` text NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `deliverydetails`
--

CREATE TABLE `deliverydetails` (
  `id` int(21) NOT NULL,
  `orderId` int(21) NOT NULL,
  `deliveryBoyName` varchar(35) NOT NULL,
  `deliveryBoyPhoneNo` bigint(25) NOT NULL,
  `deliveryTime` int(200) NOT NULL COMMENT 'Time in minutes',
  `dateTime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `id` int(21) NOT NULL,
  `orderId` int(21) NOT NULL,
  `pizzaId` int(21) NOT NULL,
  `itemQuantity` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`id`, `orderId`, `pizzaId`, `itemQuantity`) VALUES
(1, 1, 1, 1),
(2, 2, 69, 1),
(3, 2, 75, 1),
(4, 2, 79, 1),
(5, 2, 99, 1),
(6, 2, 109, 1),
(7, 2, 110, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(21) NOT NULL,
  `userId` int(21) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zipCode` int(21) NOT NULL,
  `phoneNo` bigint(21) NOT NULL,
  `amount` int(200) NOT NULL,
  `paymentMode` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=cash on delivery, \r\n1=online ',
  `orderStatus` enum('0','1','2','3','4','5','6') NOT NULL DEFAULT '0' COMMENT '0=Order Placed.\r\n1=Order Confirmed.\r\n2=Preparing your Order.\r\n3=Your order is on the way!\r\n4=Order Delivered.\r\n5=Order Denied.\r\n6=Order Cancelled.',
  `orderDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `address`, `zipCode`, `phoneNo`, `amount`, `paymentMode`, `orderStatus`, `orderDate`) VALUES
(2, 2, '1234 Trường Sa, Phân hiệu đại học Thủy Lợi', 114785, 382730455, 52, '0', '0', '2022-06-08 05:20:47');

-- --------------------------------------------------------

--
-- Table structure for table `pizza`
--

CREATE TABLE `pizza` (
  `pizzaId` int(12) NOT NULL,
  `pizzaName` varchar(255) NOT NULL,
  `pizzaPrice` int(12) NOT NULL,
  `pizzaDesc` text NOT NULL,
  `pizzaCategorieId` int(12) NOT NULL,
  `pizzaPubDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pizza`
--

INSERT INTO `pizza` (`pizzaId`, `pizzaName`, `pizzaPrice`, `pizzaDesc`, `pizzaCategorieId`, `pizzaPubDate`) VALUES
(69, 'PIZZA NẤM', 10, 'Khi ăn ta có thể cảm nhận được sự giòn rụm của vỏ bánh, vị béo ngậy của phô mai, vị dai ngọt của nấm và các loại rau củ, tất cả được hòa quyện vô cùng hấp dẫn', 22, '2022-06-08 04:01:16'),
(70, 'PIZZA RAU CỦ', 10, 'Khi ăn ta có thể cảm nhận được vị béo bùi ngọt ngọt của phô mai và đậu hũ, vị chua của cà chua, hấp dẫn không kém gì pizza mặn', 22, '2022-06-08 04:07:03'),
(71, 'PIZZA SỐT CÀ', 10, 'Vị nguyên bản của một pizza ý không thể thiếu được sốt cà nguyên bản tuyệt vời', 22, '2022-06-08 04:09:45'),
(72, 'PIZZA ĐẬU', 10, 'Các loại đậu ngon đốc đáo, tạo ra một chiếc bánh pizza ngon và độc đáo', 22, '2022-06-08 04:12:23'),
(73, 'PIZZA HOA QUẢ', 12, 'Bánh pizza lấy ra từ lò nướng nóng hổi, giòn rụm, mứt và trái cây thì ngọt ngào, hạnh nhân thì bùi bùi, ngậy ngậy, đây chắc chắn là một món ngọt yêu thích của cả nhà', 22, '2022-06-08 04:15:09'),
(74, 'PIZZA KHOAI TÂY', 12, 'Pizza thơm ngon mà không cần đến bột thì chỉ có có thể là pizza khoai tây. Sự kết hợp của khoai tây bùi bùi và trứng béo ngậy đã cho bạn phần đế bánh cực kỳ thơm ngon, lạ miệng', 22, '2022-06-08 04:17:17'),
(75, 'PIZZA HẢI SẢN', 17, 'Đủ loại hải sản cho nền khẩu vị tươi của biển', 23, '2022-06-08 04:20:40'),
(76, 'PIZZA GÀ PHÔ MAI', 16, 'Càng ăn, càng nghiện với món pizza gà phô mai cực kỳ thơm ngon, hấp dẫn này. Đế bánh giòn giòn, nóng hổi kết hợp với sốt cà chua đặc trưng của pizza làm cho chiếc bánh trở nên đậm đà, cuốn hút hơn', 23, '2022-06-08 04:22:53'),
(77, 'PIZZA THỊT NƯỚNG', 18, 'Mùi hương từ thịt nướng sẽ làm bạn không cưỡng lại vẻ đẹp của nó', 23, '2022-06-08 04:24:08'),
(78, 'PIZZA TÔM', 16, 'Cũng là hải sản, nhưng mùi vị tôm sẽ là hương vị thơm ngon đặc trưng cho khách hàng muốn thưởng thức', 23, '2022-06-08 04:25:49'),
(79, 'PIZZA HEO QUAY', 18, 'Cùng với pizza bò, heo quay là mùi vị đã tạo nên thương hiệu cho của hàng', 23, '2022-06-08 04:27:18'),
(80, 'PIZZA THẬP CẨM', 20, 'Kết hợp nguyên liệu từ núi đến biển, tạo ra một chiếc bánh ngon tuyệt', 23, '2022-06-08 04:28:48'),
(81, 'PIZZA ALOHA', 17, 'Đậm hương vị hawaii cùng xúc xích với phô mai béo ngậy', 24, '2022-06-08 04:31:20'),
(82, 'PIZZA THỊT XONG HAWAII', 20, 'Chiếc pizza thơm phức cùng hương vị thịt heo nướng kiểu hawaii', 24, '2022-06-08 04:32:51'),
(83, 'PIZZA THỊT NGUỘI HAWAII', 19, 'Chiếc bánh thịt heo quay nguội thơm phức', 24, '2022-06-08 04:34:26'),
(84, 'PIZZA GÀ NƯỚNG DỨA', 18, 'Dứa cùng thịt gà tạo nên 1 tổ hợp tuyệt vời', 24, '2022-06-08 04:36:10'),
(85, 'PIZZA GÀ NƯỚNG DỨA CAY', 20, 'Vị cay tuyệt cho 2 nguyên liệu hawaii tuyệt vời', 24, '2022-06-08 04:37:55'),
(86, 'PIZZA GÀ NƯỚNG 3 VỊ', 20, 'Vị gà nướng phô mai cùng 3 vụ độc đáo', 24, '2022-06-08 04:39:19'),
(87, 'PIZZA SANDWICH CÀ CHUA', 16, 'Chiếc phô mai sandwich cuàng số cà chua ngon cô cùng', 25, '2022-06-08 04:41:59'),
(88, 'PIZZA SANDWICH XÚC XÍCH', 14, 'Xúc xích trong pizza sandwich ngon tuyệt', 25, '2022-06-08 04:43:49'),
(89, 'PIZZA THANH CUA CAY', 17, 'Vị cay nồng trong thanh cua tạo nên một chiếc bánh pizza ngon thú vị', 26, '2022-06-08 04:46:43'),
(90, 'PIZZA GIĂM BÔNG & THỊT XÔNG KHÓI', 25, 'Chiếc pizza bán chạy nhất trong cửa hàng :)', 26, '2022-06-08 04:48:17'),
(91, 'PIZZA KETO HUẾ', 18, 'Hương vị huế trong 1 chiếc pizza', 27, '2022-06-08 04:50:07'),
(92, 'PIZZA KETO Ý', 17, 'Chiếc bánh pizza keto hương vị nguyên bản ', 27, '2022-06-08 04:51:54'),
(93, 'PIZZA 4 CHESSE', 15, 'Chiếc bánh pizza 4 lớp phô mai cùng xúc xích của Đức', 28, '2022-06-08 04:53:48'),
(94, 'PIZZA GOLDEN 4 CHESSE', 20, 'Chiếc pizza 4 lớp phô mai cao cấp', 28, '2022-06-08 04:55:22'),
(95, 'PIZZA PHÔ MAI', 14, 'Dành cho các thực khách là fan hâm mộ của phô mai', 28, '2022-06-08 04:57:08'),
(96, 'PIZZA HẢI SẢN & ĐÀO', 18, 'Chiếc bánh có quả đào độc lạ cùng hương vị ngon vừa khai trương', 22, '2022-06-08 04:59:11'),
(97, 'PIZZA MÌ ĐẾ MỎNG', 10, 'Mì gói cho pizza đế mỏng', 29, '2022-06-08 05:01:22'),
(98, 'PIZZA MÌ ĐẾ DÀY', 11, 'Chiếc bánh pizza mì tôm đế dày', 29, '2022-06-08 05:03:18'),
(99, 'BIA HELEKEN', 3, 'BIA HELEKEN', 30, '2022-06-08 05:04:58'),
(100, 'BIA 333', 2, 'BIA 333', 30, '2022-06-08 05:05:36'),
(101, 'BLACK PEPSI LON', 2, 'BACK PEPSI', 30, '2022-06-08 05:06:30'),
(102, '7UP 1,5L', 2, '7UP 1,5L', 30, '2022-06-08 05:07:38'),
(103, 'BLACK PEPSI LEMO LON', 2, 'PEPSO LEMO', 30, '2022-06-08 05:08:37'),
(104, 'MIRINDA SODA KEM LON', 2, 'MIRINDA SODA KEM LON', 30, '2022-06-08 05:09:39'),
(105, 'PEPSI LON', 2, 'PEPSI LON', 30, '2022-06-08 05:11:05'),
(106, 'PEPSI 1,5L', 2, 'PEPSI 1,5L', 30, '2022-06-08 05:11:39'),
(107, '7UP LON', 2, '7UP LON', 30, '2022-06-08 05:12:14'),
(108, 'AQUAFINA CHAI', 1, 'AQUAFINA CHAI', 30, '2022-06-08 05:12:51'),
(109, 'PHÔ MAI', 2, 'PHÔ MAI', 31, '2022-06-08 05:16:08'),
(110, 'SỐT CÀ', 2, 'SỐT CÀ', 31, '2022-06-08 05:17:04');

-- --------------------------------------------------------

--
-- Table structure for table `sitedetail`
--

CREATE TABLE `sitedetail` (
  `tempId` int(11) NOT NULL,
  `systemName` varchar(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `contact1` bigint(21) NOT NULL,
  `contact2` bigint(21) DEFAULT NULL COMMENT 'Optional',
  `address` text NOT NULL,
  `dateTime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sitedetail`
--

INSERT INTO `sitedetail` (`tempId`, `systemName`, `email`, `contact1`, `contact2`, `address`, `dateTime`) VALUES
(1, 'SaiGon Pizza', 'nguyenphu2651@gmail.com', 1232828318, 382730455, '127A Ưng Văn Khiêm, p.25, quận Bình Thạnh, tp.HCM', '2021-03-23 19:56:25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(21) NOT NULL,
  `username` varchar(21) NOT NULL,
  `firstName` varchar(21) NOT NULL,
  `lastName` varchar(21) NOT NULL,
  `email` varchar(35) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `userType` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=user\r\n1=admin',
  `password` varchar(255) NOT NULL,
  `joinDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `firstName`, `lastName`, `email`, `phone`, `userType`, `password`, `joinDate`) VALUES
(1, 'admin', 'admin', 'admin', 'admin@gmail.com', 1111111111, '1', '$2y$10$AAfxRFOYbl7FdN17rN3fgeiPu/xQrx6MnvRGzqjVHlGqHAM4d9T1i', '2021-04-11 11:40:58'),
(2, 'nguyenphu12', 'Nguyễn', 'Phú', 'nguyenphu2651@gmail.com', 382730455, '0', '$2y$10$6zEZu.ihuRwmYvZZCvMV..tH5P8KPmFYxzyOtF240PbIX4OAyUK42', '2022-06-07 15:46:27');

-- --------------------------------------------------------

--
-- Table structure for table `viewcart`
--

CREATE TABLE `viewcart` (
  `cartItemId` int(11) NOT NULL,
  `pizzaId` int(11) NOT NULL,
  `itemQuantity` int(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `addedDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categorieId`);
ALTER TABLE `categories` ADD FULLTEXT KEY `categorieName` (`categorieName`,`categorieDesc`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contactId`);

--
-- Indexes for table `contactreply`
--
ALTER TABLE `contactreply`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliverydetails`
--
ALTER TABLE `deliverydetails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orderId` (`orderId`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`);

--
-- Indexes for table `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`pizzaId`);
ALTER TABLE `pizza` ADD FULLTEXT KEY `pizzaName` (`pizzaName`,`pizzaDesc`);

--
-- Indexes for table `sitedetail`
--
ALTER TABLE `sitedetail`
  ADD PRIMARY KEY (`tempId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `viewcart`
--
ALTER TABLE `viewcart`
  ADD PRIMARY KEY (`cartItemId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categorieId` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `contactId` int(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contactreply`
--
ALTER TABLE `contactreply`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliverydetails`
--
ALTER TABLE `deliverydetails`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pizza`
--
ALTER TABLE `pizza`
  MODIFY `pizzaId` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `sitedetail`
--
ALTER TABLE `sitedetail`
  MODIFY `tempId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `viewcart`
--
ALTER TABLE `viewcart`
  MODIFY `cartItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
