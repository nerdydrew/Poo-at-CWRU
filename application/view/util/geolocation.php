<?php
  if ($buildings) { ?>
    <table>
  	<thead><th>Nearest Buildings</th><th>Distance</th></thead><tbody>
  	<?php foreach($buildings as $building) { ?>
      <tr>
        <td><a href="/<?php echo $building->slug; ?>"><?php echo $building->name; ?></a></td>
        <td><a href="/<?php echo $building->slug; ?>"><?php echo Helper::distance($building->distance); ?></a></td>
      </tr>
    <?php } ?>
    </tbody></table>
    <?php } else { ?>
    <p class="warning">I can&rsquo;t find any buildings near you.</p>
  <?php }
