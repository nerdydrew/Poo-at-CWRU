<h1>
	<a href="/<?php echo $toilet->building_slug; ?>"><?php echo $toilet->building_name; ?></a> &gt;
	<a href="/<?php echo $toilet->building_slug; ?>/<?php echo $toilet->floor_slug; ?>"><?php echo Helper::floorName($toilet->floor_name, $toilet->level); ?></a> &gt;
	<?php echo Helper::sanitizeHTML($toilet->name); ?>
</h1>

<?php
if ($user_has_reviewed) { ?>
	<p>Would you like to <a href="<?php echo $review_URL; ?>">update your review</a>?</p>
<?php } else if ($show_verification_message) { ?>
	<p class="warning">Thank you for adding this restroom! An admin will verify this location before it goes public. No hard feelings. In the meantime, would you like to <a href="<?php echo $review_URL; ?>">add a review</a>?</p>
<?php } else { ?>
	<p>Would you like to <a href="<?php echo $review_URL; ?>">add a review</a>?</p>
<?php } ?>


<section class="left"><dl>
	<dt>Cleanliness</dt> <dd><?php echo Helper::ratingStars($toilet->cleanliness); ?></dd>
	<dt>Location</dt> <dd><?php echo Helper::ratingStars($toilet->location); ?></dd>
	<dt>WiFi</dt> <dd><?php echo Helper::ratingStars($toilet->wifi); ?></dd>
	<dt>Writing</dt> <dd><?php echo Helper::ratingStars($toilet->writing); ?></dd>
	<dt>Traffic</dt> <dd><?php echo Helper::ratingStars($toilet->traffic); ?></dd>
	<dt>Toilet paper</dt> <dd><?php echo Helper::ratingStars($toilet->tp); ?></dd>
	<dt>Overall</dt> <dd><?php echo Helper::ratingStars($toilet->overall); ?></dd>
</dl></section>


<section class="right"><dl>
	<dt>Gender</dt><dd><?php echo Helper::gender($toilet->gender); ?></dd>
	<dt>Sinks</dt><dd><?php echo ($toilet->sinks === null ? '?' : $toilet->sinks); ?></dd>
	<?php if ($toilet->gender == 'male') { ?>
		<dt>Urinals</dt><dd><?php echo ($toilet->urinals === null ? '?' : $toilet->urinals); ?></dd>
	<?php }; ?>
	<dt>Stalls</dt><dd><?php echo ($toilet->stalls === null ? '?' : $toilet->stalls); ?></dd>
	<dt>Reviews</dt><dd><?php echo ($toilet->reviews === null ? '0' : $toilet->reviews); ?></dd>
</dl>
</section>

<div style="clear:both"></div>



<?php if ($toilet->comments != null && trim($toilet->comments) != '') { ?>
	<p>Special comments: <?php echo Helper::sanitizeHTML($toilet->comments); ?></p>
<?php }

	foreach ($reviews as $review) {
		if ($review->comments != null && trim($review->comments) != "") { ?>
			<blockquote<?php

			if ($user_has_reviewed && phpCAS::getUser() == $review->user) {
				echo ' class="yourComment"';
			}
			?>>
				<p><?php echo Helper::sanitizeHTML($review->comments); ?></p>
				<cite><?php echo date('F jS, Y', strtotime($review->datetime)); ?></cite>
			</blockquote>
		<?php
		}
	} ?>
