peer chaincode install -p chaincodedev/chaincode/cc02/ -n mycc -v 0
peer chaincode instantiate  -C myc -c '{"args":["init","a","100","b","200"]}' -v 0 -n mycc