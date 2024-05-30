#!/bin/bash

action=$1
pass=false
date=$(date +%d/%m/%Y)
time=$(date +%H%M)
fileRegPath=false
directoryRegPath=false

if [[ -n $action && -n $2 ]]; then 
	echo "Bienvenid@!"
	pass=true; 
else 
	echo "No se puede ejecutar el comando, faltan argumentos."; 
	exit 0
fi

if [ $1 = "recuperacion" ]; then
	if [[ $2 =~ \.tar$ ]]; then
		filePath=$(find / -type f -name $2)
	else 
		file=$2	
		filePath=$(find / -type f -name ${file}.tar)
	fi
	fileRegPath=true

elif [ $1 = "respaldo" ]; then
	direct=$2
	directoryName=${direct%/}
	directoryPath=$(find / -type d -name $directoryName)
	directoryRegPath=true
else
	echo "Accion no encontrada:recuperar/respaldo" 
	exit 0
fi

respaldo() {
	fileName=respaldo_$(date +%d%m%Y)-$time.tar
	tar -cvf $fileName $directoryPath
	echo -e "Respaldo del directorio : $directoryPath \nElaborado el $date a las $(date +%R) \nGuardado como: $fileName"
	exit 0
}

recuperacion() {
	directoryName=rec$(date +%F)
	mkdir $directoryName
	tar -xvf $filePath -C $directoryName
	echo -e "Descompresion del archivo : $filePath \nRealizada el $date a las $(date +%R) \nGuardado en: $directoryName"
	exit 0
}

if $directoryRegPath ; then
	if [ -n $directoryPath ] ; then 
		respaldo
	else
		echo "Nombre del directorio invalido:Directorio no encontrado"
	fi
	exit 0
fi

if $fileRegPath ; then
	if [ -n $filePath ]; then 
		recuperacion
	else
		$(find / -type d -name $2) && echo El nombre del archivo proporcionado es un directorio || echo El archivo proporcionado es invalido
	fi
	exit 0
fi
