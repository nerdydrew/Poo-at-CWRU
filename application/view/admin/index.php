<h1>Super Secret Admin Page</h1>

<?php if ($toilets) { ?>
  <h2>Unverified Restrooms</h2>
  <table>
  <thead><th>Gender</th><th>Building</th><th>Floor</th><th>Name</th><th class="verify">Verify</th><th class="delete">Delete</th></thead><tbody>
  <?php foreach($toilets as $toilet) {
    $toilet_url = URL . $toilet->building_slug . '/' . $toilet->floor_slug . '/' . $toilet->slug;
    $verify_url = "/admin/verify/" . $toilet->id;
    $delete_url = "/admin/delete/" . $toilet->id;
    ?>
		<tr>
		<td><a href="<?php echo $toilet_url; ?>"><?php echo Helper::gender($toilet->gender); ?></a></td>
    <td><a href="<?php echo $toilet_url; ?>"><?php echo $toilet->building_name; ?></a></td>
    <td><a href="<?php echo $toilet_url; ?>"><?php echo Helper::floorNameShort($toilet->floor_name, $toilet->level); ?></a></td>
		<td><a href="<?php echo $toilet_url; ?>"><?php echo Helper::sanitizeHTML($toilet->name); ?></a></td>

    <td><a href="<?php echo $verify_url ?>" class="verify">Verify</a></td>
    <td><a href="<?php echo $delete_url ?>" class="delete">Delete</a></td>
		</tr>
  <?php } ?>
  </tbody></table>
  <?php } else { ?>
  <p>All restrooms have been verified.</p>
<?php } ?>
