<h1><?php
	if (is_null($floor)) {
		echo $building->name;
	} else {
		echo "<a href=\"" . URL . $building_slug . "\">" . Helper::sanitizeHTML($building->name) .
			"</a> &gt; " . Helper::floorName($floor->name, $floor->level);
		}  ?></h1>

<?php if (!empty($toilets)) { ?>
	<table><thead>
		<tr>
			<?php if (is_null($floor)) { ?><th>Floor</th><?php }; ?>
			<th class="optional">Gender</th><th class="optional">Rating</th><th>Restroom Location</th>
		</tr></thead><tbody>
	<?php foreach ($toilets as $toilet) {
		//
		if ($toilet->verified || $is_admin || (Helper::isLoggedIn() && phpCAS::getUser() == $toilet->user)) {
			$url = URL . $toilet->building_slug . '/' . $toilet->floor_slug . '/' . $toilet->slug; ?>
			<tr>
			<?php if (is_null($floor)) { ?><td><a href="<?php echo $url; ?>"><?php echo Helper::floorNameShort($toilet->floor_name, $toilet->level); ?></a></td> <?php }; ?>
			<td><a href="<?php echo $url; ?>"><?php echo Helper::gender($toilet->gender); ?></a></td>
			<td><a href="<?php echo $url; ?>"><?php echo Helper::ratingStarsWithNumberOfRatings($toilet->rating, $toilet->ratings); ?></a></td>
			<td><a href="<?php echo $url; ?>"><?php echo Helper::sanitizeHTML($toilet->name); ?></a></td>
			</tr>
		<?php
		}
	} ?>

	</tbody></table>

	<p>Am I missing a restroom? Please <a href="<?php echo $add_link; ?>">add it here</a>.</p>

<?php } else { ?>
	<p>I don&rsquo;t know of any restrooms here! Would you like to <a href="<?php echo $add_link; ?>">add a restroom</a>?</p>
<?php } ?>
