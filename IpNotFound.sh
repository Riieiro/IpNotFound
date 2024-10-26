#!/bin/bash


#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


#Ctrl+C
trap crtl_c INT
function crtl_c(){
  echo -e "${red}\n\n\t[!]Saliendo...\e[0m"
  rm test.js js &>/dev/null
  exit 1
}


# Banner
function Banner(){
echo -e "${green}
    '||'          '|.   '|'           .   '||''''|                                '||  
     ||  ... ...   |'|   |    ...   .||.   ||  .     ...   ... ...  .. ...      .. ||  
     ||   ||'  ||  | '|. |  .|  '|.  ||    ||''|   .|  '|.  ||  ||   ||  ||   .'  '||  
     ||   ||    |  |   |||  ||   ||  ||    ||      ||   ||  ||  ||   ||  ||   |.   ||  
    .||.  ||...'  .|.   '|   '|..|'  '|.' .||.      '|..|'  '|..'|. .||. ||.  '|..'||. 
          ||                                                                           
         ''''                                                                         

                            ██████         
                          ██      ██       
                         ██        ██        
                         ██        ██       
                         ██        ██       
                       ████████████████    
                      ██████████████████   
                      ████████  ████████         ${yellow}Version:${green} 1.0
                      ███████    ███████         ${yellow}Author:${green} https://github.com/Riieiro
                      ████████  ████████   
                      ████████  ████████   
                      ██████████████████   
                       ████████████████     ${end} "
}


# Help
function helpPanel(){
  Banner
  echo -e  "${green}\n[+] Uso: ${end}"
  echo -e "${green}\n\t-h Mostrar panel de ayuda${end}"
  echo -e "${green}\t-g Entrar en modo guiado${end}"
  echo -e "${green}\t-t Activar servicio tor${end}"
  echo -e "${green}\t-p Configurar servicio proxychains${end}"
  echo -e "${green}\t-b Iniciar navegador con proxychains${end}"
  echo -e "${green}\t-i Revisar IP y localización${end}"
}


# Modo guiado
function GuideMode(){
  clear
  echo -e "${yellow}[${green}+${yellow}] Mostrando opciones disponibles: "
}


# Servicio Tor
function ActivateTor(){
  # Instalar Tor
  clear
  sudo apt install tor &>/dev/null
  # Iniciar servicio tor
  sudo service tor start && echo -e "\n\t${yellow}[${green}+${yellow}]${gray} El servicio ${red}tor${gray} se ha ${green}activado ${gray}correctamente.${end}"
}


# Configurar proxychains
function ActivateProxy(){
  # Instalar Proxy
  clear
  sudo apt install proxychains &>/dev/null
  # Mostrar opciones posibles
  echo -e "\n${yellow}[${green}+${yellow}] ${gray}Mostrando opciones disponibles:${end}"
  echo -e "\n\t${yellow}1. ${gray}Dynamic_chain [${green}Recomendado${gray}]${end}"
  echo -e "\t${yellow}2. ${gray}Stict_chain${end}"
  echo -e "\t${yellow}3. ${gray}Random_chain${end}"
  echo -e "\t${yellow}4. ${gray}Chain_len${end}"
  echo -e -n "\n${yellow}[${green}+${yellow}]${gray} Selecciona una opción: ${end}"
  read ProxyOption
  if [ $ProxyOption -eq 1 ]; then
    echo -e "\n\t${yellow}[${green}+${yellow}]${gray} ${red}Proxychains${gray} se ha ${green}activado ${gray}correctamente.${end}"
    sudo cp Config/dinamic proxychains.conf &>/dev/null
    sudo mv proxychains.conf /etc &>/dev/null
  fi
}


