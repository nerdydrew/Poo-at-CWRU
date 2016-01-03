<option value="">Floor&hellip;</option>

<?php
// This is intended to be called from AJAX, passed a building ID and optional selected level,
// and print out a dropdown <select> listing the floors of that building.

if ($floors != null) {
  foreach ($floors as $floor) { ?>
    <option value="<?php echo $floor->id; ?>"><?php echo Helper::floorName($floor->name, $floor->level); ?></option>
  <?php
  }
}
?>
