pragma solidity >0.8.0;
contract Markplace {
    function sort(uint[] memory arr) public pure  returns (uint[] memory) {
        for (uint i=1;i< arr.length;i++) {
            uint current = arr[i];
            uint k = i;
            while(k > 0 && arr[k-1] > current) {
                arr[k] = arr[k-1];
                k--;
            }
            arr[k] = current;
        }
        return arr;
    }
}
