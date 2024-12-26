-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 24, 2024 at 03:45 PM
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
(2, 3, 2),
(3, 3, 3),
(5, 4, 1),
(6, 4, 3);

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
(1, 3, 4),
(2, 3, 3);

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
(2, 7, 3),
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

-- --------------------------------------------------------

--
-- Table structure for table `layanan`
--

CREATE TABLE `layanan` (
  `id_layanan` int NOT NULL,
  `id_promo` int DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kategori` enum('dapur','toilet') NOT NULL,
  `harga` varchar(100) NOT NULL,
  `peralatan` varchar(100) NOT NULL,
  `estimasi` varchar(100) NOT NULL,
  `garansi` varchar(100) NOT NULL,
  `operasional` varchar(100) NOT NULL,
  `img_layanan` tinytext NOT NULL,
  `is_deleted` enum('yes','no') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `layanan`
--

INSERT INTO `layanan` (`id_layanan`, `id_promo`, `nama`, `deskripsi`, `kategori`, `harga`, `peralatan`, `estimasi`, `garansi`, `operasional`, `img_layanan`, `is_deleted`, `created_at`, `updated_at`) VALUES
(3, 1, 'Perbaikan Kulkas dan Mesin Cuci', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'dapur', '150000', 'Dari Kami', '5 Jam', '10 Hari', '12/7', 'imglayanan.jpg', 'no', '2024-12-24 15:01:25', '2024-12-24 15:01:25');

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
  `img_profile` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'no',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id_member`, `email`, `password`, `nama`, `alamat`, `desa`, `kecamatan`, `kabupaten`, `no_tlpn`, `img_profile`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'ari@gmail.com', 'd58a1a35e01b9a894fae8677c08062ec90f07c91', 'Ari Pramana', NULL, NULL, NULL, NULL, '08123123123', NULL, 'no', '2024-12-22 13:42:23', '2024-12-22 13:42:23'),
(2, 'pramana@gmail.com', '$2b$12$.VSivdCo4FYn.FdpAmg//es1vBj3XKjGK7e4Mj6LowERQOIfbiRJ6', 'Pramana Putra', NULL, NULL, NULL, NULL, '2341241242', NULL, 'no', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `promo`
--

CREATE TABLE `promo` (
  `id_promo` int NOT NULL,
  `nama_promo` varchar(255) NOT NULL,
  `end_promo` datetime NOT NULL,
  `kode_promo` varchar(100) NOT NULL,
  `img_promo` tinytext NOT NULL,
  `is_deleted` enum('yes','no') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `promo`
--

INSERT INTO `promo` (`id_promo`, `nama_promo`, `end_promo`, `kode_promo`, `img_promo`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'nopromo', '2024-12-31 22:57:53', '123', 'imgpromo.jpg', 'no', '2024-12-24 14:57:53', '2024-12-24 14:57:53');

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
  `is_deleted` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id_staff`, `nama`, `alamat`, `no_tlpn`, `jabatan`, `is_deleted`, `created_at`, `updated_at`) VALUES
(3, 'Wayan', 'ABC', '123', 'Staff', 'no', '2024-12-22 09:53:49', '2024-12-22 09:53:49'),
(4, 'Made', 'BCA', '123', 'Staff', 'no', '2024-12-22 09:53:49', '2024-12-22 09:53:49');

-- --------------------------------------------------------

--
-- Table structure for table `staff_skill`
--

CREATE TABLE `staff_skill` (
  `id_skill` int NOT NULL,
  `nama_skill` varchar(255) NOT NULL,
  `is_deleted` enum('yes','no') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff_skill`
--

INSERT INTO `staff_skill` (`id_skill`, `nama_skill`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 'Cleaning Service', 'no', '2024-12-22 09:54:40', '2024-12-22 09:54:40'),
(2, 'Naik Genteng', 'no', '2024-12-22 09:54:40', '2024-12-22 09:54:40'),
(3, 'Ngecat', 'no', '2024-12-22 09:54:40', '2024-12-22 09:54:40');

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
  `no_pesanan` int NOT NULL,
  `harga` varchar(100) NOT NULL,
  `ppn` varchar(100) NOT NULL,
  `diskon` varchar(100) NOT NULL,
  `bukti_tf` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(1, 'dummy@gmail.com', '123', 'admin', 'no', '2024-12-24 15:04:49', '2024-12-24 15:04:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_skill`
--
ALTER TABLE `assign_skill`
  ADD PRIMARY KEY (`id_assignskill`),
  ADD KEY `fk_staff` (`id_staff`),
  ADD KEY `fk_skill` (`id_skill`);

--
-- Indexes for table `assign_staff`
--
ALTER TABLE `assign_staff`
  ADD PRIMARY KEY (`id_assignstaff`),
  ADD KEY `fk_assignstaff_staff` (`id_staff`),
  ADD KEY `fk_assignstaff_layanan` (`id_layanan`);

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
  ADD KEY `fk_layanan` (`id_layanan`),
  ADD KEY `fk_benefit` (`id_benefit`);

--
-- Indexes for table `detail_penerima`
--
ALTER TABLE `detail_penerima`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `unique_transaksi` (`id_transaksi`);

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
  ADD UNIQUE KEY `unique_staff` (`id_staff`),
  ADD KEY `index_transaksi` (`id_transaksi`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `unique_no_pesanan` (`no_pesanan`),
  ADD KEY `fk_transaksi_layanan` (`id_layanan`),
  ADD KEY `fk_transaksi_member` (`id_member`);

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
  MODIFY `id_assignskill` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `assign_staff`
--
ALTER TABLE `assign_staff`
  MODIFY `id_assignstaff` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `benefit`
--
ALTER TABLE `benefit`
  MODIFY `id_benefit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `benefit_layanan`
--
ALTER TABLE `benefit_layanan`
  MODIFY `id_benefitlayanan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `layanan`
--
ALTER TABLE `layanan`
  MODIFY `id_layanan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `promo`
--
ALTER TABLE `promo`
  MODIFY `id_promo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `review_layanan`
--
ALTER TABLE `review_layanan`
  MODIFY `id_review` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id_staff` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `staff_skill`
--
ALTER TABLE `staff_skill`
  MODIFY `id_skill` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `fk_transaksi_layanan` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaksi_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