# Iniciar navegador
function StartBrowser(){
  clear
  echo -e "\n${yellow}[${green}+${yellow}] ${gray}Mostrando navegadores disponibles:${end}"
  echo -e "\n\t${yellow}1. ${gray}Firefox${end}"
  echo -e "\t${yellow}2. ${gray}Tor-Launcher${end}"
  echo -e "\t${yellow}3. ${gray}DuckDuckGo${end}"
  echo -e -n "\n${yellow}[${green}+${yellow}]${gray} Selecciona una opción [${yellow}1${gray},${yellow}2${gray},${yellow}3${gray}]: ${end}"
  read Navegador
  if [ $Navegador -eq 1 ]; then
    ActivateTor
    sudo apt install curl &>/dev/null
    echo -e "\n${yellow}[${green}+${yellow}]${gray} Iniciando ${red}Firefox${gray} con ${red}proxychains${end}"
    sudo apt install -y jsbeautifier &>/dev/null
    proxychains curl http://ip-api.com/json/ 2>/dev/null > test.js
    js-beautify test.js | tr -d '""' | tr -d "," | tr -d "{}" | grep -v "ProxyChains" > js
    tope=""
    arg=""
    declare -i contador=1
    echo
    while [ "$tope" != "query" ]; do
      let contador+=1
      tope="$(sed -n ${contador}p js | awk '{print $1}' | tr -d ":")"
      arg="$(sed -n ${contador}p js | awk '{print $2}' | tr -d ":")"
      echo -e "\t${green}${tope} ${red}--> ${gray}${arg}${end}"
    done
    nohup proxychains firefox &>/dev/null &
    rm js test.js
  fi

  if [ $Navegador -eq 2 ]; then
    clear
    sudo apt install torbrowser-launcher -y &>/dev/null
    ActivateTor
    sudo apt install curl &>/dev/null
    echo -e "\n${yellow}[${green}+${yellow}]${gray} Iniciando ${red}Tor Browser${gray} con ${red}proxychains${end}"
    sudo apt install -y jsbeautifier &>/dev/null
    proxychains curl http://ip-api.com/json/ 2>/dev/null > test.js
    js-beautify test.js | tr -d '""' | tr -d "," | tr -d "{}" | grep -v "ProxyChains" > js
    tope=""
    arg=""
    declare -i contador=1
    echo
    while [ "$tope" != "query" ]; do
      let contador+=1
      tope="$(sed -n ${contador}p js | awk '{print $1}' | tr -d ":")"
      arg="$(sed -n ${contador}p js | awk '{print $2}' | tr -d ":")"
      echo -e "\t${green}${tope} ${red}--> ${gray}${arg}${end}"
    done
    nohup torbrowser-launcher &>/dev/null &
    rm js test.js
  fi
  if [ $Navegador -eq 3 ];then
    ActivateTor
    sudo apt install curl &>/dev/null
    echo -e "\n${yellow}[${green}+${yellow}]${gray} Iniciando ${red}DuckDuckGo${gray} con ${red}proxychains${end}"
    sudo apt install -y jsbeautifier &>/dev/null
    proxychains curl http://ip-api.com/json/ 2>/dev/null > test.js
    js-beautify test.js | tr -d '""' | tr -d "," | tr -d "{}" | grep -v "ProxyChains" > js
    tope=""
    arg=""
    declare -i contador=1
    echo
    while [ "$tope" != "query" ]; do
      let contador+=1
      tope="$(sed -n ${contador}p js | awk '{print $1}' | tr -d ":")"
      arg="$(sed -n ${contador}p js | awk '{print $2}' | tr -d ":")"
      echo -e "\t${green}${tope} ${red}--> ${gray}${arg}${end}"
    done
    rm test.js js
    nohup proxychains firefox duckduckgo.com &>/dev/null &
  fi
}



# Revisar Info
function CheckLocation(){
  clear
  sudo service tor start
  sudo apt install tor &>/dev/null
  sudo apt install -y jsbeautifier &>/dev/null
  proxychains curl http://ip-api.com/json/ 2>/dev/null > test.js
  js-beautify test.js | tr -d '""' | tr -d "," | tr -d "{}" | grep -v "ProxyChains" > js
  country=$(grep "country" js | head -n 1 | awk '{print $2}')
  city=$(grep "city" js | head -n 1 | awk '{print $2}')
  codigo_pais=$(grep "countryCode" js | head -n 1 | awk '{print $2}')
  region=$(grep "regionName" js | head -n 1 | awk '{print $2}')
  codigo_postal=$(grep "zip" js | head -n 1 | awk '{print $2}')
  isp=$(grep "isp" js | head -n 1 | tr -d "isp:" | sed 's/^[ \t]*//')
  ip=$(grep "query" js | awk '{print $2}')
  echo -e "\n${yellow}[${green}+${yellow}] ${gray}Mostrando tu localización con ${red}proxychains${yellow}: ${end}"
  echo -e "\n\t${yellow}[${green}+${yellow}] ${green}IP pública${red} --> ${gray}${ip}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}País${red} --> ${gray}${country}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}Código de país${red} --> ${gray}${codigo_pais}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}Ciudad${red} --> ${gray}${city}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}Región${red} --> ${gray}${region}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}Código postal${red} --> ${gray}${codigo_postal}"
  echo -e "\t${yellow}[${green}+${yellow}] ${green}Provedor ISP${red} --> ${gray}${isp}"
}







# Chivatos
declare -i parameter_counter=0


# Getops
while getopts "thgpbil" argumento;do
  case $argumento in
    t) let parameter_counter+=1;;
    g) let parameter_counter+=2;;
    p) let parameter_counter+=3;;
    b) let parameter_counter+=4;;
    i) let parameter_counter+=5;;
    h) ;;
  esac
done
if [ $parameter_counter -eq 1 ]; then 
   ActivateTor
elif [ $parameter_counter -eq 2 ]; then
  GuideMode
elif [ $parameter_counter -eq 3 ]; then
  ActivateProxy
elif [ $parameter_counter -eq 4 ]; then
  StartBrowser
elif [ $parameter_counter -eq 5 ]; then
  CheckLocation
else
  helpPanel
fi
