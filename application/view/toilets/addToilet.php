<h1>Add a Restroom</h1>


<form action="/add" method="post">
<dl><dt><label for="buildingDropdown">Location</label></dt>
<dd><select name="building_id" id="buildingDropdown">
  <option>Building&hellip;</option><?php
  foreach ($buildings as $building) { ?>
    <option value="<?php echo $building->id; ?>"<?php
      if (isset($current_building) && $current_building != null
          && $current_building->id == $building->id) {
        echo "selected";
      } ?>><?php
      echo $building->name;
    ?></option>
  <?}
?></select>

<label> &gt;
<select name="floor_id" id="floorDropdown">
  <option value="">Floor&hellip;</option>
  <?php if ($floors != null) {
    foreach ($floors as $floor) { ?>
      <option value="<?php echo $floor->id; ?>"<?php
        if (isset($current_floor) && $current_floor->id == $floor->id) {
          echo " selected";
        }
       ?>><?php echo Helper::floorName($floor->name, $floor->level); ?></option>
    <?php
    }
  } ?>
</select></label> <?php
  if (isset($error['location'])) { ?>
    <span class="error"><?php echo $error['location']; ?></span>
  <?php }
  ?></dd>
</dd>


<dt><label for="name">Name</label></dt>
<dd><input type="text" name="name"<?php if(isset($_POST['name'])) {echo ' value="' . Helper::sanitizeHTML($_POST['name']) . '"';} ?> id="name" />
  <span class="minor">e.g. &ldquo;Across from room 223&rdquo; or &ldquo;Near the stairs&rdquo;</span>
  <?php
    if (isset($error['name'])) { ?>
      <br><span class="error"><?php echo $error['name']; ?></span>
    <?php }
  ?>
  </dd>
</dl>

<dl>
	<dt>Gender</dt>
<dd><label><input type="radio" name="gender" id="male" value="male"<?php if(isset($_POST['gender']) && $_POST['gender'] == 'male') {echo ' checked';} ?>> Male</label>

<dd><label><input type="radio" name="gender" id="female" value="female"<?php if(isset($_POST['gender']) && $_POST['gender'] == 'female') {echo ' checked';} ?>> Female</label></dd>

<dd><label><input type="radio" name="gender" id="other" value="other"<?php if(isset($_POST['gender']) && $_POST['gender'] == 'other') {echo ' checked';} ?>> Any</label>
  <span class="minor">(Some restrooms are not gender-specific.)</span>
</dd>
<?php
  if (isset($error['gender'])) { ?>
    <dd><span class="error"><?php echo $error['gender']; ?></span></dd>
  <?php }
?>
</dl>


Number of&hellip;
<dl class="numbers">
<dt><label for="sinks">Sinks</label></dt> <dd><input type="number" min="0" step="1" id="sinks" name="sinks"<?php if(isset($_POST['sinks'])) {echo ' value="' . Helper::sanitizeHTML($_POST['sinks']) . '"';} ?> /></label>
  <?php if (isset($error['sink'])) { ?>
    <span class="error"><?php echo $error['sink']; ?></span>
  <?php } else { ?>
    <span class="minor">(Leave these fields blank if you don&rsquo;t know)</span>
  <?php } ?>
</dd>


<dt><label for="stalls">Stalls</label></dt> <dd><input type="number" min="0" step="1" id="stalls" name="stalls"<?php if(isset($_POST['stalls'])) {echo ' value="' . Helper::sanitizeHTML($_POST['stalls']) . '"';} ?> />
  <?php
    if (isset($error['stall'])) { ?>
      <span class="error"><?php echo $error['stall']; ?></span>
    <?php }
  ?></dd>


<div id="urinalContainer"><dt><label for="urinals">Urinals</label></dt> <dd><input type="number" min="0" step="1" id="urinals" name="urinals"<?php if(isset($_POST['urinals'])) {echo ' value="' . Helper::sanitizeHTML($_POST['urinals']) . '"';} ?> />
  <?php
    if (isset($error['urinal'])) { ?>
      <span class="error"><?php echo $error['urinal']; ?></span>
    <?php }
  ?></dd></div>
</dl>



<dl>
<dt><label for="comments">Special Comments</label></dt>
	<dd><textarea name="comments" id="comments" placeholder="You will be able to review this restroom later."><?php
		if(isset($_POST['comments'])) {
			echo Helper::sanitizeHTML($_POST['comments']);
		}
			?></textarea><?php
      if (isset($error['comments'])) { ?>
        <br> <span class="error"><?php echo $error['comments']; ?></span>
      <?php } ?></dd>
</dl>


<input type="submit" value="Add Restroom">
</form>

<script src="/public/js/addToilet.js"></script>
