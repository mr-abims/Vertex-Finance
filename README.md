# Contract Addresses

## Mainnet(Final)

//used for creating new pools for lp tokens like wkd-bnb
### [Wakanda LP Farm Contract](https://bscscan.com/address/0x24c2a03C96E3Fb67D4eA13B802cFe5a122A86843)

[Source](./src/farm/WKLDLPPool.sol)

//used for creating staking pools for other tokens
### [General Staking Pool Factory](https://bscscan.com/address/0xcd7e124aa13fe4adc38bc291b8e7b6d15f4b5bd5#code)
[Source](./src/farms/GeneralPoolFactory.sol)

//single pool used for staking and earning wakanda
### [WKD-WKD Single Staking Pool](https://bscscan.com/address/0xb0c95c9AeC13ba330bA9f85177673eD03C05A9Cc)
[Source](./src/farm/GenericStake.sol)
 pool used for staking and earning wakanda
### [WKD-WKD Single Staking Pool](https://bscscan.com/address/0xb0c95c9AeC13ba330bA9f85177673eD03C05A9Cc)
[Source](./src/farm/GenericStake.sol)
## Testnet

### [Router Contract](https://testnet.bscscan.com/address/0xd97ECf01cd2C2f7F38999f2585483bb3A09139eF)
[Source](./src/swap//Router.sol)

### [Pair Contract](https://testnet.bscscan.com/address/0x6a506e21090690facc73c76e34756fcf7a04f4ac)
[Source](./src/swap/Wakanda_pair.sol)


# Deployment and Tests

See [MakeFile](./Makefile) for commands


