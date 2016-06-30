<?php

require('../vendor/autoload.php');

if (!defined('APP_ROOT')) {
    define('APP_ROOT', dirname(dirname(__FILE__)));
}

// OLD START
if (!defined('XHPROF_LIB_ROOT')) {
    define('XHPROF_LIB_ROOT', dirname(dirname(__FILE__)) . '/xhprof_lib');
}
require_once (XHPROF_LIB_ROOT . "/config.php");
include_once XHPROF_LIB_ROOT . '/display/xhprof.php';
include (XHPROF_LIB_ROOT . "/utils/common.php");
// OLD END

$loader = new Twig_Loader_Filesystem(APP_ROOT . '/src/views');
$twig = new Twig_Environment($loader, array(
    'debug' => true,
    //'cache' => APP_ROOT . '/var/cache/twig',
    'cache' => false,
));
$twig->addExtension(new Twig_Extension_Debug());

// OLD START
$xhprof_runs_impl = new XHProfRuns_Default();
$last = (isset($_GET['last'])) ?  $_GET['last'] : 100;
$last = (int) $last;
$criteria['order by'] = "timestamp";
$criteria['limit'] = $last;
$resultSet = $xhprof_runs_impl->getRuns($criteria);
$runs = array();
while ($row = XHProfRuns_Default::getNextAssoc($resultSet)) {
    $runs[] = $row;
}
// OLD END

echo $twig->render('index.html.twig', array('runs' => $runs));
