action=$1
pass=false
date=$(date +%d/%m/%Y)
time=$(date +%H%M)

if [[ -n $action && -n $2 ]]; then 
	echo "Bienvenid@!"
	pass=true; 
else 
	echo "No se puede ejecutar el comando, faltan argumentos."; 
	exit 0
fi

if [ $1 = "recuperacion" ]
	if [[ $2 =~ *.tar ]]; then
		filePath=$(find / -type f -name $2)
	else 	
		filePath=$(find / -type f -name "$2.tar")
	fi

elif [ $1 = "respaldo" ]
	directoryPath=$(find / -type d -name $2)
fi

respaldo() {
	tar -cvf respaldo_$(date +%d%m%Y)-$time.tar
	echo -e "Respaldo del directorio $filePath \nElaborado el $date a las $(date +%R)"
}

recuperacion() {
	directoryName=rec$(date +%F)
	mkdir $directoryName
	tar -xvf $2 -e rec $directoryName
}

if $directoryPath; then 
	respaldo
else
	echo "Nombre del directorio invalido:Directorio no encontrado"
fi

if $filePath; then 
	recuperacion
	echo -e "Descompresio del archivo $filePath \nRealizada el $date a las $(date +%R)"
else
	$(find / -type d -name $2) && echo La ruta proporcionada es un directorio || echo El archivo proporcionado es invalido
fi


