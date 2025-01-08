-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 08, 2025 at 11:41 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_umahrepair`
--

-- --------------------------------------------------------

--
-- Table structure for table `assign_skill`
--

CREATE TABLE `assign_skill` (
  `id_assignskill` int NOT NULL,
  `id_staff` int NOT NULL,
  `id_skill` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assign_skill`
--

INSERT INTO `assign_skill` (`id_assignskill`, `id_staff`, `id_skill`) VALUES
(1, 3, 1),
(5, 4, 1),
(12, 5, 1),
(2, 3, 2),
(16, 5, 2),
(3, 3, 3),
(6, 4, 3),
(11, 3, 4),
(9, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `assign_staff`
--

CREATE TABLE `assign_staff` (
  `id_assignstaff` int NOT NULL,
  `id_layanan` int NOT NULL,
  `id_staff` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assign_staff`
--

INSERT INTO `assign_staff` (`id_assignstaff`, `id_layanan`, `id_staff`) VALUES
(2, 3, 3),
(1, 3, 4),
(3, 3, 5),
(5, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `benefit`
--

CREATE TABLE `benefit` (
  `id_benefit` int NOT NULL,
  `nama_benefit` varchar(255) NOT NULL,
  `is_delete` enum('yes','no') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `benefit`
--

INSERT INTO `benefit` (`id_benefit`, `nama_benefit`, `is_delete`, `created_at`, `updated_at`) VALUES
(6, 'Menghilangkan noda 99%', 'no', '2024-12-24 14:46:28', '2024-12-24 14:46:28'),
(7, 'Membunuh kuman dan bakteri', 'no', '2024-12-24 14:46:28', '2024-12-24 14:46:28'),
(8, 'Meningkatkan estetika ruang tamu', 'no', '2024-12-24 14:46:28', '2024-12-24 14:46:28'),
(9, 'Proses cepat dan aman', 'no', '2024-12-24 14:46:28', '2024-12-24 14:46:28'),
(10, 'Garansi hasil maksimal', 'no', '2024-12-24 14:46:28', '2024-12-24 14:46:28');

-- --------------------------------------------------------

--
-- Table structure for table `benefit_layanan`
--

CREATE TABLE `benefit_layanan` (
  `id_benefitlayanan` int NOT NULL,
  `id_benefit` int NOT NULL,
  `id_layanan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `benefit_layanan`
--

INSERT INTO `benefit_layanan` (`id_benefitlayanan`, `id_benefit`, `id_layanan`) VALUES
(1, 6, 3),
(7, 6, 4),
(2, 7, 3),
(10, 7, 4),
(3, 8, 3),
(4, 9, 3);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penerima`
--

CREATE TABLE `detail_penerima` (
  `id_transaksi` int NOT NULL,
  `nama_penerima` varchar(255) NOT NULL,
  `no_tlpn` varchar(100) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jadwal` datetime NOT NULL,
  `catatan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detail_penerima`
--

INSERT INTO `detail_penerima` (`id_transaksi`, `nama_penerima`, `no_tlpn`, `alamat`, `jadwal`, `catatan`) VALUES
(2, 'Yudi Artawan', '08888888888', 'Jln Raya Sobangan no 32B Gerang Biru', '2025-01-08 01:29:32', 'Catatan Mini Saja'),
(3, 'Budiman', '08888888888', 'Jln Raya Dukuh no 32B Gerang Biru', '2025-01-08 01:43:29', 'Catatan Mini Saja'),
(4, 'Putri Wahyuni', '05123123', 'Taman Wira Sambangan Blok Cempaka I No. 4', '2025-01-31 00:00:00', 'catatannn'),
(5, 'Siska Jessica', '08888888888', 'Jln Raya Dukuh no 32B Gerang Biru', '2025-01-08 02:44:17', 'Catatan Mini Saja'),
(6, 'Morena Orena', '08888888888', 'Jln Raya Dukuh no 32B Gerang Biru', '2025-01-08 02:45:14', 'Catatan Mini Saja'),
(7, 'Wasudewa', '0712312311231', 'Taman Wira Sambangan Blok Cempaka I No. 4', '2025-01-08 02:47:46', 'testing'),
(8, 'Puspa', '085123123', 'Taman Wira Sambangan Blok Cempaka I No. 4', '2025-01-08 02:59:30', 'null');

-- --------------------------------------------------------

--
-- Table structure for table `layanan`
--

CREATE TABLE `layanan` (
  `id_layanan` int NOT NULL,
  `id_promo` int DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kategori` enum('elektronik','renovasi','kebersihan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `harga` varchar(100) NOT NULL,
  `peralatan` varchar(100) NOT NULL,
  `estimasi` varchar(100) NOT NULL,
  `garansi` varchar(100) NOT NULL,
  `operasional` varchar(100) NOT NULL,
  `img_layanan` tinytext NOT NULL,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `layanan`
--

INSERT INTO `layanan` (`id_layanan`, `id_promo`, `nama`, `deskripsi`, `kategori`, `harga`, `peralatan`, `estimasi`, `garansi`, `operasional`, `img_layanan`, `is_deleted`, `created_at`, `updated_at`) VALUES
(3, 1, 'Perbaikan Kulkas dan Mesin Cuci', 'Perbaikan Kulkas dan Mesin Cuci', 'elektronik', '150000', 'Dari kami', '5 Jam', '10 Hari', '12/7', 'c1434a7b8a6340228674c58a9f35203a_CLIAXusVVXePLhj8PQi1ABb4lKgNlknwSq1YIbBJ.jpg', 'no', '2024-12-24 15:01:25', '2024-12-26 20:49:52'),
(4, 2, 'Perbaikan Dinding dan Platform', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ', 'renovasi', '500000', 'Dari kami', '21 Jam', '30 Hari', '24/7', 'c3054c5b7e4b484daa80b2dbb926287a_cara-memperbaiki-dinding-retak.jpg', 'no', '2024-12-25 05:10:21', '2024-12-26 20:51:23'),
(6, 1, 'Installasi CCTV', 'Pemasangan CCTV biar rumah aman', 'elektronik', '1000000', 'Dari kami', '7 Jam', '30 Hari', '24/7', 'de48f04798b0451996ae853561e97f8b_626b1ce0bb727.jpg', 'no', '2024-12-25 13:20:14', '2024-12-26 20:54:48'),
(7, 1, 'Pembersihan Septic Tank', 'Aman Bersih dari kotoran awet muda', 'kebersihan', '200000', 'Dari anda', '4 Jam', '7 Hari', '12/7', '4f06656d37c44e2f9036428b5287b07c_WhatsApp_Image_2024-11-19_at_21.36.47_eca15e04.jpg', 'no', '2024-12-25 13:24:12', '2024-12-26 20:46:28');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id_member` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `desa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `kecamatan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `kabupaten` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `no_tlpn` varchar(100) NOT NULL,
  `img_member` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id_member`, `email`, `password`, `nama`, `alamat`, `desa`, `kecamatan`, `kabupaten`, `no_tlpn`, `img_member`, `is_deleted`, `created_at`, `updated_at`) VALUES
(2, 'pramana@gmail.com', '$2b$12$.VSivdCo4FYn.FdpAmg//es1vBj3XKjGK7e4Mj6LowERQOIfbiRJ6', 'Pramana Putra', 'Jln sambangan 123', 'Sambangan', 'Sukasada', 'Buleleng', '2341241242', 'default_profile.jpg', 'yes', NULL, NULL),
(5, 'adminkw@gmail.com', '$2b$12$lUJ1VZ8otW4eRsjXAAWQxuseaOxccbwgdJ1QY.kZDvgNHve6jOlZ2', 'Wayan Mie Goreng', 'Jln Udayana 1234444', 'Kali Untu', 'Singaraja', 'Buleleng', '123', NULL, 'yes', NULL, NULL),
(6, 'ari@gmail.com', '$2b$12$NHs5/mn/mN6kGr/tJLop.umir6Aosq0P8nPhcjuEaa.eY0xfNbzCm', 'Made Bakso', 'Jln mengwi 123444', 'Baha', 'Mengwi', 'Badung', '085123123', 'ari.jpg', 'no', NULL, NULL),
(7, 'wayan@gmail.com', '$2b$12$76lhw/COgpqcsf1zoAz1SeIG/WIdWpjBqlMQU9Nh24jvQQ5L4A7xK', 'Wayan Le Mineral', 'Jln Sudirman 666C', 'Werdi Bhuwana', 'Mengwi', 'Badung', '08123123123123', 'default_profile.jpg', 'no', NULL, NULL),
(8, 'made@gmail.com', '$2b$12$NYI9ZMnMYGloA2BKwSrzteROWnzoe0zt2Zh7f7EIc3RSpsuraG2fu', 'Made Nutrisari', 'Jln Antasura 88C Depan SPBU', 'Marga', 'Margarana', 'Tabanan', '8888888888', '1b82b99de5fe4231af24a7f590481440_toa-heftiba-O3ymvT7Wf9U-unsplash.jpg', 'yes', NULL, NULL),
(9, 'komang@gmail.com', '$2b$12$PziA4MYLHbuRTfXf3.mJH.8qqLVq0wl4BOJ4XQXeZIFXzo9iE1pQm', 'Komang Chitato', 'Jln Wismasari 123 BCA', 'Sembung', 'Mengwi', 'Badung', '111111111111', 'default_profile.jpg', 'yes', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `promo`
--

CREATE TABLE `promo` (
  `id_promo` int NOT NULL,
  `nama_promo` varchar(255) NOT NULL,
  `end_promo` datetime NOT NULL,
  `kode_promo` varchar(100) NOT NULL,
  `persen` varchar(100) DEFAULT NULL,
  `fix` varchar(100) DEFAULT NULL,
  `img_promo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `promo`
--

INSERT INTO `promo` (`id_promo`, `nama_promo`, `end_promo`, `kode_promo`, `persen`, `fix`, `img_promo`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'nopromo', '2024-12-31 22:57:53', '123', NULL, NULL, '4f06656d37c44e2f9036428b5287b07c_WhatsApp_Image_2024-11-19_at_21.36.47_eca15e04.jpg', 'no', '2024-12-24 14:57:53', '2024-12-24 14:57:53'),
(2, 'Promo Natal dan Tahun Baru', '2024-12-31 12:12:12', 'ABC123', NULL, '100000', 'promo-banner.jpg', 'no', '2024-12-27 01:15:18', '2024-12-27 01:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `review_layanan`
--

CREATE TABLE `review_layanan` (
  `id_review` int NOT NULL,
  `id_layanan` int NOT NULL,
  `id_member` int NOT NULL,
  `rating` float NOT NULL,
  `komentar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `review_layanan`
--

INSERT INTO `review_layanan` (`id_review`, `id_layanan`, `id_member`, `rating`, `komentar`) VALUES
(1, 4, 5, 4.5, 'Ini bagus oke'),
(2, 4, 5, 4, 'Suka Sekali sama jasa nya');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id_staff` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` tinytext NOT NULL,
  `no_tlpn` varchar(100) NOT NULL,
  `jabatan` enum('Staff','Head Staff') NOT NULL,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'no',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id_staff`, `nama`, `alamat`, `no_tlpn`, `jabatan`, `is_deleted`, `created_at`, `updated_at`) VALUES
(3, 'Obama', 'Jln Pramuka 123 No 123', '087712121212', 'Staff', 'no', '2024-12-22 09:53:49', '2024-12-25 10:52:19'),
(4, 'Joe Tas Lim', 'Jln Abimanyu 123 No 123', '123123123', 'Staff', 'no', '2024-12-22 09:53:49', '2024-12-25 10:53:20'),
(5, 'Mitzuki', 'Jln Kaswari no 77', '0812312312312', 'Staff', 'no', '2024-12-25 11:48:21', '2024-12-25 11:48:21'),
(6, 'Cristiano Ronaldo', 'Jln Gajah Mada 123', '0812312312312', 'Staff', 'no', '2024-12-25 16:15:59', '2024-12-25 16:15:59');

-- --------------------------------------------------------

--
-- Table structure for table `staff_skill`
--

CREATE TABLE `staff_skill` (
  `id_skill` int NOT NULL,
  `nama_skill` varchar(255) NOT NULL,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff_skill`
--

INSERT INTO `staff_skill` (`id_skill`, `nama_skill`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'Cleaning Servicess', 'no', '2024-12-22 09:54:40', '2024-12-22 09:54:40'),
(2, 'Fix Gentengss', 'no', '2024-12-22 09:54:40', '2025-01-08 18:42:38'),
(3, 'Ngecat', 'no', '2024-12-22 09:54:40', '2024-12-22 09:54:40'),
(4, 'Service Kulkas', 'no', NULL, NULL),
(5, 'Perawatan Kebun', 'no', NULL, NULL),
(6, 'Pasang Plaforn', 'no', NULL, NULL),
(7, 'Panjat Pohon', 'no', NULL, NULL),
(8, 'Duduk', 'no', NULL, NULL),
(9, 'Skill Terbang', 'no', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff_transaksi`
--

CREATE TABLE `staff_transaksi` (
  `id_transaksi` int NOT NULL,
  `id_staff` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int NOT NULL,
  `id_member` int NOT NULL,
  `id_layanan` int NOT NULL,
  `no_pesanan` varchar(100) NOT NULL,
  `harga` varchar(100) NOT NULL,
  `ppn` varchar(100) NOT NULL,
  `diskon` varchar(100) NOT NULL,
  `bukti_tf` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_member`, `id_layanan`, `no_pesanan`, `harga`, `ppn`, `diskon`, `bukti_tf`, `created_at`, `updated_at`) VALUES
(2, 6, 4, 'TIX612839', '500000', '60000', '100000', 'img\\321639a55a6d44ad92bb2ae6f44aca37_Four-perspectives-of-balanced-scorecard.png', '2025-01-08 01:29:32', '2025-01-08 01:29:32'),
(3, 6, 4, 'TIX986351', '500000', '60000', '100000', 'bukti_tf.png', '2025-01-08 01:43:29', '2025-01-08 01:43:29'),
(4, 6, 4, 'TIX059877', '500000', '60000', '400000', 'bukti_tf.png', '2025-01-08 02:38:16', '2025-01-08 02:38:16'),
(5, 6, 4, 'TIX543810', '650000', '60000', '100000', 'bukti_tf.png', '2025-01-08 02:44:17', '2025-01-08 02:44:17'),
(6, 6, 4, 'TIX543810', '650000', '60000', '100000', 'bukti_tf.png', '2025-01-08 02:45:14', '2025-01-08 02:45:14'),
(7, 6, 4, 'TIX611822', '500000', '60000', '400000', 'bukti_tf.png', '2025-01-08 02:47:46', '2025-01-08 02:47:46'),
(8, 5, 3, 'TIX428149', '150000', '18000', '0', 'bukti_tf.png', '2025-01-08 02:59:30', '2025-01-08 02:59:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin') NOT NULL,
  `is_deleted` enum('yes','no') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `email`, `password`, `role`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'dummy@gmail.com', '123', 'admin', 'no', '2024-12-24 15:04:49', '2024-12-24 15:04:49'),
(2, 'admin@gmail.com', '$2b$12$lUJ1VZ8otW4eRsjXAAWQxuseaOxccbwgdJ1QY.kZDvgNHve6jOlZ2', 'admin', 'no', '2024-12-25 09:22:38', '2024-12-25 09:22:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_skill`
--
ALTER TABLE `assign_skill`
  ADD PRIMARY KEY (`id_assignskill`),
  ADD UNIQUE KEY `unique_staff_skills` (`id_skill`,`id_staff`),
  ADD KEY `fk_staff` (`id_staff`);

--
-- Indexes for table `assign_staff`
--
ALTER TABLE `assign_staff`
  ADD PRIMARY KEY (`id_assignstaff`),
  ADD UNIQUE KEY `unique_staff_skills` (`id_layanan`,`id_staff`),
  ADD KEY `fk_assignstaff_staff` (`id_staff`);

--
-- Indexes for table `benefit`
--
ALTER TABLE `benefit`
  ADD PRIMARY KEY (`id_benefit`);

--
-- Indexes for table `benefit_layanan`
--
ALTER TABLE `benefit_layanan`
  ADD PRIMARY KEY (`id_benefitlayanan`),
  ADD UNIQUE KEY `unique_benefit_layanan` (`id_benefit`,`id_layanan`),
  ADD KEY `fk_layanan` (`id_layanan`);

--
-- Indexes for table `detail_penerima`
--
ALTER TABLE `detail_penerima`
  ADD KEY `unique_transaksi` (`id_transaksi`) USING BTREE;

--
-- Indexes for table `layanan`
--
ALTER TABLE `layanan`
  ADD PRIMARY KEY (`id_layanan`),
  ADD KEY `fk_promo` (`id_promo`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id_member`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indexes for table `promo`
--
ALTER TABLE `promo`
  ADD PRIMARY KEY (`id_promo`);

--
-- Indexes for table `review_layanan`
--
ALTER TABLE `review_layanan`
  ADD PRIMARY KEY (`id_review`),
  ADD KEY `fk_review_layanan` (`id_layanan`),
  ADD KEY `fk_review_member` (`id_member`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id_staff`);

--
-- Indexes for table `staff_skill`
--
ALTER TABLE `staff_skill`
  ADD PRIMARY KEY (`id_skill`);

--
-- Indexes for table `staff_transaksi`
--
ALTER TABLE `staff_transaksi`
  ADD KEY `index_transaksi` (`id_transaksi`),
  ADD KEY `unique_staff` (`id_staff`) USING BTREE;

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `fk_transaksis_layanan` (`id_layanan`),
  ADD KEY `fk_transaksis_member` (`id_member`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assign_skill`
--
ALTER TABLE `assign_skill`
  MODIFY `id_assignskill` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `assign_staff`
--
ALTER TABLE `assign_staff`
  MODIFY `id_assignstaff` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `benefit`
--
ALTER TABLE `benefit`
  MODIFY `id_benefit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `benefit_layanan`
--
ALTER TABLE `benefit_layanan`
  MODIFY `id_benefitlayanan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `layanan`
--
ALTER TABLE `layanan`
  MODIFY `id_layanan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `promo`
--
ALTER TABLE `promo`
  MODIFY `id_promo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `review_layanan`
--
ALTER TABLE `review_layanan`
  MODIFY `id_review` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id_staff` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `staff_skill`
--
ALTER TABLE `staff_skill`
  MODIFY `id_skill` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_skill`
--
ALTER TABLE `assign_skill`
  ADD CONSTRAINT `fk_skill` FOREIGN KEY (`id_skill`) REFERENCES `staff_skill` (`id_skill`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_staff` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `assign_staff`
--
ALTER TABLE `assign_staff`
  ADD CONSTRAINT `fk_assignstaff_layanan` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assignstaff_staff` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `benefit_layanan`
--
ALTER TABLE `benefit_layanan`
  ADD CONSTRAINT `fk_benefit` FOREIGN KEY (`id_benefit`) REFERENCES `benefit` (`id_benefit`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_layanan` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_penerima`
--
ALTER TABLE `detail_penerima`
  ADD CONSTRAINT `fk_id_transaksi` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `layanan`
--
ALTER TABLE `layanan`
  ADD CONSTRAINT `fk_promo` FOREIGN KEY (`id_promo`) REFERENCES `promo` (`id_promo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `review_layanan`
--
ALTER TABLE `review_layanan`
  ADD CONSTRAINT `fk_review_layanan` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_review_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff_transaksi`
--
ALTER TABLE `staff_transaksi`
  ADD CONSTRAINT `fk_transaksistaff_staff` FOREIGN KEY (`id_staff`) REFERENCES `staff` (`id_staff`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_transaksis_layanan` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaksis_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
