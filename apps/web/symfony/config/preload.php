<?php

declare(strict_types=1);

use function Safe\opcache_compile_file;

if (file_exists(dirname(__DIR__) . '/var/cache/prod/App_KernelProdContainer.preload.php')) {
    opcache_compile_file(dirname(__DIR__) . '/var/cache/prod/App_KernelProdContainer.preload.php');
}
