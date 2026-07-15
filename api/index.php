<?php

// Buat folder-folder yang dibutuhkan CodeIgniter di dalam /tmp jika belum ada
$writableDirs = ['/tmp/cache', '/tmp/logs', '/tmp/session', '/tmp/debugbar'];
foreach ($writableDirs as $dir) {
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }
}

// Mengarahkan Vercel ke file index utama milik CodeIgniter 4
require __DIR__ . '/../public/index.php';