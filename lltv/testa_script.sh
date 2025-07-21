#!/bin/bash
if [[ $# -eq 1 ]]; then 
   file_path="$1"
	if [[ -f "$file_path" && -x "$file_path" ]]; then
		echo "O arquivo '$file_path' existe e é executável"
	else 
		echo "O arquivo '$file_path' não existe ou não é executável"
	fi
else
     echo"Uso: $0 <caminho_para_o_arquivo>"
     echo "Este script verifica se o arquivo especificado é executável"
fi
