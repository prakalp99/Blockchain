// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        string content;
        bool completed;
    }

    mapping(address => Task[]) private userTasks;

    function addTask(string memory _content) public {
        userTasks[msg.sender].push(Task({content: _content, completed: false}));
    }

    function toggleCompleted(uint256 _index) public {
        require(_index < userTasks[msg.sender].length, "Task does not exist");
        userTasks[msg.sender][_index].completed = !userTasks[msg.sender][_index].completed;
    }

    function getMyTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }
}