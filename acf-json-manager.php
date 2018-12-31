<?php

/**
 * Plugin Name: ACF JSON Manager
 * Description: Sets up the ACF local JSON feature.
 * Version: 0.1.0
 * Author: James Boynton
 */

namespace Xzito\ACF_JSON;

$autoload_path = __DIR__ . '/vendor/autoload.php';

if (file_exists($autoload_path)) {
  require_once($autoload_path);
}

new AcfJsonManager();
