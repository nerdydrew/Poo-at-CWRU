<section>
<h1 class="headline">Helping you find restrooms <span class="subtitle">that don&rsquo;t stink beyond the possible</span></h1>

<p>Have you ever wanted to keep track of the best and worst restrooms at Case Western Reserve University? Probably not, but now you can. </p>

<div id="geolocation"><p class="warning">If you can read this, your browser may not support JavaScript.</p></div>
</section>

<p>Or, select any building from the dropdowns below:</p>

<section class="half">
  <select onchange="if (this.value) window.location.href=this.value" id="northside">
  <option value="" selected>Buildings north of Euclid&hellip;</option>
  <?php
  foreach($north_buildings as $building) { ?>
    <option value="/<?php echo $building->slug; ?>"><?php echo $building->name; ?></option>
  <?php } ?>
  </select>
</section>

<section class="half">
  <select onchange="if (this.value) window.location.href=this.value" id="southside">
  <option value="" selected>Buildings south of Euclid&hellip;</option>
  <?php
  foreach($south_buildings as $building) { ?>
    <option value="/<?php echo $building->slug; ?>"><?php echo $building->name; ?></option>
  <?php } ?>
  </select>
</section>


<script src="/public/js/location.js"></script>
<script>
	window.onload = getLocation;
	document.getElementById("northside").selectedIndex = 0;
	document.getElementById("southside").selectedIndex = 0;
</script>
