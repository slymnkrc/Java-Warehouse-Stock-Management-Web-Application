-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 04 Eyl 2021, 22:32:47
-- Sunucu sürümü: 10.4.20-MariaDB
-- PHP Sürümü: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `depo_project`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `ad_id` int(11) NOT NULL,
  `ad_email` varchar(200) DEFAULT NULL,
  `ad_name` varchar(255) DEFAULT NULL,
  `ad_password` varchar(32) DEFAULT NULL,
  `ad_surname` varchar(255) DEFAULT NULL,
  `ad_username` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`ad_id`, `ad_email`, `ad_name`, `ad_password`, `ad_surname`, `ad_username`) VALUES
(1, 'slymnkrc@mail.com', 'Süleyman', '12345', 'KARACA', 'slymnkrc');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `boxaction`
--

CREATE TABLE `boxaction` (
  `boxAction_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `reciptNo` varchar(255) DEFAULT NULL,
  `pr_id` int(11) DEFAULT NULL,
  `cu_id` int(11) DEFAULT NULL,
  `orderStatus` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `boxaction`
--

INSERT INTO `boxaction` (`boxAction_id`, `amount`, `reciptNo`, `pr_id`, `cu_id`, `orderStatus`) VALUES
(12, 6, '779123545', 4, 8, b'1'),
(13, 10, '782806370', 4, 8, b'1'),
(14, 10, '787061613', 8, 18, b'1'),
(15, 10, '787238198', 8, 8, b'1');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customer`
--

CREATE TABLE `customer` (
  `cu_id` int(11) NOT NULL,
  `cu_address` varchar(500) DEFAULT NULL,
  `cu_code` bigint(20) NOT NULL,
  `cu_company_title` varchar(255) DEFAULT NULL,
  `cu_email` varchar(500) DEFAULT NULL,
  `cu_mobile` varchar(255) DEFAULT NULL,
  `cu_name` varchar(255) DEFAULT NULL,
  `cu_password` varchar(32) DEFAULT NULL,
  `cu_phone` varchar(255) DEFAULT NULL,
  `cu_status` int(11) NOT NULL,
  `cu_surname` varchar(255) DEFAULT NULL,
  `cu_tax_administration` varchar(255) DEFAULT NULL,
  `cu_tax_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `customer`
--

INSERT INTO `customer` (`cu_id`, `cu_address`, `cu_code`, `cu_company_title`, `cu_email`, `cu_mobile`, `cu_name`, `cu_password`, `cu_phone`, `cu_status`, `cu_surname`, `cu_tax_administration`, `cu_tax_number`) VALUES
(8, 'KALAMIŞ/FENERYOLU', 444942903, 'FENERBAHÇE S.K', 'volkan@mail.com', '05369895465', 'Volkan', '123455', '0212109754', 1, 'DEMİREL', 'İSTANBUL', 12312312),
(9, 'KAHVE', 445327263, 'Anonim', 'ali@mail.com', '05966597485', 'Ali', '1231', '02125694896', 2, 'BİLMEM', 'KARTAL', 131231221),
(15, 'Beşiktaş', 455502285, '', 'kemal@mail.com', '05369465321', 'Kemal', 'sadasdasd', '', 2, 'Bilginasd', 'İstanbul', 121232131),
(17, 'uskudar', 455546379, 'Koç', 'burcu@mail.com', '05365568237', 'Burcu', 'asasdasd', '02369561425', 2, 'Koç', 'istanbul', 186765443),
(18, 'Üsküdar', 455665202, 'KRC', 'krc@mail.com', '05643569874', 'Süleyman', '12345', '03549691263', 2, 'KARACA', 'İstanbul', 98745);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(9);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payment`
--

CREATE TABLE `payment` (
  `py_id` int(11) NOT NULL,
  `ba_id` int(11) NOT NULL,
  `cu_id` int(11) NOT NULL,
  `py_DebtAmount` double NOT NULL,
  `py_Detail` varchar(100) DEFAULT NULL,
  `py_PaymentAmount` double NOT NULL,
  `py_RemainAmount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payment`
--

INSERT INTO `payment` (`py_id`, `ba_id`, `cu_id`, `py_DebtAmount`, `py_Detail`, `py_PaymentAmount`, `py_RemainAmount`) VALUES
(4, 12, 8, 240, 'alskd', 130, 110),
(5, 14, 18, 700, 'Sipariş Tamamlandı', 0, 700),
(6, 15, 8, 700, 'ödeme yapıldı', 200, 500);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payout`
--

CREATE TABLE `payout` (
  `po_id` int(11) NOT NULL,
  `po_paymentAmount` double NOT NULL,
  `po_paymentDetail` varchar(255) DEFAULT NULL,
  `po_paymentType` varchar(255) DEFAULT NULL,
  `po_title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payout`
--

INSERT INTO `payout` (`po_id`, `po_paymentAmount`, `po_paymentDetail`, `po_paymentType`, `po_title`) VALUES
(5, 3432, 'asdasda', '3', 'asd'),
(6, 23, 'asdfasd', '2', 'asdfasdf'),
(8, 50, 'yemek', '1', 'Yemek Ücreti');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product`
--

CREATE TABLE `product` (
  `pr_id` int(11) NOT NULL,
  `pr_buy_price` double NOT NULL,
  `pr_code` bigint(20) NOT NULL,
  `pr_detail` varchar(200) DEFAULT NULL,
  `pr_quantity` double DEFAULT NULL,
  `pr_sale_price` double NOT NULL,
  `pr_tax` int(11) DEFAULT NULL,
  `pr_title` varchar(100) DEFAULT NULL,
  `pr_unit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `product`
--

INSERT INTO `product` (`pr_id`, `pr_buy_price`, `pr_code`, `pr_detail`, `pr_quantity`, `pr_sale_price`, `pr_tax`, `pr_title`, `pr_unit`) VALUES
(4, 25, 746638963, '1 Paket 25 kg\'dır.', 500, 40, 3, 'Çimento', 1),
(5, 20, 746667063, 'kürek', 500, 40, 2, 'Kürek', 1),
(6, 15, 746673743, '1 Pakette 5 KG vardır', 1000, 23, 4, 'Alçı', 4),
(8, 50, 746679599, '1 LT dış cephe boyası', 1000, 70, 1, 'Boya', 5),
(9, 5, 608180747, '1 Metre Halat İp ', 10000, 8, 2, 'Halat İp', 3);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ad_id`),
  ADD UNIQUE KEY `UK_lws3ngac6dakyjap6blfitfhe` (`ad_email`);

--
-- Tablo için indeksler `boxaction`
--
ALTER TABLE `boxaction`
  ADD PRIMARY KEY (`boxAction_id`),
  ADD KEY `FKj3rsj6khcc6lqwqvgx71duwvl` (`pr_id`),
  ADD KEY `FKdxw4xdxv710gbfs85hsf7q27o` (`cu_id`);

--
-- Tablo için indeksler `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cu_id`);

--
-- Tablo için indeksler `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`py_id`),
  ADD KEY `FKf4w5q9dl7k8usbjar6hvt06bh` (`ba_id`);

--
-- Tablo için indeksler `payout`
--
ALTER TABLE `payout`
  ADD PRIMARY KEY (`po_id`);

--
-- Tablo için indeksler `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pr_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `ad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `boxaction`
--
ALTER TABLE `boxaction`
  MODIFY `boxAction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Tablo için AUTO_INCREMENT değeri `customer`
--
ALTER TABLE `customer`
  MODIFY `cu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Tablo için AUTO_INCREMENT değeri `payment`
--
ALTER TABLE `payment`
  MODIFY `py_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `product`
--
ALTER TABLE `product`
  MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `boxaction`
--
ALTER TABLE `boxaction`
  ADD CONSTRAINT `FKdxw4xdxv710gbfs85hsf7q27o` FOREIGN KEY (`cu_id`) REFERENCES `customer` (`cu_id`),
  ADD CONSTRAINT `FKj3rsj6khcc6lqwqvgx71duwvl` FOREIGN KEY (`pr_id`) REFERENCES `product` (`pr_id`);

--
-- Tablo kısıtlamaları `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `FKf4w5q9dl7k8usbjar6hvt06bh` FOREIGN KEY (`ba_id`) REFERENCES `boxaction` (`boxAction_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
