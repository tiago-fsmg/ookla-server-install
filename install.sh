clear

echo "#######################################################"
echo "#######################################################"
echo "######## Iniciando Instalacao Servidor Ookla ##########"
echo "#######################################################"
echo "#######################################################"
echo "####################### Tiago Oliveira da Fonseca #####"
echo "#### CentOS 7 #########################################"
echo "#######################################################"

sleep 10s

clear 

echo "#############################################"
echo "########## Instalando Atualizacoes ##########"
echo "#############################################"
sleep 5s

	yum update -y
	
clear 

echo "#############################################"
echo "########## Instalando Dependencias ##########" 
echo "#############################################"

sleep 5s 
	
	yum install httpd -y
	yum install php php-fpm php-apc php-cli php-common php-pdo -y
	yum install unzip -y
	yum install net-tools -y
	yum install wget -y
	yum remove vi -y
	yum install vim -y

clear

echo "##################################################"
echo "########## Configurando as Dependencias ##########"
echo "##################################################"

sleep 5s

	firewall-cmd --permanent --zone=public --add-port=80/tcp
	firewall-cmd --permanent --zone=public --add-port=8080/tcp
	firewall-cmd --reload
	systemctl start httpd
	systemctl start php-fpm
	systemctl enable php-fpm
	systemctl enable httpd
	
	
sleep 10s
clear 

echo "##########################################################"
echo "########## Baixando e Instalando Servidor Ookla ##########"
echo "##########################################################"

sleep 5s
	
	cd /
	mkdir ookla
	cd /ookla
	wget http://install.speedtest.net/ooklaserver/ooklaserver.sh
	chmod a+x /ookla/ooklaserver.sh
	/ookla/ooklaserver.sh install
	/ookla/ooklaserver.sh start
	echo /ookla/OoklaServer --daemon >> /etc/rc.d/rc.local
	chmod a+x /etc/rc.d/rc.local
	echo OoklaServer.allowedDomains = *.ookla.com, *.speedtest.net >> "/ookla/OoklaServer.properties"

clear 

echo "#####################################################"
echo "########## Instalando HTTP Legacy Fallback ##########"
echo "#####################################################"

sleep 5s 


	cd /var/www/html
	wget https://support.ookla.com/hc/en-us/article_attachments/216755848/crossdomain.xml
	wget http://cdn.speedtest.speedtest.net/http_legacy_fallback.zip
	unzip http_legacy_fallback.zip
	rm http_legacy_fallback.zip
	cd speedtest/
	rm upload.aspx upload.asp upload.jsp
	cp /var/www/html/speedtest/* /var/www/html/
	rm -rf /var/www/html/speedtest
	chown apache:apache /var/www/html
	chmod -R 755 /var/www

	
clear

echo "###########################################"
echo "###########################################"
echo "########## Instalacao Finalizada ##########"
echo "####### O Servidor sera Reiniciado ########" 
echo "###########################################"
echo "###########################################"
echo ""
echo ""
echo "Aguarde..."

sleep 10s

reboot 
