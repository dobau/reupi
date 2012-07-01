--Maven e Eclipse
>mkdir ~/projetos

>cd ~/projetos

>mvn archetype:create -DgroupId=br.com.dominio.nome_projeto -DartifactId=nome_projeto -DarchetypeArtifactId=maven-archetype-webapp

>cd nome_projeto

>mvn eclipse:clean

>mvn eclipse:eclipse

>mvn -Dwtpversion=2.0 compile eclipse:eclipse