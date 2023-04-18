// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

struct User {
    uint id;
    address userAddress;
    string username;
    bool isVerified;
    bool isDeleted;
    uint createDate;
}

struct Tweet {
    uint id;
    string text;
    address authorAddress;
    uint likeCount;
    uint retweetCount;
    uint createDate;
    bool isDeleted;
}

contract TwitterClone {
    // state variables
    uint totalUserCount = 0;
    uint lastUserId = 0;
    uint totalTweetCount = 0;
    uint lastTweetId = 0;

    mapping(address => User) userList;
    mapping(uint => address) userAddressList;

    mapping(uint => Tweet) tweetList;
    mapping(address => uint[]) userTweetIdList;

    mapping(uint => address[]) tweetLikeList;

    // event
    event CreateUser(address _userAddress);
    event UpdateUser(address _userAddress);
    event SoftDeleteUser(address _userAddress);
    event HardDeleteUser(address _userAddress);
    event CreateTweet(uint _id);
    event LikeTweet(uint _id);
    event SoftDeleteTweet(uint _id);
    // modifier
    modifier onlyCurrentUser(address _userAddress) {
        require(
            userList[msg.sender].createDate > 0 && msg.sender == _userAddress,
            "Not allowed"
        );
        _;
    }
    modifier onlyRegisteredUsers() {
        require(
            userList[msg.sender].createDate > 0,
            "User not found, please register first"
        );
        _;
    }
    modifier onlyCreatedTweets(uint _id) {
        require(tweetList[_id].createDate > 0, "Tweet not found");
        _;
    }
    modifier onlyTweetAuthor(uint _id) {
        require(
            msg.sender == tweetList[_id].authorAddress,
            "You must be owner of this tweet"
        );
        _;
    }

    // User functions
    function createUser(string memory _username) public returns (User memory) {
        require(userList[msg.sender].createDate == 0, "This user is exists");
        User memory tempUser;
        tempUser.id = lastUserId;
        tempUser.userAddress = msg.sender;
        tempUser.username = _username;
        tempUser.isVerified = false;
        tempUser.isDeleted = false;
        tempUser.createDate = block.timestamp;
        // save
        userList[msg.sender] = tempUser;
        userAddressList[tempUser.id] = tempUser.userAddress;
        // increasement
        totalUserCount++;
        lastUserId++;
        // emit
        emit CreateUser(tempUser.userAddress);
        // return
        return tempUser;
    }

    function getUser(address _userAddress) public view returns (User memory) {
        return userList[_userAddress];
    }

    function getAllUsers() public view returns (User[] memory) {
        User[] memory tempUsers;
        for (uint i = 0; i < totalUserCount; i++) {
            tempUsers[i] = userList[userAddressList[i]];
        }
        return tempUsers;
    }

    function updateUser(
        address _userAddress,
        string memory _username
    ) public onlyCurrentUser(_userAddress) returns (User memory) {
        userList[_userAddress].username = _username;
        // emit
        emit UpdateUser(_userAddress);
        return userList[_userAddress];
    }

    function softDeleteUser(
        address _userAddress
    ) public onlyCurrentUser(_userAddress) returns (User memory) {
        userList[_userAddress].isDeleted = true;
        // emit
        emit SoftDeleteUser(_userAddress);
        return userList[_userAddress];
    }

    function hardDeleteUser(
        address _userAddress
    ) public onlyCurrentUser(_userAddress) {
        // emit
        emit HardDeleteUser(_userAddress);
        delete userList[_userAddress];
    }

    // Tweet functions
    function createTweet(
        string memory _text
    ) public onlyRegisteredUsers returns (Tweet memory) {
        Tweet memory tempTweet;
        tempTweet.id = lastTweetId;
        tempTweet.text = _text;
        tempTweet.authorAddress = msg.sender;
        tempTweet.likeCount = 0;
        tempTweet.retweetCount = 0;
        tempTweet.createDate = block.timestamp;
        tempTweet.isDeleted = false;
        // save
        tweetList[tempTweet.id] = tempTweet;
        userTweetIdList[msg.sender].push(tempTweet.id);
        // increasements
        lastTweetId++;
        totalTweetCount++;
        // emit
        emit CreateTweet(tempTweet.id);
        // return
        return tempTweet;
    }

    function getTweet(
        uint _id
    ) public view onlyCreatedTweets(_id) returns (Tweet memory) {
        return tweetList[_id];
    }

    function softDeleteTweet(
        uint _id
    )
        public
        onlyCreatedTweets(_id)
        onlyTweetAuthor(_id)
        returns (Tweet memory)
    {
        tweetList[_id].isDeleted = true;
        emit SoftDeleteTweet(_id);
        return tweetList[_id];
    }

    function likeTweet(
        uint _id
    ) public onlyCreatedTweets(_id) onlyRegisteredUsers returns (uint) {
        bool isUserAlreadyLiked = false;
        for (uint i = 0; i < totalTweetCount; i++) {
            if (tweetLikeList[_id][i] == msg.sender) {
                isUserAlreadyLiked = true;
            }
        }
        require(isUserAlreadyLiked, "You can not like again");
        tweetList[_id].likeCount++;
        emit LikeTweet(_id);
        return tweetList[_id].likeCount;
    }

    function getAllTweetsByUserAddress(
        address _userAddress
    ) public view returns (Tweet[] memory) {
        Tweet[] memory tempTweets;
        for (uint i = 0; i < userTweetIdList[_userAddress].length; i++) {
            tempTweets[i] = tweetList[userTweetIdList[_userAddress][i]];
        }
        return tempTweets;
    }
}
