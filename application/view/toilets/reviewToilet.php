<h1>
  <a href="/<?php echo $toilet->building_slug; ?>"><?php echo $toilet->building_name; ?></a> &gt;
  <a href="/<?php echo $toilet->building_slug; ?>/<?php echo $toilet->floor_slug; ?>"><?php echo Helper::floorName($toilet->floor_name, $toilet->level); ?></a> &gt;
  <a href="/<?php echo $toilet->building_slug; ?>/<?php echo $toilet->floor_slug; ?>/<?php echo $toilet->slug; ?>"><?php echo Helper::sanitizeHTML($toilet->name); ?></a> &gt;
  <? echo ($current_review ? "Update" : "Add"); ?> Review
</h1>

<p>Your review is anonymous.</p>

<form action="<?php echo $review_url; ?>" method="post">

  <dl>
    <?php
    foreach (Toilets::$rating_categories as $category) { ?>
      <dt><?php echo $category[0]; ?></dt>
      <dd class="rating">
      <?php if ($category[1] != "overall") { ?>
        <label class="abstain">
          <input type="radio" name="<?php echo $category[1]; ?>" value="" <?php

          if ((isset($_POST[$category[1]]) && $_POST[$category[1]] == null) || // if a value was posted
            ($current_review && $current_review->$category[1] == null)) { // if updating a former review
            echo 'checked ';
          }
          ?>/> N/A
        </label>
      <?php }


      for ($i=5; $i>=1; $i--) { ?>
        <input type="radio"
          name="<?php echo $category[1]; ?>"
          value="<?php echo $i; ?>"
          id="r-<?php echo $category[1]; ?>-<?php echo $i; ?>" class="star"
          <?php
          if ((isset($_POST[$category[1]]) && $_POST[$category[1]] == $i) || // if a value was posted
            ($current_review && $current_review->$category[1] == $i)) {// if updating a former review
            echo 'checked ';
          }
        ?>
        /><label class="star" for="r-<?php echo $category[1]; ?>-<?php echo $i; ?>"><?php echo $i; ?></label>
      <?php
      }
      ?>

      </dd>
      <?php
    }
    ?>
  </dl>


  <?php
    if (isset($error['rating'])) { ?>
      <p class="error"><?php echo $error['rating']; ?></p>
    <?php }
  ?>

  <dl>
    <dt><label for="comments">Comments</label></dt>
    <dd>
      <textarea name="comments" id="comments"><?php
  		if(isset($_POST['comments'])) {
  			echo Helper::sanitizeHTML($_POST['comments']);
  		} elseif ($current_review) {
  			echo Helper::sanitizeHTML($current_review->comments);
  		}
  		?></textarea>
      <?php if (isset($error['comments'])) {
        echo '<br><p class="error">' . $error['comments'] . '</p>';
      }; ?>
    </dd>

  </dl>

  <input type="submit" value="<?php echo ($current_review ? "Update" : "Add"); ?> Review">
</form>
