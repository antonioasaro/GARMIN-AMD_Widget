<?PHP

  if (!isset($_GET['stock'])) die();
  $stock = $_GET['stock'];

  $url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=AMD&interval=15min&utputsize=compact&apikey=07MCZQ4M624HQ9TW";
  $contents   = file_get_contents($url);
  $dataarray  = json_decode($contents, true);
  $series     = json_encode($dataarray['Time Series (Daily)']);
  $datafields = split(":", $series);
  $closestart = $datafields[4+0];
  $closeend   = $datafields[4+1];
  $closeprice = split(",", $closeend);

  $stockprice = substr(str_replace("\"", "", $closeprice[0]), 0, -2);
  $results["price"] = $stockprice;
  header('Content-Type: application/json');
  echo json_encode($results);

?>

