// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./AccessControl.sol";
contract pausable is AccessControl
{
    bool private _pause;
    constructor()
    {
        _pause = false;
    }

    function PauseStatus() public virtual returns(bool)
    {
        return(_pause);
    }
    function PauseContract() public OnlyADMIN
    {
        _pause = true;
    }

    function UnPauseContract() public OnlyADMIN
    {
        _pause = false;
    }
}
 