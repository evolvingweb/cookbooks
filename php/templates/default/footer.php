<?php
if (extension_loaded('xhprof') && ($_GET['xhprof'] == 1 || $_POST['xhprof'] == 1)) {
    $profiler_namespace = "<%= @node['hostname'] %>";  // namespace for your application
    $xhprof_data = xhprof_disable();
    $xhprof_runs = new XHProfRuns_Default();
    $run_id = $xhprof_runs->save_run($xhprof_data, $profiler_namespace, date('U'));
 
    // url to the XHProf UI libraries (change the host name and path)
    $profiler_url = sprintf('http://xhprof.%s/index.php?run=%s&source=%s', $profiler_namespace, $run_id, $profiler_namespace);
    echo '<br /><br /><a href="'. $profiler_url .'" target="_blank">Profiler output</a><br /><br />';
}
