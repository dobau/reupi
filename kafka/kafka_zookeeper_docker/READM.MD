docker-compose up -d
docker-compose logs zookeeper | grep -i binding
docker-compose logs kafka | grep -i started

# criar tópico
docker-compose exec kafka kafka-topics --create --topic meu-topico-legal --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181

# confirmar criação do tópico
docker-compose exec kafka  kafka-topics --describe --topic meu-topico-legal --zookeeper zookeeper:32181

# produzir mensagem - producer
docker-compose exec kafka bash -c "seq 100 | kafka-console-producer --request-required-acks 1 --broker-list localhost:29092 --topic meu-topico-legal && echo 'Produced 100 messages.'"

# consumir mensagem - consumer
docker-compose exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic meu-topico-legal --from-beginning --max-messages 100
