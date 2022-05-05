contract Property {

    address public seller;

    bool[] public availability;

    uint256 public price;

    constructor(uint256 propertyPrice, uint256[] memory availableWeekNums) {
        seller = msg.sender;
        availability = new bool[](52);
        price = propertyPrice;

        for (uint i=0; i < availableWeekNums.length; i++) {
            require(availableWeekNums[i] >= 1 && availableWeekNums[i] <= 52, "Incorrect week number, expected from 1 to 52");
            availability[availableWeekNums[i] - 1] = true;
    }
}

    function book(uint256 weekNum) public payable{
        require(msg.value >= price, "Not ehoght money");
        require(weekNum >= 1 && weekNum <= 52, "Incorrect week number, expected from 1 to 52");
        require(availability[weekNum - 1], "Requested week is not available");

        availability[weekNum - 1] = false;
        payable (seller).transfer(msg.value);
    }

}
