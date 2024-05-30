#!/bin/bash

action=$1
pass=false
date=$(date +%d/%m/%Y)
time=$(date +%H%M)
filePath=false
directoryPath=false


if [[ -n $action && -n $2 ]]; then 
	echo "Bienvenid@!"
	pass=true; 
else 
	echo "No se puede ejecutar el comando, faltan argumentos."; 
	exit 0
fi

if [ $1 = "recuperacion" ]; then
	if [[ $2 =~ *.tar ]]; then
		filePath=$(find / -type f -name $2)
	else 	
		filePath=$(find / -type f -name "$2.tar")
	fi
elif [ $1 = "respaldo" ]; then
	file=$2
	directoryName=${file%/}
	directoryPath=$(find / -type d -name $directoryName)
else
	echo "Accion no encontrada:recuperar/respaldo" 
	exit 0
fi

respaldo() {
	tar -cvf respaldo_$(date +%d%m%Y)-$time.tar
	echo -e "Respaldo del directorio : $directoryPath \nElaborado el $date a las $(date +%R)"
}

recuperacion() {
	directoryName=rec$(date +%F)
	mkdir $directoryName
	tar -xvf $filePath -C $directoryName
}

if $directoryPath; then 
	respaldo
	exit 0
else
	echo "Nombre del directorio invalido:Directorio no encontrado"
	echo $directoryPath
	exit 0
fi

if $filePath; then 
	recuperacion
	echo -e "Descompresion del archivo : $filePath \nRealizada el $date a las $(date +%R)"
	exit 0
else
	$(find / -type d -name $2) && echo La ruta proporcionada es un directorio || echo El archivo proporcionado es invalido
	exit 0
fi


