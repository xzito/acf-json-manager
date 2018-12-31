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
    return [
      'team' => [
        'group' => 'group_5c17ca2630dea',
        'path' => WP_CONTENT_DIR . '/mu-plugins/team/acf-json/',
      ]
    ];
  }
}
