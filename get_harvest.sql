-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2026 at 05:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `get_harvest`
--

-- --------------------------------------------------------

--
-- Table structure for table `escrow`
--

CREATE TABLE `escrow` (
  `id_escrow` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `jumlah_escrow` int(11) NOT NULL,
  `status` enum('ditahan','dilepas','dikembalikan') DEFAULT 'ditahan',
  `tanggal_ditahan` timestamp NOT NULL DEFAULT current_timestamp(),
  `tanggal_dilepas` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `escrow`
--

INSERT INTO `escrow` (`id_escrow`, `id_pesanan`, `jumlah_escrow`, `status`, `tanggal_ditahan`, `tanggal_dilepas`) VALUES
(1, 1, 80000, 'dilepas', '2026-07-15 13:19:12', '2026-07-15 13:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `nego_harga`
--

CREATE TABLE `nego_harga` (
  `id_nego` int(11) NOT NULL,
  `id_pedagang` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah_kebutuhan_kg` int(11) NOT NULL,
  `harga_tawaran` int(11) NOT NULL,
  `status_nego` enum('Menunggu','Diterima','Ditolak','Dibalas') DEFAULT 'Menunggu',
  `pihak_selanjutnya` enum('petani','pedagang') DEFAULT 'petani',
  `nego_induk` int(11) DEFAULT NULL,
  `tanggal_nego` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id_notif` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pesan` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id_notif`, `id_user`, `judul`, `pesan`, `is_read`, `created_at`) VALUES
(1, 1, 'Pendaftaran Pedagang Baru', 'pedagang mendaftar sebagai pedagang dan menunggu verifikasi Anda.', 0, '2026-07-15 10:34:49'),
(2, 4, 'Akun Disetujui', 'Selamat! Akun pedagang Anda telah diverifikasi. Anda sekarang dapat login dan mulai berbelanja.', 0, '2026-07-15 10:36:24'),
(3, 1, 'Pengajuan Upgrade Premium', 'petani mengajukan upgrade premium paket bulanan.', 0, '2026-07-15 11:14:14'),
(4, 3, 'Upgrade Premium Disetujui', 'Selamat! Akun Anda kini berstatus Premium (bulanan). Nikmati fitur Kalkulator Laba.', 0, '2026-07-15 11:38:07'),
(5, 3, 'Pesanan Baru Sudah Dibayar', 'Pesanan #1 untuk produk \"Jagung\" sejumlah 10 kg telah dibayar. Silakan proses pengemasan.', 0, '2026-07-15 13:19:12'),
(6, 4, 'Pesanan Anda Sedang Dikirim', 'Pesanan #1 sudah dikirim dengan nomor resi 123kunyau. Segera konfirmasi setelah barang diterima.', 0, '2026-07-15 13:20:33'),
(7, 3, 'Dana Escrow Telah Dilepas', 'Pembeli telah mengonfirmasi penerimaan pesanan #1. Dana sebesar Rp80.000 telah diteruskan ke rekening Anda.', 0, '2026-07-15 13:23:46'),
(8, 3, 'Rating Baru Diterima', 'Pedagang memberi rating 5 bintang untuk transaksi \"Jagung\".', 0, '2026-07-15 13:24:15');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran_tani`
--

CREATE TABLE `pengeluaran_tani` (
  `id_pengeluaran` int(11) NOT NULL,
  `id_petani` int(11) NOT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `nominal` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengeluaran_tani`
--

INSERT INTO `pengeluaran_tani` (`id_pengeluaran`, `id_petani`, `kategori`, `keterangan`, `nominal`, `tanggal`) VALUES
(1, 3, 'Pupuk', 'pupus', 500000, '2026-07-15 11:39:02'),
(2, 3, 'Bibit', 'pupus', 30000, '2026-07-15 11:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `permintaan_upgrade`
--

CREATE TABLE `permintaan_upgrade` (
  `id_permintaan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tipe` enum('bulanan','tahunan') NOT NULL,
  `bukti_bayar` varchar(255) DEFAULT NULL,
  `status` enum('Menunggu','Disetujui','Ditolak') DEFAULT 'Menunggu',
  `alasan_tolak` text DEFAULT NULL,
  `tanggal_permintaan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permintaan_upgrade`
--

INSERT INTO `permintaan_upgrade` (`id_permintaan`, `id_user`, `tipe`, `bukti_bayar`, `status`, `alasan_tolak`, `tanggal_permintaan`) VALUES
(1, 3, 'bulanan', '1784114054_bbd41475cf3a8dc28d45.jpg', 'Disetujui', NULL, '2026-07-15 11:14:14');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `id_pedagang` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah_kg` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `status_pengiriman` enum('Menunggu','Dibayar','Dikemas','Dikirim','Selesai','Retur') DEFAULT 'Menunggu',
  `bukti_bayar` varchar(255) DEFAULT NULL,
  `nomor_resi` varchar(50) DEFAULT NULL,
  `metode_pembayaran` enum('transfer_bank','e_wallet') DEFAULT NULL,
  `status_escrow` enum('ditahan','dilepas','dikembalikan') DEFAULT 'ditahan',
  `tanggal_pesan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_pedagang`, `id_produk`, `jumlah_kg`, `total_harga`, `status_pengiriman`, `bukti_bayar`, `nomor_resi`, `metode_pembayaran`, `status_escrow`, `tanggal_pesan`) VALUES
(1, 4, 1, 10, 80000, 'Selesai', '1784121552_5ad6161ae67e810b36c7.jpg', '123kunyau', 'e_wallet', 'dilepas', '2026-07-15 13:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `id_petani` int(11) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `harga_per_kg` int(11) NOT NULL,
  `stok_kg` int(11) NOT NULL,
  `status_panen` enum('Siap Jual','Pre-Order') NOT NULL,
  `tanggal_estimasi_panen` date DEFAULT NULL,
  `gambar_produk` varchar(255) DEFAULT NULL,
  `grade` enum('A','B','C','Organik','Biasa') DEFAULT 'Biasa',
  `sertifikat` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `id_petani`, `nama_produk`, `kategori`, `harga_per_kg`, `stok_kg`, `status_panen`, `tanggal_estimasi_panen`, `gambar_produk`, `grade`, `sertifikat`, `created_at`) VALUES
(1, 3, 'Jagung', 'Sayuran', 8000, 15, 'Siap Jual', NULL, '1784121139_4e0673651c995bebaf06.jpg', 'A', '1784121139_5dc3050cc391be1ecafd.jpg', '2026-07-15 13:12:19');

-- --------------------------------------------------------

--
-- Table structure for table `rating_review`
--

CREATE TABLE `rating_review` (
  `id_rating` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `id_pemberi` int(11) NOT NULL,
  `id_penerima` int(11) NOT NULL,
  `rating` tinyint(1) NOT NULL CHECK (`rating` between 1 and 5),
  `ulasan` text DEFAULT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating_review`
--

INSERT INTO `rating_review` (`id_rating`, `id_pesanan`, `id_pemberi`, `id_penerima`, `rating`, `ulasan`, `tanggal`) VALUES
(1, 1, 4, 3, 5, 'JAGUNGNYA SANGAT BAGUSSS!!!!', '2026-07-15 13:24:15');

-- --------------------------------------------------------

--
-- Table structure for table `rekening`
--

CREATE TABLE `rekening` (
  `id_rekening` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tipe` enum('bank','e_wallet') NOT NULL,
  `nama_bank` varchar(100) DEFAULT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `status_validasi` enum('pending','verified','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rekening`
--

INSERT INTO `rekening` (`id_rekening`, `id_user`, `tipe`, `nama_bank`, `nomor_rekening`, `atas_nama`, `status_validasi`) VALUES
(2, 3, 'e_wallet', 'DANA', '085183992265', 'Petani', 'verified');

-- --------------------------------------------------------

--
-- Table structure for table `rekening_admin`
--

CREATE TABLE `rekening_admin` (
  `id_rekening` int(11) NOT NULL,
  `tipe` enum('bank','e_wallet') NOT NULL,
  `nama_bank` varchar(100) DEFAULT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rekening_admin`
--

INSERT INTO `rekening_admin` (`id_rekening`, `tipe`, `nama_bank`, `nomor_rekening`, `atas_nama`, `created_at`) VALUES
(1, 'bank', 'Bank BCA', '1234567890', 'PT GetHarvest Indonesia', '2026-07-15 00:23:03'),
(2, 'e_wallet', 'OVO', '081234567890', 'PT GetHarvest Indonesia', '2026-07-15 00:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `retur`
--

CREATE TABLE `retur` (
  `id_retur` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `alasan` text NOT NULL,
  `foto_bukti` varchar(255) DEFAULT NULL,
  `status` enum('menunggu','disetujui','ditolak') DEFAULT 'menunggu',
  `tanggal_pengajuan` timestamp NOT NULL DEFAULT current_timestamp(),
  `tanggal_selesai` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id_subscription` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tipe` enum('bulanan','tahunan') NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_akhir` date NOT NULL,
  `status` enum('aktif','kadaluarsa') DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id_subscription`, `id_user`, `tipe`, `tanggal_mulai`, `tanggal_akhir`, `status`) VALUES
(1, 3, 'bulanan', '2026-07-15', '2026-08-15', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('petani','pedagang','admin') NOT NULL,
  `no_hp` varchar(15) NOT NULL,
  `is_premium` tinyint(1) DEFAULT 0,
  `status_verifikasi` enum('pending','disetujui','ditolak') DEFAULT NULL,
  `alamat_toko` varchar(255) DEFAULT NULL,
  `foto_toko` varchar(255) DEFAULT NULL,
  `koordinat` varchar(50) DEFAULT NULL,
  `alasan_tolak` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nama_lengkap`, `alamat`, `email`, `password`, `role`, `no_hp`, `is_premium`, `status_verifikasi`, `alamat_toko`, `foto_toko`, `koordinat`, `alasan_tolak`, `created_at`, `updated_at`) VALUES
(1, 'Administrator GetHarvest', 'Kantor Pusat GetHarvest', 'admin@getharvest.test', '$2y$10$YCT7aravv3/25ZpyK6nFceEfheyPbgDP6/yf1mIUfXPEez1rNhfLW', 'admin', '081234567890', 0, 'disetujui', NULL, NULL, NULL, NULL, '2026-07-15 00:23:03', '2026-07-15 00:23:03'),
(3, 'petani', 'getas', 'petani@gmail.com', '$2y$10$NnH0JpUaW82hxfNu3XMTouo.dPmSC/UnrMXbTFO4y9SWs/Dsxwlia', 'petani', '081234567890', 1, NULL, NULL, NULL, NULL, NULL, '2026-07-15 10:11:11', '2026-07-15 11:38:07'),
(4, 'pedagang', 'bawang', 'pedagang@gmail.com', '$2y$10$HZAnaYDip9xJQDY..sunfePcr3F8Hg98o4.9GJ8RJnGOzPWIL/a4u', 'pedagang', '081234567890', 0, 'disetujui', 'bawang', '1784111689_0dd0b237c2f7eb5b4f43.jpg', '-6.874865,109.665014', NULL, '2026-07-15 10:34:49', '2026-07-15 10:36:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `escrow`
--
ALTER TABLE `escrow`
  ADD PRIMARY KEY (`id_escrow`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `nego_harga`
--
ALTER TABLE `nego_harga`
  ADD PRIMARY KEY (`id_nego`),
  ADD KEY `id_pedagang` (`id_pedagang`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id_notif`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pengeluaran_tani`
--
ALTER TABLE `pengeluaran_tani`
  ADD PRIMARY KEY (`id_pengeluaran`),
  ADD KEY `id_petani` (`id_petani`);

--
-- Indexes for table `permintaan_upgrade`
--
ALTER TABLE `permintaan_upgrade`
  ADD PRIMARY KEY (`id_permintaan`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `id_pedagang` (`id_pedagang`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `id_petani` (`id_petani`);

--
-- Indexes for table `rating_review`
--
ALTER TABLE `rating_review`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_pemberi` (`id_pemberi`),
  ADD KEY `id_penerima` (`id_penerima`);

--
-- Indexes for table `rekening`
--
ALTER TABLE `rekening`
  ADD PRIMARY KEY (`id_rekening`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  ADD PRIMARY KEY (`id_rekening`);

--
-- Indexes for table `retur`
--
ALTER TABLE `retur`
  ADD PRIMARY KEY (`id_retur`),
  ADD KEY `id_pesanan` (`id_pesanan`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id_subscription`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `escrow`
--
ALTER TABLE `escrow`
  MODIFY `id_escrow` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nego_harga`
--
ALTER TABLE `nego_harga`
  MODIFY `id_nego` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id_notif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pengeluaran_tani`
--
ALTER TABLE `pengeluaran_tani`
  MODIFY `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permintaan_upgrade`
--
ALTER TABLE `permintaan_upgrade`
  MODIFY `id_permintaan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rating_review`
--
ALTER TABLE `rating_review`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rekening`
--
ALTER TABLE `rekening`
  MODIFY `id_rekening` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rekening_admin`
--
ALTER TABLE `rekening_admin`
  MODIFY `id_rekening` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `retur`
--
ALTER TABLE `retur`
  MODIFY `id_retur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id_subscription` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `escrow`
--
ALTER TABLE `escrow`
  ADD CONSTRAINT `escrow_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE;

--
-- Constraints for table `nego_harga`
--
ALTER TABLE `nego_harga`
  ADD CONSTRAINT `nego_harga_ibfk_1` FOREIGN KEY (`id_pedagang`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `nego_harga_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pengeluaran_tani`
--
ALTER TABLE `pengeluaran_tani`
  ADD CONSTRAINT `pengeluaran_tani_ibfk_1` FOREIGN KEY (`id_petani`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `permintaan_upgrade`
--
ALTER TABLE `permintaan_upgrade`
  ADD CONSTRAINT `permintaan_upgrade_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_pedagang`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE CASCADE;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_petani`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `rating_review`
--
ALTER TABLE `rating_review`
  ADD CONSTRAINT `rating_review_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `rating_review_ibfk_2` FOREIGN KEY (`id_pemberi`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `rating_review_ibfk_3` FOREIGN KEY (`id_penerima`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `rekening`
--
ALTER TABLE `rekening`
  ADD CONSTRAINT `rekening_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `retur`
--
ALTER TABLE `retur`
  ADD CONSTRAINT `retur_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
