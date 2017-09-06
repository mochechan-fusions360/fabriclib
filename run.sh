configtxgen --profile TwoOrgsOrderer0Genesis --outputBlock orderer.genesis.block
configtxgen --profile TwoOrgsChannel -outputCreateChannelTx channel -channelID mychannel

peer channel create -o orderer0.fusions360.com:7050 -c mychannel -f channel
peer channel join -o orderer0.fusions360.com:7050 -b mychannel.block # file mychannel.block from output of No.4 line
peer chaincode install -v 1.0 -n cc02 -p github.com/hyperledger/fabric/cc02 

peer chaincode instantiate -o orderer0.fusions360.com:7050 -C mychannel -n cc02 -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OR	('Org1MSP.member','Org2MSP.member')"
# wait 
peer chaincode query -C mychannel -n cc02 -c '{"Args":["query","a"]}' 
peer chaincode invoke -C mychannel -n cc02 -c '{"Args":["invoke","a","b","10"]}' 
peer chaincode query -C mychannel -n cc02 -c '{"Args":["query","a"]}' 



peer channel join -o orderer1.fusions360.com:7050 -b mychannel.block
peer chaincode install -v 1.0 -n cc02 -p github.com/hyperledger/fabric/cc02 
# wait
peer chaincode query -C mychannel -n cc02 -c '{"Args":["query","a"]}' 
peer chaincode invoke -C mychannel -n cc02 -c '{"Args":["invoke","a","b","10"]}' 
peer chaincode instantiate -o orderer1.fusions360.com:7050 -C mychannel -n cc02 -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OR	('Org1MSP.member','Org2MSP.member')"
