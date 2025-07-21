#!/usr/bin/env bash

options=("Compactar diretório" "Remover diretórios '*_compactado' em \$HOME" "Sair")

PS3="Escolha uma opção: "

select opt in "${options[@]}"; do
    case $REPLY in
        1)
            read -p "Digite o diretório que você deseja compactar: " dir

            matches=($(find / -type d -name "$dir" 2>/dev/null))

            if [[ ${#matches[@]} -eq 0 ]]; then
                echo "Nenhum diretório encontrado com o nome '$dir'."
                continue
            fi

            if [[ ${#matches[@]} -gt 1 ]]; then
                echo "Múltiplos diretórios encontrados:"
                for i in "${!matches[@]}"; do
                    echo "[$i] ${matches[$i]}"
                done

                read -p "Escolha o número do diretório que deseja usar: " escolha
                dir_path="${matches[$escolha]}"
            else
                dir_path="${matches[0]}"
            fi

            if [[ -n "$dir_path" ]]; then
                comp_dir="$HOME/$(basename "$dir_path")_compactado"
                mkdir -p "$comp_dir"
                files=("$dir_path"/*)
                for file in "${files[@]}"; do
                    if [[ -f "$file" ]]; then
                        if [[ "$file" == *.tar.gz || "$file" == *.zip || "$file" == *.rar ]]; then
                            echo "Ignorando '$file' (já está compactado)"
                        else
                            tar -czf "$file.tar.gz" "$file" 2> /dev/null
                            echo "Arquivo '$file' compactado como '$file.tar.gz'"
                            mv "$file.tar.gz" "$comp_dir/"
                        fi
                    fi
                done
            else
                echo "Não foi possível encontrar o diretório '$dir'"
            fi
            ;;
        2)
            echo "Removendo diretórios '*_compactado' em $HOME..."
            compactados=("$HOME"/*_compactado)

            if [[ ${#compactados[@]} -eq 0 ]]; then
                echo "Nenhum diretório '*_compactado' encontrado em $HOME."
            else
                for dir_rm in "${compactados[@]}"; do
                    if [[ -d "$dir_rm" ]]; then
                        rm -rf "$dir_rm"
                        echo "Removido: $dir_rm"
                    fi
                done
            fi
            ;;
        3)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done
