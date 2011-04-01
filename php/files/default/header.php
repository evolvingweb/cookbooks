<?php
if (extension_loaded('xhprof') && ($_GET['xhprof']==1 || $_POST['xhprof']==1)) {
    include_once '/usr/share/php/xhprof_lib/utils/xhprof_lib.php';
    include_once '/usr/share/php/xhprof_lib/utils/xhprof_runs.php';
    $flags = array(
      XHPROF_FLAGS_CPU,
      XHPROF_FLAGS_MEMORY,
    );
    if (!empty($_GET['xhprof_nobuiltins'])) {
      $flags[] = XHPROF_FLAGS_NO_BUILTINS;
    }
    xhprof_enable(array_sum($flags));
}
