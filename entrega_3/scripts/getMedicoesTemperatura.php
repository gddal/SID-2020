	<?php
	$url="192.168.88.110";
	$database="main"; // Alterar nome da BD se necessario
    $conn = mysqli_connect($url,$_POST['username'],$_POST['password'],$database);
	// Alterar nome da tabela MedicoesSensores, nome dos campos DataHoraMedicao e ValorMedicao, e a sigla do tipo de sensor de temperatura ("TEM") se necessario
	$sql = "SELECT datahora,valor from medicoes where TipoSensor = 'tmp' AND datahora >= now() - interval 5 minute ORDER BY datahora ASC";
	$result = mysqli_query($conn, $sql);
	$response["medicoes"] = array();
	if ($result){
		if (mysqli_num_rows($result)>0){
			while($r=mysqli_fetch_assoc($result)){
				$ad = array();
				// Alterar nome dos campos se necessario
				$ad["ValorMedicao"] = $r['valor'];
				$ad["DataHoraMedicao"] = $r['datahora'];
				array_push($response["medicoes"], $ad);
			}
		}	
	}
	$json = json_encode($response["medicoes"]);
	echo $json;
	mysqli_close ($conn);