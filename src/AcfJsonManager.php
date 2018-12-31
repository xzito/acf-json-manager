<?php

namespace Xzito\ACF_JSON;

class AcfJsonManager {
  private $groups = [];
  private $group_being_saved;

  public function __construct() {
    add_action('init', [$this, 'define_save_paths'], 0);

    add_filter('acf/settings/load_json', [$this, 'load']);
    add_action('acf/update_field_group', [$this, 'update'], 0);
  }

  public function define_save_paths() {
    $this->groups = Paths::all();
  }

  public function load($paths) {
    foreach ($this->groups as $group => $path) {
      $paths[] = $path;
    }

    return $paths;
  }

  public function update($group) {
    $key = $group['key'];

    if (isset($this->groups[$key])) {
      $this->override_save($key);
    }

    return $group;
  }

  public function override_save_location($path) {
    return $this->groups[$this->group_being_saved];
  }

  private function override_save($key) {
    $this->group_being_saved = $key;

    add_action(
      'acf/settings/save_json',
      [$this, 'override_save_location'],
      PHP_INT_MAX
    );
  }
}
