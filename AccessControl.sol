//SPDX-License-Identifier:MIT

pragma solidity ^0.8.9;

contract AccessControl
{
    mapping(bytes32 => mapping(address => bool)) public Roles;

    //  0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //  0xd3294eff6d03b380582a923190307c1d3d3d89061d7bdda4bab17666c9a5393b
    bytes32 private constant MINER = keccak256(abi.encodePacked("MINER"));
    //  0x9667e80708b6eeeb0053fa0cca44e028ff548e2a9f029edfeac87c118b08b7c8
    bytes32 private constant BURNER = keccak256(abi.encodePacked("BURNER"));

    constructor()
    {
        Roles[ADMIN][msg.sender]= true;
    }

    modifier OnlyADMIN
    {
        require(Roles[ADMIN][msg.sender],"Only Admin Role is authorized");
        _;
    }
    modifier OnlyMiner
    {
        require(Roles[MINER][msg.sender],"Only Miner Role is authorized");
        _;
    }
    modifier OnlyBurner
    {
        require(Roles[BURNER][msg.sender],"Only Burner Role is authorized");
        _;
    }

    function _grantRole(bytes32 _Role, address _account) internal virtual OnlyADMIN returns(bool)
    { 
        Roles[_Role][_account] = true;
        return(true);
    }

    function grantRole(bytes32 role, address account) external
    {
        _grantRole(role,account);
    }

    function _RevokeRole(bytes32 _Role, address _account) public virtual OnlyADMIN returns(bool)
    {
        Roles[_Role][_account] = false;
        return(true);
    }

     function RevokeRole(bytes32 role, address account) external
    {
        _RevokeRole(role,account);
    }

}