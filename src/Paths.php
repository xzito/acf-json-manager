<?php

namespace Xzito\ACF_JSON;

class Paths {
  private $all = [];

  public static function all() {
    $all = [];

    foreach (self::group_path_mappings() as $map) {
      $all[$map['group']] = $map['path'];
    }

    return $all;
  }

  private static function group_path_mappings() {
    $paths_file = get_template_directory() . '/acf_paths.php';
    $mappings = [];

    if (file_exists($paths_file)) {
      $mappings = require $paths_file;
    }

    return $mappings;
  }
}
